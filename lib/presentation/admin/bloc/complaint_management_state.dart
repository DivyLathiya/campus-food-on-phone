import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/complaint_entity.dart';

abstract class ComplaintManagementState extends Equatable {
  const ComplaintManagementState();

  @override
  List<Object?> get props => [];
}

class ComplaintManagementInitial extends ComplaintManagementState {
  const ComplaintManagementInitial();
}

class ComplaintManagementLoading extends ComplaintManagementState {
  const ComplaintManagementLoading();
}

class ComplaintsLoaded extends ComplaintManagementState {
  final List<ComplaintEntity> complaints;
  final List<ComplaintEntity> pendingComplaints;
  final List<ComplaintEntity> inProgressComplaints;
  final List<ComplaintEntity> resolvedComplaints;
  final List<ComplaintEntity> rejectedComplaints;
  final Map<String, int> complaintStats;

  const ComplaintsLoaded({
    required this.complaints,
    required this.pendingComplaints,
    required this.inProgressComplaints,
    required this.resolvedComplaints,
    required this.rejectedComplaints,
    required this.complaintStats,
  });

  @override
  List<Object?> get props => [
        complaints,
        pendingComplaints,
        inProgressComplaints,
        resolvedComplaints,
        rejectedComplaints,
        complaintStats,
      ];
}

class ComplaintDetailsLoaded extends ComplaintManagementState {
  final ComplaintEntity complaint;
  final List<CommentEntity> comments;

  const ComplaintDetailsLoaded({
    required this.complaint,
    required this.comments,
  });

  @override
  List<Object?> get props => [complaint, comments];
}

class ComplaintOperationSuccess extends ComplaintManagementState {
  final String message;
  final ComplaintEntity? complaint;

  const ComplaintOperationSuccess({required this.message, this.complaint});

  @override
  List<Object?> get props => [message, complaint];
}

class ComplaintOperationFailure extends ComplaintManagementState {
  final String error;

  const ComplaintOperationFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ComplaintsFiltered extends ComplaintManagementState {
  final List<ComplaintEntity> filteredComplaints;
  final String filter;

  const ComplaintsFiltered({
    required this.filteredComplaints,
    required this.filter,
  });

  @override
  List<Object?> get props => [filteredComplaints, filter];
}

class ComplaintStatisticsLoaded extends ComplaintManagementState {
  final Map<String, dynamic> statistics;

  const ComplaintStatisticsLoaded({required this.statistics});

  @override
  List<Object?> get props => [statistics];
}

class ComplaintTrendsLoaded extends ComplaintManagementState {
  final Map<String, dynamic> trends;

  const ComplaintTrendsLoaded({required this.trends});

  @override
  List<Object?> get props => [trends];
}

class ComplaintCommentsLoaded extends ComplaintManagementState {
  final List<CommentEntity> comments;

  const ComplaintCommentsLoaded({required this.comments});

  @override
  List<Object?> get props => [comments];
}

class ComplaintDataExported extends ComplaintManagementState {
  final String downloadUrl;
  final String format;

  const ComplaintDataExported({
    required this.downloadUrl,
    required this.format,
  });

  @override
  List<Object?> get props => [downloadUrl, format];
}
