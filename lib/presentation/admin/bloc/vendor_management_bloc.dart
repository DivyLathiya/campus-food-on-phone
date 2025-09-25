import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/domain/entities/enhanced_vendor_entity.dart';
import 'package:campus_food_app/domain/repositories/vendor_repository.dart';
import 'package:campus_food_app/presentation/admin/bloc/vendor_management_event.dart';
import 'package:campus_food_app/presentation/admin/bloc/vendor_management_state.dart';

class VendorManagementBloc extends Bloc<VendorManagementEvent, VendorManagementState> {
  final VendorRepository vendorRepository;

  VendorManagementBloc({required this.vendorRepository}) : super(const VendorManagementInitial()) {
    on<LoadVendors>(_onLoadVendors);
    on<LoadVendorDetails>(_onLoadVendorDetails);
    on<ApproveVendor>(_onApproveVendor);
    on<RejectVendor>(_onRejectVendor);
    on<SuspendVendor>(_onSuspendVendor);
    on<ReactivateVendor>(_onReactivateVendor);
    on<VerifyKYC>(_onVerifyKYC);
    on<RejectKYC>(_onRejectKYC);
    on<UpdateVendorStatus>(_onUpdateVendorStatus);
    on<SearchVendors>(_onSearchVendors);
    on<ExportVendorsData>(_onExportVendorsData);
    on<RefreshVendors>(_onRefreshVendors);
  }

  Future<void> _onLoadVendors(
    LoadVendors event,
    Emitter<VendorManagementState> emit,
  ) async {
    emit(const VendorManagementLoading());
    
    try {
      List<EnhancedVendorEntity> vendors;
      
      if (event.status != null) {
        vendors = await vendorRepository.getEnhancedVendorsByStatus(event.status!);
      } else if (event.kycStatus != null) {
        vendors = await vendorRepository.getVendorsByKYCStatus(event.kycStatus!);
      } else {
        vendors = await vendorRepository.getAllEnhancedVendors();
      }

      final pendingVendors = vendors.where((v) => v.isPendingApproval).toList();
      final approvedVendors = vendors.where((v) => v.isActive).toList();
      final rejectedVendors = vendors.where((v) => v.status == 'rejected').toList();
      final suspendedVendors = vendors.where((v) => v.status == 'suspended').toList();

      final vendorStats = {
        'total': vendors.length,
        'pending': pendingVendors.length,
        'approved': approvedVendors.length,
        'rejected': rejectedVendors.length,
        'suspended': suspendedVendors.length,
        'kyc_pending': vendors.where((v) => v.isKycPending).length,
        'kyc_verified': vendors.where((v) => v.isKycVerified).length,
        'kyc_rejected': vendors.where((v) => v.isKycRejected).length,
      };

      emit(VendorsLoaded(
        vendors: vendors,
        pendingVendors: pendingVendors,
        approvedVendors: approvedVendors,
        rejectedVendors: rejectedVendors,
        suspendedVendors: suspendedVendors,
        vendorStats: vendorStats,
      ));
    } catch (e) {
      emit(VendorOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadVendorDetails(
    LoadVendorDetails event,
    Emitter<VendorManagementState> emit,
  ) async {
    try {
      final vendor = await vendorRepository.getEnhancedVendorById(event.vendorId);
      
      if (vendor != null) {
        emit(VendorDetailsLoaded(vendor: vendor));
      } else {
        emit(const VendorOperationFailure(error: 'Vendor not found'));
      }
    } catch (e) {
      emit(VendorOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onApproveVendor(
    ApproveVendor event,
    Emitter<VendorManagementState> emit,
  ) async {
    try {
      final currentVendor = await vendorRepository.getEnhancedVendorById(event.vendorId);
      
      if (currentVendor != null) {
        final updatedVendor = currentVendor.copyWith(
          status: 'open',
          kycStatus: 'verified',
          kycVerifiedAt: DateTime.now().toIso8601String(),
          isComplianceChecked: true,
          complianceCheckedAt: DateTime.now().toIso8601String(),
          complianceCheckedBy: event.approvedBy,
        );

        final result = await vendorRepository.updateEnhancedVendor(updatedVendor);
        
        emit(VendorOperationSuccess(
          message: 'Vendor approved successfully',
          vendor: result,
        ));

        // Reload vendors list
        add(const LoadVendors());
      } else {
        emit(const VendorOperationFailure(error: 'Vendor not found'));
      }
    } catch (e) {
      emit(VendorOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onRejectVendor(
    RejectVendor event,
    Emitter<VendorManagementState> emit,
  ) async {
    try {
      final currentVendor = await vendorRepository.getEnhancedVendorById(event.vendorId);
      
      if (currentVendor != null) {
        final updatedVendor = currentVendor.copyWith(
          status: 'rejected',
          kycStatus: 'rejected',
          kycRejectedAt: DateTime.now().toIso8601String(),
          kycRejectedReason: event.rejectionReason,
        );

        final result = await vendorRepository.updateEnhancedVendor(updatedVendor);
        
        emit(VendorOperationSuccess(
          message: 'Vendor rejected successfully',
          vendor: result,
        ));

        // Reload vendors list
        add(const LoadVendors());
      } else {
        emit(const VendorOperationFailure(error: 'Vendor not found'));
      }
    } catch (e) {
      emit(VendorOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onSuspendVendor(
    SuspendVendor event,
    Emitter<VendorManagementState> emit,
  ) async {
    try {
      final currentVendor = await vendorRepository.getEnhancedVendorById(event.vendorId);
      
      if (currentVendor != null) {
        final updatedVendor = currentVendor.copyWith(
          status: 'suspended',
        );

        final result = await vendorRepository.updateEnhancedVendor(updatedVendor);
        
        emit(VendorOperationSuccess(
          message: 'Vendor suspended successfully',
          vendor: result,
        ));

        // Reload vendors list
        add(const LoadVendors());
      } else {
        emit(const VendorOperationFailure(error: 'Vendor not found'));
      }
    } catch (e) {
      emit(VendorOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onReactivateVendor(
    ReactivateVendor event,
    Emitter<VendorManagementState> emit,
  ) async {
    try {
      final currentVendor = await vendorRepository.getEnhancedVendorById(event.vendorId);
      
      if (currentVendor != null) {
        final updatedVendor = currentVendor.copyWith(
          status: 'open',
        );

        final result = await vendorRepository.updateEnhancedVendor(updatedVendor);
        
        emit(VendorOperationSuccess(
          message: 'Vendor reactivated successfully',
          vendor: result,
        ));

        // Reload vendors list
        add(const LoadVendors());
      } else {
        emit(const VendorOperationFailure(error: 'Vendor not found'));
      }
    } catch (e) {
      emit(VendorOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onVerifyKYC(
    VerifyKYC event,
    Emitter<VendorManagementState> emit,
  ) async {
    try {
      final currentVendor = await vendorRepository.getEnhancedVendorById(event.vendorId);
      
      if (currentVendor != null) {
        final updatedVendor = currentVendor.copyWith(
          kycStatus: 'verified',
          kycVerifiedAt: DateTime.now().toIso8601String(),
          isComplianceChecked: true,
          complianceCheckedAt: DateTime.now().toIso8601String(),
          complianceCheckedBy: event.verifiedBy,
        );

        final result = await vendorRepository.updateEnhancedVendor(updatedVendor);
        
        emit(VendorOperationSuccess(
          message: 'KYC verified successfully',
          vendor: result,
        ));

        // Reload vendors list
        add(const LoadVendors());
      } else {
        emit(const VendorOperationFailure(error: 'Vendor not found'));
      }
    } catch (e) {
      emit(VendorOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onRejectKYC(
    RejectKYC event,
    Emitter<VendorManagementState> emit,
  ) async {
    try {
      final currentVendor = await vendorRepository.getEnhancedVendorById(event.vendorId);
      
      if (currentVendor != null) {
        final updatedVendor = currentVendor.copyWith(
          kycStatus: 'rejected',
          kycRejectedAt: DateTime.now().toIso8601String(),
          kycRejectedReason: event.rejectionReason,
        );

        final result = await vendorRepository.updateEnhancedVendor(updatedVendor);
        
        emit(VendorOperationSuccess(
          message: 'KYC rejected successfully',
          vendor: result,
        ));

        // Reload vendors list
        add(const LoadVendors());
      } else {
        emit(const VendorOperationFailure(error: 'Vendor not found'));
      }
    } catch (e) {
      emit(VendorOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onUpdateVendorStatus(
    UpdateVendorStatus event,
    Emitter<VendorManagementState> emit,
  ) async {
    try {
      final currentVendor = await vendorRepository.getEnhancedVendorById(event.vendorId);
      
      if (currentVendor != null) {
        final updatedVendor = currentVendor.copyWith(
          status: event.status,
        );

        final result = await vendorRepository.updateEnhancedVendor(updatedVendor);
        
        emit(VendorOperationSuccess(
          message: 'Vendor status updated successfully',
          vendor: result,
        ));

        // Reload vendors list
        add(const LoadVendors());
      } else {
        emit(const VendorOperationFailure(error: 'Vendor not found'));
      }
    } catch (e) {
      emit(VendorOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onSearchVendors(
    SearchVendors event,
    Emitter<VendorManagementState> emit,
  ) async {
    try {
      final allVendors = await vendorRepository.getAllEnhancedVendors();
      
      final filteredVendors = allVendors.where((vendor) {
        final query = event.query.toLowerCase();
        final matchesName = vendor.name.toLowerCase().contains(query);
        final matchesDescription = vendor.description.toLowerCase().contains(query);
        final matchesLocation = vendor.location?.toLowerCase().contains(query) ?? false;
        final matchesOwner = vendor.ownerId?.toLowerCase().contains(query) ?? false;
        
        return matchesName || matchesDescription || matchesLocation || matchesOwner;
      }).toList();

      emit(VendorsFiltered(
        filteredVendors: filteredVendors,
        filter: event.query,
      ));
    } catch (e) {
      emit(VendorOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onExportVendorsData(
    ExportVendorsData event,
    Emitter<VendorManagementState> emit,
  ) async {
    try {
      await vendorRepository.getAllVendors();
      
      // Mock export functionality
      final downloadUrl = '/api/exports/vendors.${event.format}?timestamp=${DateTime.now().millisecondsSinceEpoch}';
      
      emit(VendorDataExported(
        downloadUrl: downloadUrl,
        format: event.format,
      ));
    } catch (e) {
      emit(VendorOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onRefreshVendors(
    RefreshVendors event,
    Emitter<VendorManagementState> emit,
  ) async {
    add(const LoadVendors());
  }
}
