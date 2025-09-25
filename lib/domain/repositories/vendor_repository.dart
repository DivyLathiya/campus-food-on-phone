import 'package:campus_food_app/domain/entities/vendor_entity.dart';
import 'package:campus_food_app/domain/entities/enhanced_vendor_entity.dart';

abstract class VendorRepository {
  // Basic vendor methods
  Future<List<VendorEntity>> getVendors();
  Future<List<VendorEntity>> getAllVendors();
  Future<VendorEntity?> getVendorById(String vendorId);
  Future<List<VendorEntity>> getVendorsByStatus(String status);
  Future<VendorEntity> updateVendor(VendorEntity vendor);
  Future<VendorEntity> addVendor(VendorEntity vendor);
  
  // Enhanced vendor methods for admin panel
  Future<List<EnhancedVendorEntity>> getAllEnhancedVendors();
  Future<EnhancedVendorEntity?> getEnhancedVendorById(String vendorId);
  Future<List<EnhancedVendorEntity>> getEnhancedVendorsByStatus(String status);
  Future<List<EnhancedVendorEntity>> getVendorsByKYCStatus(String kycStatus);
  Future<EnhancedVendorEntity> updateEnhancedVendor(EnhancedVendorEntity vendor);
  Future<EnhancedVendorEntity> approveVendor(String vendorId, {String? notes});
  Future<EnhancedVendorEntity> rejectVendor(String vendorId, {String? reason});
  Future<EnhancedVendorEntity> verifyKYC(String vendorId, {String? notes});
  Future<EnhancedVendorEntity> rejectKYC(String vendorId, {String? reason});
  Future<EnhancedVendorEntity> suspendVendor(String vendorId, {String? reason});
  Future<EnhancedVendorEntity> reactivateVendor(String vendorId, {String? notes});
}
