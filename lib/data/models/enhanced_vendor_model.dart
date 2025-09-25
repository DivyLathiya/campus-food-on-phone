import 'package:campus_food_app/domain/entities/enhanced_vendor_entity.dart';

class EnhancedVendorModel {
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
  
  // KYC Verification Fields
  final String kycStatus; // 'pending', 'verified', 'rejected'
  final String? kycSubmittedAt;
  final String? kycVerifiedAt;
  final String? kycRejectedAt;
  final String? kycRejectedReason;
  final String? businessLicense;
  final String? taxId;
  final String? bankAccount;
  final String? bankName;
  final String? accountHolderName;
  final String? identityDocument;
  final String? addressProof;
  final bool isComplianceChecked;
  final String? complianceCheckedAt;
  final String? complianceCheckedBy;

  const EnhancedVendorModel({
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
    required this.kycStatus,
    this.kycSubmittedAt,
    this.kycVerifiedAt,
    this.kycRejectedAt,
    this.kycRejectedReason,
    this.businessLicense,
    this.taxId,
    this.bankAccount,
    this.bankName,
    this.accountHolderName,
    this.identityDocument,
    this.addressProof,
    this.isComplianceChecked = false,
    this.complianceCheckedAt,
    this.complianceCheckedBy,
  });

  // Factory constructor to create from JSON
  factory EnhancedVendorModel.fromJson(Map<String, dynamic> json) {
    return EnhancedVendorModel(
      vendorId: json['vendorId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      status: json['status'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      location: json['location'],
      phoneNumber: json['phoneNumber'],
      ownerId: json['ownerId'],
      kycStatus: json['kycStatus'] ?? 'pending',
      kycSubmittedAt: json['kycSubmittedAt'],
      kycVerifiedAt: json['kycVerifiedAt'],
      kycRejectedAt: json['kycRejectedAt'],
      kycRejectedReason: json['kycRejectedReason'],
      businessLicense: json['businessLicense'],
      taxId: json['taxId'],
      bankAccount: json['bankAccount'],
      bankName: json['bankName'],
      accountHolderName: json['accountHolderName'],
      identityDocument: json['identityDocument'],
      addressProof: json['addressProof'],
      isComplianceChecked: json['isComplianceChecked'] ?? false,
      complianceCheckedAt: json['complianceCheckedAt'],
      complianceCheckedBy: json['complianceCheckedBy'],
    );
  }

  // Convert to JSON
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
      'kycStatus': kycStatus,
      'kycSubmittedAt': kycSubmittedAt,
      'kycVerifiedAt': kycVerifiedAt,
      'kycRejectedAt': kycRejectedAt,
      'kycRejectedReason': kycRejectedReason,
      'businessLicense': businessLicense,
      'taxId': taxId,
      'bankAccount': bankAccount,
      'bankName': bankName,
      'accountHolderName': accountHolderName,
      'identityDocument': identityDocument,
      'addressProof': addressProof,
      'isComplianceChecked': isComplianceChecked,
      'complianceCheckedAt': complianceCheckedAt,
      'complianceCheckedBy': complianceCheckedBy,
    };
  }

  // Convert to Entity
  EnhancedVendorEntity toEntity() {
    return EnhancedVendorEntity(
      vendorId: vendorId,
      name: name,
      description: description,
      imageUrl: imageUrl,
      status: status,
      rating: rating,
      reviewCount: reviewCount,
      location: location,
      phoneNumber: phoneNumber,
      ownerId: ownerId,
      kycStatus: kycStatus,
      kycSubmittedAt: kycSubmittedAt,
      kycVerifiedAt: kycVerifiedAt,
      kycRejectedAt: kycRejectedAt,
      kycRejectedReason: kycRejectedReason,
      businessLicense: businessLicense,
      taxId: taxId,
      bankAccount: bankAccount,
      bankName: bankName,
      accountHolderName: accountHolderName,
      identityDocument: identityDocument,
      addressProof: addressProof,
      isComplianceChecked: isComplianceChecked,
      complianceCheckedAt: complianceCheckedAt,
      complianceCheckedBy: complianceCheckedBy,
    );
  }

  // Factory constructor to create from Entity
  factory EnhancedVendorModel.fromEntity(EnhancedVendorEntity entity) {
    return EnhancedVendorModel(
      vendorId: entity.vendorId,
      name: entity.name,
      description: entity.description,
      imageUrl: entity.imageUrl,
      status: entity.status,
      rating: entity.rating,
      reviewCount: entity.reviewCount,
      location: entity.location,
      phoneNumber: entity.phoneNumber,
      ownerId: entity.ownerId,
      kycStatus: entity.kycStatus,
      kycSubmittedAt: entity.kycSubmittedAt,
      kycVerifiedAt: entity.kycVerifiedAt,
      kycRejectedAt: entity.kycRejectedAt,
      kycRejectedReason: entity.kycRejectedReason,
      businessLicense: entity.businessLicense,
      taxId: entity.taxId,
      bankAccount: entity.bankAccount,
      bankName: entity.bankName,
      accountHolderName: entity.accountHolderName,
      identityDocument: entity.identityDocument,
      addressProof: entity.addressProof,
      isComplianceChecked: entity.isComplianceChecked,
      complianceCheckedAt: entity.complianceCheckedAt,
      complianceCheckedBy: entity.complianceCheckedBy,
    );
  }

  // Copy with method
  EnhancedVendorModel copyWith({
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
    String? kycStatus,
    String? kycSubmittedAt,
    String? kycVerifiedAt,
    String? kycRejectedAt,
    String? kycRejectedReason,
    String? businessLicense,
    String? taxId,
    String? bankAccount,
    String? bankName,
    String? accountHolderName,
    String? identityDocument,
    String? addressProof,
    bool? isComplianceChecked,
    String? complianceCheckedAt,
    String? complianceCheckedBy,
  }) {
    return EnhancedVendorModel(
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
      kycStatus: kycStatus ?? this.kycStatus,
      kycSubmittedAt: kycSubmittedAt ?? this.kycSubmittedAt,
      kycVerifiedAt: kycVerifiedAt ?? this.kycVerifiedAt,
      kycRejectedAt: kycRejectedAt ?? this.kycRejectedAt,
      kycRejectedReason: kycRejectedReason ?? this.kycRejectedReason,
      businessLicense: businessLicense ?? this.businessLicense,
      taxId: taxId ?? this.taxId,
      bankAccount: bankAccount ?? this.bankAccount,
      bankName: bankName ?? this.bankName,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      identityDocument: identityDocument ?? this.identityDocument,
      addressProof: addressProof ?? this.addressProof,
      isComplianceChecked: isComplianceChecked ?? this.isComplianceChecked,
      complianceCheckedAt: complianceCheckedAt ?? this.complianceCheckedAt,
      complianceCheckedBy: complianceCheckedBy ?? this.complianceCheckedBy,
    );
  }
}
