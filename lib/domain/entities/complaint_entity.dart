import 'package:equatable/equatable.dart';

class ComplaintEntity extends Equatable {
  final String complaintId;
  final String complaintType; // 'student_complaint', 'vendor_complaint', 'feedback'
  final String submittedBy;
  final String submittedByName;
  final String submittedByRole; // 'student', 'vendor'
  final String subject;
  final String description;
  final String status; // 'pending', 'in_progress', 'resolved', 'rejected'
  final String priority; // 'low', 'medium', 'high', 'urgent'
  final String? relatedOrderId;
  final String? relatedVendorId;
  final String? relatedUserId;
  final String? assignedTo;
  final String? assignedToName;
  final String submittedAt;
  final String? resolvedAt;
  final String? resolvedBy;
  final String? resolution;
  final String? rejectionReason;
  final List<String>? attachments;
  final bool isAnonymous;
  final String? category; // 'food_quality', 'service', 'payment', 'technical', 'other'
  final double? rating; // For feedback
  final List<CommentEntity>? comments;

  const ComplaintEntity({
    required this.complaintId,
    required this.complaintType,
    required this.submittedBy,
    required this.submittedByName,
    required this.submittedByRole,
    required this.subject,
    required this.description,
    required this.status,
    required this.priority,
    this.relatedOrderId,
    this.relatedVendorId,
    this.relatedUserId,
    this.assignedTo,
    this.assignedToName,
    required this.submittedAt,
    this.resolvedAt,
    this.resolvedBy,
    this.resolution,
    this.rejectionReason,
    this.attachments,
    this.isAnonymous = false,
    this.category,
    this.rating,
    this.comments,
  });

  // Helper methods
  bool get isPending => status == 'pending';
  bool get isInProgress => status == 'in_progress';
  bool get isResolved => status == 'resolved';
  bool get isRejected => status == 'rejected';
  bool get isComplaint => complaintType == 'student_complaint' || complaintType == 'vendor_complaint';
  bool get isFeedback => complaintType == 'feedback';

  // Copy with method
  ComplaintEntity copyWith({
    String? complaintId,
    String? complaintType,
    String? submittedBy,
    String? submittedByName,
    String? submittedByRole,
    String? subject,
    String? description,
    String? status,
    String? priority,
    String? relatedOrderId,
    String? relatedVendorId,
    String? relatedUserId,
    String? assignedTo,
    String? assignedToName,
    String? submittedAt,
    String? resolvedAt,
    String? resolvedBy,
    String? resolution,
    String? rejectionReason,
    List<String>? attachments,
    bool? isAnonymous,
    String? category,
    double? rating,
    List<CommentEntity>? comments,
  }) {
    return ComplaintEntity(
      complaintId: complaintId ?? this.complaintId,
      complaintType: complaintType ?? this.complaintType,
      submittedBy: submittedBy ?? this.submittedBy,
      submittedByName: submittedByName ?? this.submittedByName,
      submittedByRole: submittedByRole ?? this.submittedByRole,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      relatedOrderId: relatedOrderId ?? this.relatedOrderId,
      relatedVendorId: relatedVendorId ?? this.relatedVendorId,
      relatedUserId: relatedUserId ?? this.relatedUserId,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedToName: assignedToName ?? this.assignedToName,
      submittedAt: submittedAt ?? this.submittedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      resolvedBy: resolvedBy ?? this.resolvedBy,
      resolution: resolution ?? this.resolution,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      attachments: attachments ?? this.attachments,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object?> get props {
    return [
      complaintId,
      complaintType,
      submittedBy,
      submittedByName,
      submittedByRole,
      subject,
      description,
      status,
      priority,
      relatedOrderId,
      relatedVendorId,
      relatedUserId,
      assignedTo,
      assignedToName,
      submittedAt,
      resolvedAt,
      resolvedBy,
      resolution,
      rejectionReason,
      attachments,
      isAnonymous,
      category,
      rating,
      comments,
    ];
  }
}

class CommentEntity extends Equatable {
  final String commentId;
  final String complaintId;
  final String commentedBy;
  final String commentedByName;
  final String commentedByRole;
  final String comment;
  final String commentedAt;
  final bool isInternal;

  const CommentEntity({
    required this.commentId,
    required this.complaintId,
    required this.commentedBy,
    required this.commentedByName,
    required this.commentedByRole,
    required this.comment,
    required this.commentedAt,
    this.isInternal = false,
  });

  @override
  List<Object?> get props {
    return [
      commentId,
      complaintId,
      commentedBy,
      commentedByName,
      commentedByRole,
      comment,
      commentedAt,
      isInternal,
    ];
  }
}
