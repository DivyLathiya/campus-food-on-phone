import 'package:equatable/equatable.dart';

class VendorModel extends Equatable {
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

  const VendorModel({
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

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      vendorId: json['vendorId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      status: json['status'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      location: json['location'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      ownerId: json['ownerId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vendorId': vendorId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'status': status,
      'rating': rating,
      'reviewCount': reviewCount,
      'location': location,
      'phoneNumber': phoneNumber,
      'ownerId': ownerId,
    };
  }

  VendorModel copyWith({
    String? vendorId,
    String? name,
    String? description,
    String? imageUrl,
    String? status,
    double? rating,
    int? reviewCount,
    String? location,
    String? phoneNumber,
    String? ownerId,
  }) {
    return VendorModel(
      vendorId: vendorId ?? this.vendorId,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      ownerId: ownerId ?? this.ownerId,
    );
  }

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
