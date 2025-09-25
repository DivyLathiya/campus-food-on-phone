import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/enhanced_vendor_entity.dart';

abstract class VendorManagementState extends Equatable {
  const VendorManagementState();

  @override
  List<Object?> get props => [];
}

class VendorManagementInitial extends VendorManagementState {
  const VendorManagementInitial();
}

class VendorManagementLoading extends VendorManagementState {
  const VendorManagementLoading();
}

class VendorsLoaded extends VendorManagementState {
  final List<EnhancedVendorEntity> vendors;
  final List<EnhancedVendorEntity> pendingVendors;
  final List<EnhancedVendorEntity> approvedVendors;
  final List<EnhancedVendorEntity> rejectedVendors;
  final List<EnhancedVendorEntity> suspendedVendors;
  final Map<String, int> vendorStats;

  const VendorsLoaded({
    required this.vendors,
    required this.pendingVendors,
    required this.approvedVendors,
    required this.rejectedVendors,
    required this.suspendedVendors,
    required this.vendorStats,
  });

  @override
  List<Object?> get props => [
        vendors,
        pendingVendors,
        approvedVendors,
        rejectedVendors,
        suspendedVendors,
        vendorStats,
      ];
}

class VendorDetailsLoaded extends VendorManagementState {
  final EnhancedVendorEntity vendor;

  const VendorDetailsLoaded({required this.vendor});

  @override
  List<Object?> get props => [vendor];
}

class VendorOperationSuccess extends VendorManagementState {
  final String message;
  final EnhancedVendorEntity? vendor;

  const VendorOperationSuccess({required this.message, this.vendor});

  @override
  List<Object?> get props => [message, vendor];
}

class VendorOperationFailure extends VendorManagementState {
  final String error;

  const VendorOperationFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class VendorsFiltered extends VendorManagementState {
  final List<EnhancedVendorEntity> filteredVendors;
  final String filter;

  const VendorsFiltered({
    required this.filteredVendors,
    required this.filter,
  });

  @override
  List<Object?> get props => [filteredVendors, filter];
}

class VendorDataExported extends VendorManagementState {
  final String downloadUrl;
  final String format;

  const VendorDataExported({
    required this.downloadUrl,
    required this.format,
  });

  @override
  List<Object?> get props => [downloadUrl, format];
}
