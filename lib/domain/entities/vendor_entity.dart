import 'package:equatable/equatable.dart';

class VendorEntity extends Equatable {
  final String vendorId;
  final String name;
  final String description;
  final String imageUrl;
  final String status;
  final double rating;
  final int reviewCount;
  final String? location;
  final String? phoneNumber;
  final String? ownerId;

  const VendorEntity({
    required this.vendorId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.rating,
    required this.reviewCount,
    this.location,
    this.phoneNumber,
    this.ownerId,
  });

  @override
  List<Object?> get props {
    return [
      vendorId,
      name,
      description,
      imageUrl,
      status,
      rating,
      reviewCount,
      location,
      phoneNumber,
      ownerId,
    ];
  }
}
