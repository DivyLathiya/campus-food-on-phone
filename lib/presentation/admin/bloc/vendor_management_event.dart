import 'package:equatable/equatable.dart';

abstract class VendorManagementEvent extends Equatable {
  const VendorManagementEvent();

  @override
  List<Object?> get props => [];
}

class LoadVendors extends VendorManagementEvent {
  final String? status;
  final String? kycStatus;

  const LoadVendors({this.status, this.kycStatus});

  @override
  List<Object?> get props => [status, kycStatus];
}

class LoadVendorDetails extends VendorManagementEvent {
  final String vendorId;

  const LoadVendorDetails({required this.vendorId});

  @override
  List<Object?> get props => [vendorId];
}

class ApproveVendor extends VendorManagementEvent {
  final String vendorId;
  final String? approvedBy;
  final String? notes;

  const ApproveVendor({
    required this.vendorId,
    this.approvedBy,
    this.notes,
  });

  @override
  List<Object?> get props => [vendorId, approvedBy, notes];
}

class RejectVendor extends VendorManagementEvent {
  final String vendorId;
  final String rejectionReason;
  final String? rejectedBy;
  final String? notes;

  const RejectVendor({
    required this.vendorId,
    required this.rejectionReason,
    this.rejectedBy,
    this.notes,
  });

  @override
  List<Object?> get props => [vendorId, rejectionReason, rejectedBy, notes];
}

class SuspendVendor extends VendorManagementEvent {
  final String vendorId;
  final String suspensionReason;
  final String? suspendedBy;
  final String? notes;

  const SuspendVendor({
    required this.vendorId,
    required this.suspensionReason,
    this.suspendedBy,
    this.notes,
  });

  @override
  List<Object?> get props => [vendorId, suspensionReason, suspendedBy, notes];
}

class ReactivateVendor extends VendorManagementEvent {
  final String vendorId;
  final String? reactivatedBy;
  final String? notes;

  const ReactivateVendor({
    required this.vendorId,
    this.reactivatedBy,
    this.notes,
  });

  @override
  List<Object?> get props => [vendorId, reactivatedBy, notes];
}

class VerifyKYC extends VendorManagementEvent {
  final String vendorId;
  final String? verifiedBy;
  final String? notes;

  const VerifyKYC({
    required this.vendorId,
    this.verifiedBy,
    this.notes,
  });

  @override
  List<Object?> get props => [vendorId, verifiedBy, notes];
}

class RejectKYC extends VendorManagementEvent {
  final String vendorId;
  final String rejectionReason;
  final String? rejectedBy;
  final String? notes;

  const RejectKYC({
    required this.vendorId,
    required this.rejectionReason,
    this.rejectedBy,
    this.notes,
  });

  @override
  List<Object?> get props => [vendorId, rejectionReason, rejectedBy, notes];
}

class UpdateVendorStatus extends VendorManagementEvent {
  final String vendorId;
  final String status;
  final String? updatedBy;
  final String? notes;

  const UpdateVendorStatus({
    required this.vendorId,
    required this.status,
    this.updatedBy,
    this.notes,
  });

  @override
  List<Object?> get props => [vendorId, status, updatedBy, notes];
}

class SearchVendors extends VendorManagementEvent {
  final String query;
  final String? filterBy;

  const SearchVendors({
    required this.query,
    this.filterBy,
  });

  @override
  List<Object?> get props => [query, filterBy];
}

class ExportVendorsData extends VendorManagementEvent {
  final String format; // 'csv', 'json', 'pdf'
  final List<String>? fields;

  const ExportVendorsData({
    required this.format,
    this.fields,
  });

  @override
  List<Object?> get props => [format, fields];
}

class RefreshVendors extends VendorManagementEvent {
  const RefreshVendors();
}
