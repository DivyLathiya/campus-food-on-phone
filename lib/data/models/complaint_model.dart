import 'package:campus_food_app/domain/entities/complaint_entity.dart';

class ComplaintModel {
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
  final List<CommentModel>? comments;

  const ComplaintModel({
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

  // Factory constructor to create from JSON
  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      complaintId: json['complaintId'] ?? '',
      complaintType: json['complaintType'] ?? '',
      submittedBy: json['submittedBy'] ?? '',
      submittedByName: json['submittedByName'] ?? '',
      submittedByRole: json['submittedByRole'] ?? '',
      subject: json['subject'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      priority: json['priority'] ?? '',
      relatedOrderId: json['relatedOrderId'],
      relatedVendorId: json['relatedVendorId'],
      relatedUserId: json['relatedUserId'],
      assignedTo: json['assignedTo'],
      assignedToName: json['assignedToName'],
      submittedAt: json['submittedAt'] ?? '',
      resolvedAt: json['resolvedAt'],
      resolvedBy: json['resolvedBy'],
      resolution: json['resolution'],
      rejectionReason: json['rejectionReason'],
      attachments: json['attachments'] != null 
          ? List<String>.from(json['attachments']) 
          : null,
      isAnonymous: json['isAnonymous'] ?? false,
      category: json['category'],
      rating: json['rating']?.toDouble(),
      comments: json['comments'] != null
          ? (json['comments'] as List).map((e) => CommentModel.fromJson(e)).toList()
          : null,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'complaintId': complaintId,
      'complaintType': complaintType,
      'submittedBy': submittedBy,
      'submittedByName': submittedByName,
      'submittedByRole': submittedByRole,
      'subject': subject,
      'description': description,
      'status': status,
      'priority': priority,
      'relatedOrderId': relatedOrderId,
      'relatedVendorId': relatedVendorId,
      'relatedUserId': relatedUserId,
      'assignedTo': assignedTo,
      'assignedToName': assignedToName,
      'submittedAt': submittedAt,
      'resolvedAt': resolvedAt,
      'resolvedBy': resolvedBy,
      'resolution': resolution,
      'rejectionReason': rejectionReason,
      'attachments': attachments,
      'isAnonymous': isAnonymous,
      'category': category,
      'rating': rating,
      'comments': comments?.map((e) => e.toJson()).toList(),
    };
  }

  // Convert to Entity
  ComplaintEntity toEntity() {
    return ComplaintEntity(
      complaintId: complaintId,
      complaintType: complaintType,
      submittedBy: submittedBy,
      submittedByName: submittedByName,
      submittedByRole: submittedByRole,
      subject: subject,
      description: description,
      status: status,
      priority: priority,
      relatedOrderId: relatedOrderId,
      relatedVendorId: relatedVendorId,
      relatedUserId: relatedUserId,
      assignedTo: assignedTo,
      assignedToName: assignedToName,
      submittedAt: submittedAt,
      resolvedAt: resolvedAt,
      resolvedBy: resolvedBy,
      resolution: resolution,
      rejectionReason: rejectionReason,
      attachments: attachments,
      isAnonymous: isAnonymous,
      category: category,
      rating: rating,
      comments: comments?.map((e) => e.toEntity()).toList(),
    );
  }

  // Factory constructor to create from Entity
  factory ComplaintModel.fromEntity(ComplaintEntity entity) {
    return ComplaintModel(
      complaintId: entity.complaintId,
      complaintType: entity.complaintType,
      submittedBy: entity.submittedBy,
      submittedByName: entity.submittedByName,
      submittedByRole: entity.submittedByRole,
      subject: entity.subject,
      description: entity.description,
      status: entity.status,
      priority: entity.priority,
      relatedOrderId: entity.relatedOrderId,
      relatedVendorId: entity.relatedVendorId,
      relatedUserId: entity.relatedUserId,
      assignedTo: entity.assignedTo,
      assignedToName: entity.assignedToName,
      submittedAt: entity.submittedAt,
      resolvedAt: entity.resolvedAt,
      resolvedBy: entity.resolvedBy,
      resolution: entity.resolution,
      rejectionReason: entity.rejectionReason,
      attachments: entity.attachments,
      isAnonymous: entity.isAnonymous,
      category: entity.category,
      rating: entity.rating,
      comments: entity.comments?.map((e) => CommentModel.fromEntity(e)).toList(),
    );
  }

  // Copy with method
  ComplaintModel copyWith({
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
    List<CommentModel>? comments,
  }) {
    return ComplaintModel(
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
}

class CommentModel {
  final String commentId;
  final String complaintId;
  final String commentedBy;
  final String commentedByName;
  final String commentedByRole;
  final String comment;
  final String commentedAt;
  final bool isInternal;

  const CommentModel({
    required this.commentId,
    required this.complaintId,
    required this.commentedBy,
    required this.commentedByName,
    required this.commentedByRole,
    required this.comment,
    required this.commentedAt,
    this.isInternal = false,
  });

  // Factory constructor to create from JSON
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'] ?? '',
      complaintId: json['complaintId'] ?? '',
      commentedBy: json['commentedBy'] ?? '',
      commentedByName: json['commentedByName'] ?? '',
      commentedByRole: json['commentedByRole'] ?? '',
      comment: json['comment'] ?? '',
      commentedAt: json['commentedAt'] ?? '',
      isInternal: json['isInternal'] ?? false,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'complaintId': complaintId,
      'commentedBy': commentedBy,
      'commentedByName': commentedByName,
      'commentedByRole': commentedByRole,
      'comment': comment,
      'commentedAt': commentedAt,
      'isInternal': isInternal,
    };
  }

  // Convert to Entity
  CommentEntity toEntity() {
    return CommentEntity(
      commentId: commentId,
      complaintId: complaintId,
      commentedBy: commentedBy,
      commentedByName: commentedByName,
      commentedByRole: commentedByRole,
      comment: comment,
      commentedAt: commentedAt,
      isInternal: isInternal,
    );
  }

  // Factory constructor to create from Entity
  factory CommentModel.fromEntity(CommentEntity entity) {
    return CommentModel(
      commentId: entity.commentId,
      complaintId: entity.complaintId,
      commentedBy: entity.commentedBy,
      commentedByName: entity.commentedByName,
      commentedByRole: entity.commentedByRole,
      comment: entity.comment,
      commentedAt: entity.commentedAt,
      isInternal: entity.isInternal,
    );
  }
}
