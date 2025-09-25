import 'package:campus_food_app/data/datasources/mock_data_source.dart';
import 'package:campus_food_app/data/models/vendor_model.dart';
import 'package:campus_food_app/domain/entities/vendor_entity.dart';
import 'package:campus_food_app/domain/entities/enhanced_vendor_entity.dart';
import 'package:campus_food_app/domain/repositories/vendor_repository.dart';

class MockVendorRepository implements VendorRepository {
  @override
  Future<List<VendorEntity>> getVendors() async {
    return getAllVendors();
  }

  @override
  Future<List<VendorEntity>> getAllVendors() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return MockDataSource.vendors.map((vendor) => VendorEntity(
      vendorId: vendor.vendorId,
      name: vendor.name,
      description: vendor.description,
      imageUrl: vendor.imageUrl,
      status: vendor.status,
      rating: vendor.rating,
      reviewCount: vendor.reviewCount,
      location: vendor.location,
      phoneNumber: vendor.phoneNumber,
      ownerId: vendor.ownerId,
    )).toList();
  }

  @override
  Future<VendorEntity?> getVendorById(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      final vendor = MockDataSource.vendors.firstWhere((v) => v.vendorId == vendorId);
      return VendorEntity(
        vendorId: vendor.vendorId,
        name: vendor.name,
        description: vendor.description,
        imageUrl: vendor.imageUrl,
        status: vendor.status,
        rating: vendor.rating,
        reviewCount: vendor.reviewCount,
        location: vendor.location,
        phoneNumber: vendor.phoneNumber,
        ownerId: vendor.ownerId,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<VendorEntity>> getVendorsByStatus(String status) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final vendors = MockDataSource.getVendorsByStatus(status);
    return vendors.map((vendor) => VendorEntity(
      vendorId: vendor.vendorId,
      name: vendor.name,
      description: vendor.description,
      imageUrl: vendor.imageUrl,
      status: vendor.status,
      rating: vendor.rating,
      reviewCount: vendor.reviewCount,
      location: vendor.location,
      phoneNumber: vendor.phoneNumber,
      ownerId: vendor.ownerId,
    )).toList();
  }

  @override
  Future<VendorEntity> updateVendor(VendorEntity vendor) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.vendors.indexWhere((v) => v.vendorId == vendor.vendorId);
    if (index != -1) {
      final updatedVendor = MockDataSource.vendors[index].copyWith(
        name: vendor.name,
        description: vendor.description,
        status: vendor.status,
        rating: vendor.rating,
        reviewCount: vendor.reviewCount,
        location: vendor.location,
        phoneNumber: vendor.phoneNumber,
      );
      
      MockDataSource.vendors[index] = updatedVendor;
      
      return VendorEntity(
        vendorId: updatedVendor.vendorId,
        name: updatedVendor.name,
        description: updatedVendor.description,
        imageUrl: updatedVendor.imageUrl,
        status: updatedVendor.status,
        rating: updatedVendor.rating,
        reviewCount: updatedVendor.reviewCount,
        location: updatedVendor.location,
        phoneNumber: updatedVendor.phoneNumber,
        ownerId: updatedVendor.ownerId,
      );
    }
    
    throw Exception('Vendor not found');
  }

  @override
  Future<VendorEntity> addVendor(VendorEntity vendor) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final newVendor = VendorModel(
      vendorId: 'vendor_${MockDataSource.vendors.length + 1}',
      name: vendor.name,
      description: vendor.description,
      imageUrl: vendor.imageUrl,
      status: vendor.status,
      rating: vendor.rating,
      reviewCount: vendor.reviewCount,
      location: vendor.location,
      phoneNumber: vendor.phoneNumber,
      ownerId: vendor.ownerId,
    );
    
    MockDataSource.vendors.add(newVendor);
    
    return VendorEntity(
      vendorId: newVendor.vendorId,
      name: newVendor.name,
      description: newVendor.description,
      imageUrl: newVendor.imageUrl,
      status: newVendor.status,
      rating: newVendor.rating,
      reviewCount: newVendor.reviewCount,
      location: newVendor.location,
      phoneNumber: newVendor.phoneNumber,
      ownerId: newVendor.ownerId,
    );
  }

  // Enhanced vendor methods for admin panel
  @override
  Future<List<EnhancedVendorEntity>> getAllEnhancedVendors() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return MockDataSource.enhancedVendors.map((vendor) => EnhancedVendorEntity(
      vendorId: vendor.vendorId,
      name: vendor.name,
      description: vendor.description,
      imageUrl: vendor.imageUrl,
      status: vendor.status,
      rating: vendor.rating,
      reviewCount: vendor.reviewCount,
      location: vendor.location,
      phoneNumber: vendor.phoneNumber,
      ownerId: vendor.ownerId,
      kycStatus: vendor.kycStatus,
      kycSubmittedAt: vendor.kycSubmittedAt,
      kycVerifiedAt: vendor.kycVerifiedAt,
      kycRejectedAt: vendor.kycRejectedAt,
      kycRejectedReason: vendor.kycRejectedReason,
      businessLicense: vendor.businessLicense,
      taxId: vendor.taxId,
      bankAccount: vendor.bankAccount,
      bankName: vendor.bankName,
      accountHolderName: vendor.accountHolderName,
      identityDocument: vendor.identityDocument,
      addressProof: vendor.addressProof,
      isComplianceChecked: vendor.isComplianceChecked,
      complianceCheckedAt: vendor.complianceCheckedAt,
      complianceCheckedBy: vendor.complianceCheckedBy,
    )).toList();
  }

  @override
  Future<EnhancedVendorEntity?> getEnhancedVendorById(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      final vendor = MockDataSource.enhancedVendors.firstWhere((v) => v.vendorId == vendorId);
      return EnhancedVendorEntity(
        vendorId: vendor.vendorId,
        name: vendor.name,
        description: vendor.description,
        imageUrl: vendor.imageUrl,
        status: vendor.status,
        rating: vendor.rating,
        reviewCount: vendor.reviewCount,
        location: vendor.location,
        phoneNumber: vendor.phoneNumber,
        ownerId: vendor.ownerId,
        kycStatus: vendor.kycStatus,
        kycSubmittedAt: vendor.kycSubmittedAt,
        kycVerifiedAt: vendor.kycVerifiedAt,
        kycRejectedAt: vendor.kycRejectedAt,
        kycRejectedReason: vendor.kycRejectedReason,
        businessLicense: vendor.businessLicense,
        taxId: vendor.taxId,
        bankAccount: vendor.bankAccount,
        bankName: vendor.bankName,
        accountHolderName: vendor.accountHolderName,
        identityDocument: vendor.identityDocument,
        addressProof: vendor.addressProof,
        isComplianceChecked: vendor.isComplianceChecked,
        complianceCheckedAt: vendor.complianceCheckedAt,
        complianceCheckedBy: vendor.complianceCheckedBy,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<EnhancedVendorEntity>> getEnhancedVendorsByStatus(String status) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final vendors = MockDataSource.enhancedVendors.where((v) => v.status == status).toList();
    return vendors.map((vendor) => EnhancedVendorEntity(
      vendorId: vendor.vendorId,
      name: vendor.name,
      description: vendor.description,
      imageUrl: vendor.imageUrl,
      status: vendor.status,
      rating: vendor.rating,
      reviewCount: vendor.reviewCount,
      location: vendor.location,
      phoneNumber: vendor.phoneNumber,
      ownerId: vendor.ownerId,
      kycStatus: vendor.kycStatus,
      kycSubmittedAt: vendor.kycSubmittedAt,
      kycVerifiedAt: vendor.kycVerifiedAt,
      kycRejectedAt: vendor.kycRejectedAt,
      kycRejectedReason: vendor.kycRejectedReason,
      businessLicense: vendor.businessLicense,
      taxId: vendor.taxId,
      bankAccount: vendor.bankAccount,
      bankName: vendor.bankName,
      accountHolderName: vendor.accountHolderName,
      identityDocument: vendor.identityDocument,
      addressProof: vendor.addressProof,
      isComplianceChecked: vendor.isComplianceChecked,
      complianceCheckedAt: vendor.complianceCheckedAt,
      complianceCheckedBy: vendor.complianceCheckedBy,
    )).toList();
  }

  @override
  Future<List<EnhancedVendorEntity>> getVendorsByKYCStatus(String kycStatus) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final vendors = MockDataSource.enhancedVendors.where((v) => v.kycStatus == kycStatus).toList();
    return vendors.map((vendor) => EnhancedVendorEntity(
      vendorId: vendor.vendorId,
      name: vendor.name,
      description: vendor.description,
      imageUrl: vendor.imageUrl,
      status: vendor.status,
      rating: vendor.rating,
      reviewCount: vendor.reviewCount,
      location: vendor.location,
      phoneNumber: vendor.phoneNumber,
      ownerId: vendor.ownerId,
      kycStatus: vendor.kycStatus,
      kycSubmittedAt: vendor.kycSubmittedAt,
      kycVerifiedAt: vendor.kycVerifiedAt,
      kycRejectedAt: vendor.kycRejectedAt,
      kycRejectedReason: vendor.kycRejectedReason,
      businessLicense: vendor.businessLicense,
      taxId: vendor.taxId,
      bankAccount: vendor.bankAccount,
      bankName: vendor.bankName,
      accountHolderName: vendor.accountHolderName,
      identityDocument: vendor.identityDocument,
      addressProof: vendor.addressProof,
      isComplianceChecked: vendor.isComplianceChecked,
      complianceCheckedAt: vendor.complianceCheckedAt,
      complianceCheckedBy: vendor.complianceCheckedBy,
    )).toList();
  }

  @override
  Future<EnhancedVendorEntity> updateEnhancedVendor(EnhancedVendorEntity vendor) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.enhancedVendors.indexWhere((v) => v.vendorId == vendor.vendorId);
    if (index != -1) {
      final updatedVendor = MockDataSource.enhancedVendors[index].copyWith(
        name: vendor.name,
        description: vendor.description,
        status: vendor.status,
        rating: vendor.rating,
        reviewCount: vendor.reviewCount,
        location: vendor.location,
        phoneNumber: vendor.phoneNumber,
        kycStatus: vendor.kycStatus,
        kycSubmittedAt: vendor.kycSubmittedAt,
        kycVerifiedAt: vendor.kycVerifiedAt,
        kycRejectedAt: vendor.kycRejectedAt,
        kycRejectedReason: vendor.kycRejectedReason,
        businessLicense: vendor.businessLicense,
        taxId: vendor.taxId,
        bankAccount: vendor.bankAccount,
        bankName: vendor.bankName,
        accountHolderName: vendor.accountHolderName,
        identityDocument: vendor.identityDocument,
        addressProof: vendor.addressProof,
        isComplianceChecked: vendor.isComplianceChecked,
        complianceCheckedAt: vendor.complianceCheckedAt,
        complianceCheckedBy: vendor.complianceCheckedBy,
      );
      
      MockDataSource.enhancedVendors[index] = updatedVendor;
      
      return EnhancedVendorEntity(
        vendorId: updatedVendor.vendorId,
        name: updatedVendor.name,
        description: updatedVendor.description,
        imageUrl: updatedVendor.imageUrl,
        status: updatedVendor.status,
        rating: updatedVendor.rating,
        reviewCount: updatedVendor.reviewCount,
        location: updatedVendor.location,
        phoneNumber: updatedVendor.phoneNumber,
        ownerId: updatedVendor.ownerId,
        kycStatus: updatedVendor.kycStatus,
        kycSubmittedAt: updatedVendor.kycSubmittedAt,
        kycVerifiedAt: updatedVendor.kycVerifiedAt,
        kycRejectedAt: updatedVendor.kycRejectedAt,
        kycRejectedReason: updatedVendor.kycRejectedReason,
        businessLicense: updatedVendor.businessLicense,
        taxId: updatedVendor.taxId,
        bankAccount: updatedVendor.bankAccount,
        bankName: updatedVendor.bankName,
        accountHolderName: updatedVendor.accountHolderName,
        identityDocument: updatedVendor.identityDocument,
        addressProof: updatedVendor.addressProof,
        isComplianceChecked: updatedVendor.isComplianceChecked,
        complianceCheckedAt: updatedVendor.complianceCheckedAt,
        complianceCheckedBy: updatedVendor.complianceCheckedBy,
      );
    }
    
    throw Exception('Enhanced vendor not found');
  }

  @override
  Future<EnhancedVendorEntity> approveVendor(String vendorId, {String? notes}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.enhancedVendors.indexWhere((v) => v.vendorId == vendorId);
    if (index != -1) {
      final updatedVendor = MockDataSource.enhancedVendors[index].copyWith(
        status: 'approved',
      );
      
      MockDataSource.enhancedVendors[index] = updatedVendor;
      
      return EnhancedVendorEntity(
        vendorId: updatedVendor.vendorId,
        name: updatedVendor.name,
        description: updatedVendor.description,
        imageUrl: updatedVendor.imageUrl,
        status: updatedVendor.status,
        rating: updatedVendor.rating,
        reviewCount: updatedVendor.reviewCount,
        location: updatedVendor.location,
        phoneNumber: updatedVendor.phoneNumber,
        ownerId: updatedVendor.ownerId,
        kycStatus: updatedVendor.kycStatus,
        kycSubmittedAt: updatedVendor.kycSubmittedAt,
        kycVerifiedAt: updatedVendor.kycVerifiedAt,
        kycRejectedAt: updatedVendor.kycRejectedAt,
        kycRejectedReason: updatedVendor.kycRejectedReason,
        businessLicense: updatedVendor.businessLicense,
        taxId: updatedVendor.taxId,
        bankAccount: updatedVendor.bankAccount,
        bankName: updatedVendor.bankName,
        accountHolderName: updatedVendor.accountHolderName,
        identityDocument: updatedVendor.identityDocument,
        addressProof: updatedVendor.addressProof,
        isComplianceChecked: updatedVendor.isComplianceChecked,
        complianceCheckedAt: updatedVendor.complianceCheckedAt,
        complianceCheckedBy: updatedVendor.complianceCheckedBy,
      );
    }
    
    throw Exception('Vendor not found');
  }

  @override
  Future<EnhancedVendorEntity> rejectVendor(String vendorId, {String? reason}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.enhancedVendors.indexWhere((v) => v.vendorId == vendorId);
    if (index != -1) {
      final updatedVendor = MockDataSource.enhancedVendors[index].copyWith(
        status: 'rejected',
      );
      
      MockDataSource.enhancedVendors[index] = updatedVendor;
      
      return EnhancedVendorEntity(
        vendorId: updatedVendor.vendorId,
        name: updatedVendor.name,
        description: updatedVendor.description,
        imageUrl: updatedVendor.imageUrl,
        status: updatedVendor.status,
        rating: updatedVendor.rating,
        reviewCount: updatedVendor.reviewCount,
        location: updatedVendor.location,
        phoneNumber: updatedVendor.phoneNumber,
        ownerId: updatedVendor.ownerId,
        kycStatus: updatedVendor.kycStatus,
        kycSubmittedAt: updatedVendor.kycSubmittedAt,
        kycVerifiedAt: updatedVendor.kycVerifiedAt,
        kycRejectedAt: updatedVendor.kycRejectedAt,
        kycRejectedReason: updatedVendor.kycRejectedReason,
        businessLicense: updatedVendor.businessLicense,
        taxId: updatedVendor.taxId,
        bankAccount: updatedVendor.bankAccount,
        bankName: updatedVendor.bankName,
        accountHolderName: updatedVendor.accountHolderName,
        identityDocument: updatedVendor.identityDocument,
        addressProof: updatedVendor.addressProof,
        isComplianceChecked: updatedVendor.isComplianceChecked,
        complianceCheckedAt: updatedVendor.complianceCheckedAt,
        complianceCheckedBy: updatedVendor.complianceCheckedBy,
      );
    }
    
    throw Exception('Vendor not found');
  }

  @override
  Future<EnhancedVendorEntity> verifyKYC(String vendorId, {String? notes}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.enhancedVendors.indexWhere((v) => v.vendorId == vendorId);
    if (index != -1) {
      final updatedVendor = MockDataSource.enhancedVendors[index].copyWith(
        kycStatus: 'verified',
        kycVerifiedAt: DateTime.now().toIso8601String(),
      );
      
      MockDataSource.enhancedVendors[index] = updatedVendor;
      
      return EnhancedVendorEntity(
        vendorId: updatedVendor.vendorId,
        name: updatedVendor.name,
        description: updatedVendor.description,
        imageUrl: updatedVendor.imageUrl,
        status: updatedVendor.status,
        rating: updatedVendor.rating,
        reviewCount: updatedVendor.reviewCount,
        location: updatedVendor.location,
        phoneNumber: updatedVendor.phoneNumber,
        ownerId: updatedVendor.ownerId,
        kycStatus: updatedVendor.kycStatus,
        kycSubmittedAt: updatedVendor.kycSubmittedAt,
        kycVerifiedAt: updatedVendor.kycVerifiedAt,
        kycRejectedAt: updatedVendor.kycRejectedAt,
        kycRejectedReason: updatedVendor.kycRejectedReason,
        businessLicense: updatedVendor.businessLicense,
        taxId: updatedVendor.taxId,
        bankAccount: updatedVendor.bankAccount,
        bankName: updatedVendor.bankName,
        accountHolderName: updatedVendor.accountHolderName,
        identityDocument: updatedVendor.identityDocument,
        addressProof: updatedVendor.addressProof,
        isComplianceChecked: updatedVendor.isComplianceChecked,
        complianceCheckedAt: updatedVendor.complianceCheckedAt,
        complianceCheckedBy: updatedVendor.complianceCheckedBy,
      );
    }
    
    throw Exception('Vendor not found');
  }

  @override
  Future<EnhancedVendorEntity> rejectKYC(String vendorId, {String? reason}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.enhancedVendors.indexWhere((v) => v.vendorId == vendorId);
    if (index != -1) {
      final updatedVendor = MockDataSource.enhancedVendors[index].copyWith(
        kycStatus: 'rejected',
        kycRejectedAt: DateTime.now().toIso8601String(),
        kycRejectedReason: reason,
      );
      
      MockDataSource.enhancedVendors[index] = updatedVendor;
      
      return EnhancedVendorEntity(
        vendorId: updatedVendor.vendorId,
        name: updatedVendor.name,
        description: updatedVendor.description,
        imageUrl: updatedVendor.imageUrl,
        status: updatedVendor.status,
        rating: updatedVendor.rating,
        reviewCount: updatedVendor.reviewCount,
        location: updatedVendor.location,
        phoneNumber: updatedVendor.phoneNumber,
        ownerId: updatedVendor.ownerId,
        kycStatus: updatedVendor.kycStatus,
        kycSubmittedAt: updatedVendor.kycSubmittedAt,
        kycVerifiedAt: updatedVendor.kycVerifiedAt,
        kycRejectedAt: updatedVendor.kycRejectedAt,
        kycRejectedReason: updatedVendor.kycRejectedReason,
        businessLicense: updatedVendor.businessLicense,
        taxId: updatedVendor.taxId,
        bankAccount: updatedVendor.bankAccount,
        bankName: updatedVendor.bankName,
        accountHolderName: updatedVendor.accountHolderName,
        identityDocument: updatedVendor.identityDocument,
        addressProof: updatedVendor.addressProof,
        isComplianceChecked: updatedVendor.isComplianceChecked,
        complianceCheckedAt: updatedVendor.complianceCheckedAt,
        complianceCheckedBy: updatedVendor.complianceCheckedBy,
      );
    }
    
    throw Exception('Vendor not found');
  }

  @override
  Future<EnhancedVendorEntity> suspendVendor(String vendorId, {String? reason}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.enhancedVendors.indexWhere((v) => v.vendorId == vendorId);
    if (index != -1) {
      final updatedVendor = MockDataSource.enhancedVendors[index].copyWith(
        status: 'suspended',
      );
      
      MockDataSource.enhancedVendors[index] = updatedVendor;
      
      return EnhancedVendorEntity(
        vendorId: updatedVendor.vendorId,
        name: updatedVendor.name,
        description: updatedVendor.description,
        imageUrl: updatedVendor.imageUrl,
        status: updatedVendor.status,
        rating: updatedVendor.rating,
        reviewCount: updatedVendor.reviewCount,
        location: updatedVendor.location,
        phoneNumber: updatedVendor.phoneNumber,
        ownerId: updatedVendor.ownerId,
        kycStatus: updatedVendor.kycStatus,
        kycSubmittedAt: updatedVendor.kycSubmittedAt,
        kycVerifiedAt: updatedVendor.kycVerifiedAt,
        kycRejectedAt: updatedVendor.kycRejectedAt,
        kycRejectedReason: updatedVendor.kycRejectedReason,
        businessLicense: updatedVendor.businessLicense,
        taxId: updatedVendor.taxId,
        bankAccount: updatedVendor.bankAccount,
        bankName: updatedVendor.bankName,
        accountHolderName: updatedVendor.accountHolderName,
        identityDocument: updatedVendor.identityDocument,
        addressProof: updatedVendor.addressProof,
        isComplianceChecked: updatedVendor.isComplianceChecked,
        complianceCheckedAt: updatedVendor.complianceCheckedAt,
        complianceCheckedBy: updatedVendor.complianceCheckedBy,
      );
    }
    
    throw Exception('Vendor not found');
  }

  @override
  Future<EnhancedVendorEntity> reactivateVendor(String vendorId, {String? notes}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.enhancedVendors.indexWhere((v) => v.vendorId == vendorId);
    if (index != -1) {
      final updatedVendor = MockDataSource.enhancedVendors[index].copyWith(
        status: 'active',
      );
      
      MockDataSource.enhancedVendors[index] = updatedVendor;
      
      return EnhancedVendorEntity(
        vendorId: updatedVendor.vendorId,
        name: updatedVendor.name,
        description: updatedVendor.description,
        imageUrl: updatedVendor.imageUrl,
        status: updatedVendor.status,
        rating: updatedVendor.rating,
        reviewCount: updatedVendor.reviewCount,
        location: updatedVendor.location,
        phoneNumber: updatedVendor.phoneNumber,
        ownerId: updatedVendor.ownerId,
        kycStatus: updatedVendor.kycStatus,
        kycSubmittedAt: updatedVendor.kycSubmittedAt,
        kycVerifiedAt: updatedVendor.kycVerifiedAt,
        kycRejectedAt: updatedVendor.kycRejectedAt,
        kycRejectedReason: updatedVendor.kycRejectedReason,
        businessLicense: updatedVendor.businessLicense,
        taxId: updatedVendor.taxId,
        bankAccount: updatedVendor.bankAccount,
        bankName: updatedVendor.bankName,
        accountHolderName: updatedVendor.accountHolderName,
        identityDocument: updatedVendor.identityDocument,
        addressProof: updatedVendor.addressProof,
        isComplianceChecked: updatedVendor.isComplianceChecked,
        complianceCheckedAt: updatedVendor.complianceCheckedAt,
        complianceCheckedBy: updatedVendor.complianceCheckedBy,
      );
    }
    
    throw Exception('Vendor not found');
  }
}
