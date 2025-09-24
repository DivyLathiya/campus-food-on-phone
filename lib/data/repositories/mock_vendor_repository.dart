import 'package:campus_food_app/data/datasources/mock_data_source.dart';
import 'package:campus_food_app/data/models/vendor_model.dart';
import 'package:campus_food_app/domain/entities/vendor_entity.dart';
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
}
