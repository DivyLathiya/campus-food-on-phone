import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/complaint_entity.dart';

abstract class ComplaintManagementEvent extends Equatable {
  const ComplaintManagementEvent();

  @override
  List<Object?> get props => [];
}

class LoadComplaints extends ComplaintManagementEvent {
  final String? status;
  final String? priority;
  final String? category;
  final String? type;

  const LoadComplaints({
    this.status,
    this.priority,
    this.category,
    this.type,
  });

  @override
  List<Object?> get props => [status, priority, category, type];
}

class LoadComplaintDetails extends ComplaintManagementEvent {
  final String complaintId;

  const LoadComplaintDetails({required this.complaintId});

  @override
  List<Object?> get props => [complaintId];
}

class AssignComplaint extends ComplaintManagementEvent {
  final String complaintId;
  final String assignedTo;
  final String assignedToName;

  const AssignComplaint({
    required this.complaintId,
    required this.assignedTo,
    required this.assignedToName,
  });

  @override
  List<Object?> get props => [complaintId, assignedTo, assignedToName];
}

class ResolveComplaint extends ComplaintManagementEvent {
  final String complaintId;
  final String resolution;
  final String resolvedBy;

  const ResolveComplaint({
    required this.complaintId,
    required this.resolution,
    required this.resolvedBy,
  });

  @override
  List<Object?> get props => [complaintId, resolution, resolvedBy];
}

class RejectComplaint extends ComplaintManagementEvent {
  final String complaintId;
  final String rejectionReason;

  const RejectComplaint({
    required this.complaintId,
    required this.rejectionReason,
  });

  @override
  List<Object?> get props => [complaintId, rejectionReason];
}

class AddComment extends ComplaintManagementEvent {
  final CommentEntity comment;

  const AddComment({required this.comment});

  @override
  List<Object?> get props => [comment];
}

class LoadComplaintComments extends ComplaintManagementEvent {
  final String complaintId;

  const LoadComplaintComments({required this.complaintId});

  @override
  List<Object?> get props => [complaintId];
}

class UpdateComplaintPriority extends ComplaintManagementEvent {
  final String complaintId;
  final String priority;

  const UpdateComplaintPriority({
    required this.complaintId,
    required this.priority,
  });

  @override
  List<Object?> get props => [complaintId, priority];
}

class SearchComplaints extends ComplaintManagementEvent {
  final String query;
  final String? filterBy;

  const SearchComplaints({
    required this.query,
    this.filterBy,
  });

  @override
  List<Object?> get props => [query, filterBy];
}

class LoadComplaintStatistics extends ComplaintManagementEvent {
  const LoadComplaintStatistics();
}

class LoadComplaintTrends extends ComplaintManagementEvent {
  final String? period;

  const LoadComplaintTrends({this.period});

  @override
  List<Object?> get props => [period];
}

class ExportComplaintsData extends ComplaintManagementEvent {
  final String format; // 'csv', 'json', 'pdf'
  final List<String>? fields;

  const ExportComplaintsData({
    required this.format,
    this.fields,
  });

  @override
  List<Object?> get props => [format, fields];
}

class RefreshComplaints extends ComplaintManagementEvent {
  const RefreshComplaints();
}
