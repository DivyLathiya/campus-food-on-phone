import 'package:campus_food_app/domain/entities/vendor_entity.dart';

abstract class VendorRepository {
  Future<List<VendorEntity>> getVendors();
  Future<List<VendorEntity>> getAllVendors();
  Future<VendorEntity?> getVendorById(String vendorId);
  Future<List<VendorEntity>> getVendorsByStatus(String status);
  Future<VendorEntity> updateVendor(VendorEntity vendor);
  Future<VendorEntity> addVendor(VendorEntity vendor);
}
