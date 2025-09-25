import 'package:equatable/equatable.dart';

class EnhancedVendorEntity extends Equatable {
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

  const EnhancedVendorEntity({
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

  // Helper methods
  bool get isKycVerified => kycStatus == 'verified';
  bool get isKycPending => kycStatus == 'pending';
  bool get isKycRejected => kycStatus == 'rejected';
  bool get isActive => status == 'open' || status == 'active';
  bool get isPendingApproval => status == 'pending_approval';

  // Copy with method
  EnhancedVendorEntity copyWith({
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
    return EnhancedVendorEntity(
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
      kycStatus,
      kycSubmittedAt,
      kycVerifiedAt,
      kycRejectedAt,
      kycRejectedReason,
      businessLicense,
      taxId,
      bankAccount,
      bankName,
      accountHolderName,
      identityDocument,
      addressProof,
      isComplianceChecked,
      complianceCheckedAt,
      complianceCheckedBy,
    ];
  }
}
