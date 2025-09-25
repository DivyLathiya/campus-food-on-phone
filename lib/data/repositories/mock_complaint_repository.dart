import 'package:campus_food_app/data/datasources/mock_data_source.dart';
import 'package:campus_food_app/data/models/complaint_model.dart';
import 'package:campus_food_app/domain/entities/complaint_entity.dart';
import 'package:campus_food_app/domain/repositories/complaint_repository.dart';

class MockComplaintRepository implements ComplaintRepository {
  @override
  Future<List<ComplaintEntity>> getAllComplaints() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return MockDataSource.complaints.map((complaint) => ComplaintEntity(
      complaintId: complaint.complaintId,
      complaintType: complaint.complaintType,
      submittedBy: complaint.submittedBy,
      submittedByName: complaint.submittedByName,
      submittedByRole: complaint.submittedByRole,
      subject: complaint.subject,
      description: complaint.description,
      status: complaint.status,
      priority: complaint.priority,
      relatedOrderId: complaint.relatedOrderId,
      relatedVendorId: complaint.relatedVendorId,
      relatedUserId: complaint.relatedUserId,
      assignedTo: complaint.assignedTo,
      assignedToName: complaint.assignedToName,
      submittedAt: complaint.submittedAt,
      resolvedAt: complaint.resolvedAt,
      resolvedBy: complaint.resolvedBy,
      resolution: complaint.resolution,
      rejectionReason: complaint.rejectionReason,
      attachments: complaint.attachments,
      isAnonymous: complaint.isAnonymous,
      category: complaint.category,
      rating: complaint.rating,
      comments: complaint.comments?.map((comment) => CommentEntity(
        commentId: comment.commentId,
        complaintId: comment.complaintId,
        commentedBy: comment.commentedBy,
        commentedByName: comment.commentedByName,
        commentedByRole: comment.commentedByRole,
        comment: comment.comment,
        commentedAt: comment.commentedAt,
        isInternal: comment.isInternal,
      )).toList(),
    )).toList();
  }

  @override
  Future<List<ComplaintEntity>> getComplaintsByType(String complaintType) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final complaints = MockDataSource.getComplaintsByType(complaintType);
    return complaints.map((complaint) => ComplaintEntity(
      complaintId: complaint.complaintId,
      complaintType: complaint.complaintType,
      submittedBy: complaint.submittedBy,
      submittedByName: complaint.submittedByName,
      submittedByRole: complaint.submittedByRole,
      subject: complaint.subject,
      description: complaint.description,
      status: complaint.status,
      priority: complaint.priority,
      relatedOrderId: complaint.relatedOrderId,
      relatedVendorId: complaint.relatedVendorId,
      relatedUserId: complaint.relatedUserId,
      assignedTo: complaint.assignedTo,
      assignedToName: complaint.assignedToName,
      submittedAt: complaint.submittedAt,
      resolvedAt: complaint.resolvedAt,
      resolvedBy: complaint.resolvedBy,
      resolution: complaint.resolution,
      rejectionReason: complaint.rejectionReason,
      attachments: complaint.attachments,
      isAnonymous: complaint.isAnonymous,
      category: complaint.category,
      rating: complaint.rating,
      comments: complaint.comments?.map((comment) => CommentEntity(
        commentId: comment.commentId,
        complaintId: comment.complaintId,
        commentedBy: comment.commentedBy,
        commentedByName: comment.commentedByName,
        commentedByRole: comment.commentedByRole,
        comment: comment.comment,
        commentedAt: comment.commentedAt,
        isInternal: comment.isInternal,
      )).toList(),
    )).toList();
  }

  @override
  Future<List<ComplaintEntity>> getComplaintsByStatus(String status) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final complaints = MockDataSource.getComplaintsByStatus(status);
    return complaints.map((complaint) => ComplaintEntity(
      complaintId: complaint.complaintId,
      complaintType: complaint.complaintType,
      submittedBy: complaint.submittedBy,
      submittedByName: complaint.submittedByName,
      submittedByRole: complaint.submittedByRole,
      subject: complaint.subject,
      description: complaint.description,
      status: complaint.status,
      priority: complaint.priority,
      relatedOrderId: complaint.relatedOrderId,
      relatedVendorId: complaint.relatedVendorId,
      relatedUserId: complaint.relatedUserId,
      assignedTo: complaint.assignedTo,
      assignedToName: complaint.assignedToName,
      submittedAt: complaint.submittedAt,
      resolvedAt: complaint.resolvedAt,
      resolvedBy: complaint.resolvedBy,
      resolution: complaint.resolution,
      rejectionReason: complaint.rejectionReason,
      attachments: complaint.attachments,
      isAnonymous: complaint.isAnonymous,
      category: complaint.category,
      rating: complaint.rating,
      comments: complaint.comments?.map((comment) => CommentEntity(
        commentId: comment.commentId,
        complaintId: comment.complaintId,
        commentedBy: comment.commentedBy,
        commentedByName: comment.commentedByName,
        commentedByRole: comment.commentedByRole,
        comment: comment.comment,
        commentedAt: comment.commentedAt,
        isInternal: comment.isInternal,
      )).toList(),
    )).toList();
  }

  @override
  Future<List<ComplaintEntity>> getComplaintsByPriority(String priority) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final complaints = MockDataSource.getComplaintsByPriority(priority);
    return complaints.map((complaint) => ComplaintEntity(
      complaintId: complaint.complaintId,
      complaintType: complaint.complaintType,
      submittedBy: complaint.submittedBy,
      submittedByName: complaint.submittedByName,
      submittedByRole: complaint.submittedByRole,
      subject: complaint.subject,
      description: complaint.description,
      status: complaint.status,
      priority: complaint.priority,
      relatedOrderId: complaint.relatedOrderId,
      relatedVendorId: complaint.relatedVendorId,
      relatedUserId: complaint.relatedUserId,
      assignedTo: complaint.assignedTo,
      assignedToName: complaint.assignedToName,
      submittedAt: complaint.submittedAt,
      resolvedAt: complaint.resolvedAt,
      resolvedBy: complaint.resolvedBy,
      resolution: complaint.resolution,
      rejectionReason: complaint.rejectionReason,
      attachments: complaint.attachments,
      isAnonymous: complaint.isAnonymous,
      category: complaint.category,
      rating: complaint.rating,
      comments: complaint.comments?.map((comment) => CommentEntity(
        commentId: comment.commentId,
        complaintId: comment.complaintId,
        commentedBy: comment.commentedBy,
        commentedByName: comment.commentedByName,
        commentedByRole: comment.commentedByRole,
        comment: comment.comment,
        commentedAt: comment.commentedAt,
        isInternal: comment.isInternal,
      )).toList(),
    )).toList();
  }

  @override
  Future<List<ComplaintEntity>> getComplaintsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final complaints = MockDataSource.getComplaintsByCategory(category);
    return complaints.map((complaint) => ComplaintEntity(
      complaintId: complaint.complaintId,
      complaintType: complaint.complaintType,
      submittedBy: complaint.submittedBy,
      submittedByName: complaint.submittedByName,
      submittedByRole: complaint.submittedByRole,
      subject: complaint.subject,
      description: complaint.description,
      status: complaint.status,
      priority: complaint.priority,
      relatedOrderId: complaint.relatedOrderId,
      relatedVendorId: complaint.relatedVendorId,
      relatedUserId: complaint.relatedUserId,
      assignedTo: complaint.assignedTo,
      assignedToName: complaint.assignedToName,
      submittedAt: complaint.submittedAt,
      resolvedAt: complaint.resolvedAt,
      resolvedBy: complaint.resolvedBy,
      resolution: complaint.resolution,
      rejectionReason: complaint.rejectionReason,
      attachments: complaint.attachments,
      isAnonymous: complaint.isAnonymous,
      category: complaint.category,
      rating: complaint.rating,
      comments: complaint.comments?.map((comment) => CommentEntity(
        commentId: comment.commentId,
        complaintId: comment.complaintId,
        commentedBy: comment.commentedBy,
        commentedByName: comment.commentedByName,
        commentedByRole: comment.commentedByRole,
        comment: comment.comment,
        commentedAt: comment.commentedAt,
        isInternal: comment.isInternal,
      )).toList(),
    )).toList();
  }

  @override
  Future<List<ComplaintEntity>> getComplaintsBySubmitter(String submittedBy) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final complaints = MockDataSource.getComplaintsBySubmitter(submittedBy);
    return complaints.map((complaint) => ComplaintEntity(
      complaintId: complaint.complaintId,
      complaintType: complaint.complaintType,
      submittedBy: complaint.submittedBy,
      submittedByName: complaint.submittedByName,
      submittedByRole: complaint.submittedByRole,
      subject: complaint.subject,
      description: complaint.description,
      status: complaint.status,
      priority: complaint.priority,
      relatedOrderId: complaint.relatedOrderId,
      relatedVendorId: complaint.relatedVendorId,
      relatedUserId: complaint.relatedUserId,
      assignedTo: complaint.assignedTo,
      assignedToName: complaint.assignedToName,
      submittedAt: complaint.submittedAt,
      resolvedAt: complaint.resolvedAt,
      resolvedBy: complaint.resolvedBy,
      resolution: complaint.resolution,
      rejectionReason: complaint.rejectionReason,
      attachments: complaint.attachments,
      isAnonymous: complaint.isAnonymous,
      category: complaint.category,
      rating: complaint.rating,
      comments: complaint.comments?.map((comment) => CommentEntity(
        commentId: comment.commentId,
        complaintId: comment.complaintId,
        commentedBy: comment.commentedBy,
        commentedByName: comment.commentedByName,
        commentedByRole: comment.commentedByRole,
        comment: comment.comment,
        commentedAt: comment.commentedAt,
        isInternal: comment.isInternal,
      )).toList(),
    )).toList();
  }

  @override
  Future<List<ComplaintEntity>> getComplaintsByVendor(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final complaints = MockDataSource.getComplaintsByVendor(vendorId);
    return complaints.map((complaint) => ComplaintEntity(
      complaintId: complaint.complaintId,
      complaintType: complaint.complaintType,
      submittedBy: complaint.submittedBy,
      submittedByName: complaint.submittedByName,
      submittedByRole: complaint.submittedByRole,
      subject: complaint.subject,
      description: complaint.description,
      status: complaint.status,
      priority: complaint.priority,
      relatedOrderId: complaint.relatedOrderId,
      relatedVendorId: complaint.relatedVendorId,
      relatedUserId: complaint.relatedUserId,
      assignedTo: complaint.assignedTo,
      assignedToName: complaint.assignedToName,
      submittedAt: complaint.submittedAt,
      resolvedAt: complaint.resolvedAt,
      resolvedBy: complaint.resolvedBy,
      resolution: complaint.resolution,
      rejectionReason: complaint.rejectionReason,
      attachments: complaint.attachments,
      isAnonymous: complaint.isAnonymous,
      category: complaint.category,
      rating: complaint.rating,
      comments: complaint.comments?.map((comment) => CommentEntity(
        commentId: comment.commentId,
        complaintId: comment.complaintId,
        commentedBy: comment.commentedBy,
        commentedByName: comment.commentedByName,
        commentedByRole: comment.commentedByRole,
        comment: comment.comment,
        commentedAt: comment.commentedAt,
        isInternal: comment.isInternal,
      )).toList(),
    )).toList();
  }

  @override
  Future<List<ComplaintEntity>> getComplaintsByUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final complaints = MockDataSource.getComplaintsByUser(userId);
    return complaints.map((complaint) => ComplaintEntity(
      complaintId: complaint.complaintId,
      complaintType: complaint.complaintType,
      submittedBy: complaint.submittedBy,
      submittedByName: complaint.submittedByName,
      submittedByRole: complaint.submittedByRole,
      subject: complaint.subject,
      description: complaint.description,
      status: complaint.status,
      priority: complaint.priority,
      relatedOrderId: complaint.relatedOrderId,
      relatedVendorId: complaint.relatedVendorId,
      relatedUserId: complaint.relatedUserId,
      assignedTo: complaint.assignedTo,
      assignedToName: complaint.assignedToName,
      submittedAt: complaint.submittedAt,
      resolvedAt: complaint.resolvedAt,
      resolvedBy: complaint.resolvedBy,
      resolution: complaint.resolution,
      rejectionReason: complaint.rejectionReason,
      attachments: complaint.attachments,
      isAnonymous: complaint.isAnonymous,
      category: complaint.category,
      rating: complaint.rating,
      comments: complaint.comments?.map((comment) => CommentEntity(
        commentId: comment.commentId,
        complaintId: comment.complaintId,
        commentedBy: comment.commentedBy,
        commentedByName: comment.commentedByName,
        commentedByRole: comment.commentedByRole,
        comment: comment.comment,
        commentedAt: comment.commentedAt,
        isInternal: comment.isInternal,
      )).toList(),
    )).toList();
  }

  @override
  Future<ComplaintEntity?> getComplaintById(String complaintId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      final complaint = MockDataSource.complaints.firstWhere((c) => c.complaintId == complaintId);
      return ComplaintEntity(
        complaintId: complaint.complaintId,
        complaintType: complaint.complaintType,
        submittedBy: complaint.submittedBy,
        submittedByName: complaint.submittedByName,
        submittedByRole: complaint.submittedByRole,
        subject: complaint.subject,
        description: complaint.description,
        status: complaint.status,
        priority: complaint.priority,
        relatedOrderId: complaint.relatedOrderId,
        relatedVendorId: complaint.relatedVendorId,
        relatedUserId: complaint.relatedUserId,
        assignedTo: complaint.assignedTo,
        assignedToName: complaint.assignedToName,
        submittedAt: complaint.submittedAt,
        resolvedAt: complaint.resolvedAt,
        resolvedBy: complaint.resolvedBy,
        resolution: complaint.resolution,
        rejectionReason: complaint.rejectionReason,
        attachments: complaint.attachments,
        isAnonymous: complaint.isAnonymous,
        category: complaint.category,
        rating: complaint.rating,
        comments: complaint.comments?.map((comment) => CommentEntity(
          commentId: comment.commentId,
          complaintId: comment.complaintId,
          commentedBy: comment.commentedBy,
          commentedByName: comment.commentedByName,
          commentedByRole: comment.commentedByRole,
          comment: comment.comment,
          commentedAt: comment.commentedAt,
          isInternal: comment.isInternal,
        )).toList(),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ComplaintEntity> createComplaint(ComplaintEntity complaint) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final newComplaint = ComplaintModel(
      complaintId: 'complaint_${MockDataSource.complaints.length + 1}',
      complaintType: complaint.complaintType,
      submittedBy: complaint.submittedBy,
      submittedByName: complaint.submittedByName,
      submittedByRole: complaint.submittedByRole,
      subject: complaint.subject,
      description: complaint.description,
      status: complaint.status,
      priority: complaint.priority,
      relatedOrderId: complaint.relatedOrderId,
      relatedVendorId: complaint.relatedVendorId,
      relatedUserId: complaint.relatedUserId,
      assignedTo: complaint.assignedTo,
      assignedToName: complaint.assignedToName,
      submittedAt: complaint.submittedAt,
      resolvedAt: complaint.resolvedAt,
      resolvedBy: complaint.resolvedBy,
      resolution: complaint.resolution,
      rejectionReason: complaint.rejectionReason,
      attachments: complaint.attachments,
      isAnonymous: complaint.isAnonymous,
      category: complaint.category,
      rating: complaint.rating,
      comments: complaint.comments?.map((comment) => CommentModel(
        commentId: comment.commentId,
        complaintId: comment.complaintId,
        commentedBy: comment.commentedBy,
        commentedByName: comment.commentedByName,
        commentedByRole: comment.commentedByRole,
        comment: comment.comment,
        commentedAt: comment.commentedAt,
        isInternal: comment.isInternal,
      )).toList(),
    );
    
    MockDataSource.complaints.add(newComplaint);
    
    return ComplaintEntity(
      complaintId: newComplaint.complaintId,
      complaintType: newComplaint.complaintType,
      submittedBy: newComplaint.submittedBy,
      submittedByName: newComplaint.submittedByName,
      submittedByRole: newComplaint.submittedByRole,
      subject: newComplaint.subject,
      description: newComplaint.description,
      status: newComplaint.status,
      priority: newComplaint.priority,
      relatedOrderId: newComplaint.relatedOrderId,
      relatedVendorId: newComplaint.relatedVendorId,
      relatedUserId: newComplaint.relatedUserId,
      assignedTo: newComplaint.assignedTo,
      assignedToName: newComplaint.assignedToName,
      submittedAt: newComplaint.submittedAt,
      resolvedAt: newComplaint.resolvedAt,
      resolvedBy: newComplaint.resolvedBy,
      resolution: newComplaint.resolution,
      rejectionReason: newComplaint.rejectionReason,
      attachments: newComplaint.attachments,
      isAnonymous: newComplaint.isAnonymous,
      category: newComplaint.category,
      rating: newComplaint.rating,
      comments: newComplaint.comments?.map((comment) => CommentEntity(
        commentId: comment.commentId,
        complaintId: comment.complaintId,
        commentedBy: comment.commentedBy,
        commentedByName: comment.commentedByName,
        commentedByRole: comment.commentedByRole,
        comment: comment.comment,
        commentedAt: comment.commentedAt,
        isInternal: comment.isInternal,
      )).toList(),
    );
  }

  @override
  Future<ComplaintEntity> updateComplaint(ComplaintEntity complaint) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.complaints.indexWhere((c) => c.complaintId == complaint.complaintId);
    if (index != -1) {
      final updatedComplaint = MockDataSource.complaints[index].copyWith(
        status: complaint.status,
        priority: complaint.priority,
        assignedTo: complaint.assignedTo,
        assignedToName: complaint.assignedToName,
        resolvedAt: complaint.resolvedAt,
        resolvedBy: complaint.resolvedBy,
        resolution: complaint.resolution,
        rejectionReason: complaint.rejectionReason,
        comments: complaint.comments?.map((comment) => CommentModel(
          commentId: comment.commentId,
          complaintId: comment.complaintId,
          commentedBy: comment.commentedBy,
          commentedByName: comment.commentedByName,
          commentedByRole: comment.commentedByRole,
          comment: comment.comment,
          commentedAt: comment.commentedAt,
          isInternal: comment.isInternal,
        )).toList(),
      );
      
      MockDataSource.complaints[index] = updatedComplaint;
      
      return ComplaintEntity(
        complaintId: updatedComplaint.complaintId,
        complaintType: updatedComplaint.complaintType,
        submittedBy: updatedComplaint.submittedBy,
        submittedByName: updatedComplaint.submittedByName,
        submittedByRole: updatedComplaint.submittedByRole,
        subject: updatedComplaint.subject,
        description: updatedComplaint.description,
        status: updatedComplaint.status,
        priority: updatedComplaint.priority,
        relatedOrderId: updatedComplaint.relatedOrderId,
        relatedVendorId: updatedComplaint.relatedVendorId,
        relatedUserId: updatedComplaint.relatedUserId,
        assignedTo: updatedComplaint.assignedTo,
        assignedToName: updatedComplaint.assignedToName,
        submittedAt: updatedComplaint.submittedAt,
        resolvedAt: updatedComplaint.resolvedAt,
        resolvedBy: updatedComplaint.resolvedBy,
        resolution: updatedComplaint.resolution,
        rejectionReason: updatedComplaint.rejectionReason,
        attachments: updatedComplaint.attachments,
        isAnonymous: updatedComplaint.isAnonymous,
        category: updatedComplaint.category,
        rating: updatedComplaint.rating,
        comments: updatedComplaint.comments?.map((comment) => CommentEntity(
          commentId: comment.commentId,
          complaintId: comment.complaintId,
          commentedBy: comment.commentedBy,
          commentedByName: comment.commentedByName,
          commentedByRole: comment.commentedByRole,
          comment: comment.comment,
          commentedAt: comment.commentedAt,
          isInternal: comment.isInternal,
        )).toList(),
      );
    }
    
    throw Exception('Complaint not found');
  }

  @override
  Future<ComplaintEntity> assignComplaint(String complaintId, String assignedTo, String assignedToName) async {
    final complaint = await getComplaintById(complaintId);
    if (complaint != null) {
      final updatedComplaint = complaint.copyWith(
        assignedTo: assignedTo,
        assignedToName: assignedToName,
        status: 'in_progress',
      );
      return updateComplaint(updatedComplaint);
    }
    throw Exception('Complaint not found');
  }

  @override
  Future<ComplaintEntity> resolveComplaint(String complaintId, String resolution, String resolvedBy) async {
    final complaint = await getComplaintById(complaintId);
    if (complaint != null) {
      final updatedComplaint = complaint.copyWith(
        status: 'resolved',
        resolution: resolution,
        resolvedBy: resolvedBy,
        resolvedAt: DateTime.now().toIso8601String(),
      );
      return updateComplaint(updatedComplaint);
    }
    throw Exception('Complaint not found');
  }

  @override
  Future<ComplaintEntity> rejectComplaint(String complaintId, String rejectionReason) async {
    final complaint = await getComplaintById(complaintId);
    if (complaint != null) {
      final updatedComplaint = complaint.copyWith(
        status: 'rejected',
        rejectionReason: rejectionReason,
      );
      return updateComplaint(updatedComplaint);
    }
    throw Exception('Complaint not found');
  }

  @override
  Future<CommentEntity> addComment(CommentEntity comment) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final newComment = CommentModel(
      commentId: 'comment_${MockDataSource.comments.length + 1}',
      complaintId: comment.complaintId,
      commentedBy: comment.commentedBy,
      commentedByName: comment.commentedByName,
      commentedByRole: comment.commentedByRole,
      comment: comment.comment,
      commentedAt: comment.commentedAt,
      isInternal: comment.isInternal,
    );
    
    MockDataSource.comments.add(newComment);
    
    return CommentEntity(
      commentId: newComment.commentId,
      complaintId: newComment.complaintId,
      commentedBy: newComment.commentedBy,
      commentedByName: newComment.commentedByName,
      commentedByRole: newComment.commentedByRole,
      comment: newComment.comment,
      commentedAt: newComment.commentedAt,
      isInternal: newComment.isInternal,
    );
  }

  @override
  Future<List<CommentEntity>> getCommentsByComplaint(String complaintId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final comments = MockDataSource.getCommentsByComplaint(complaintId);
    return comments.map((comment) => CommentEntity(
      commentId: comment.commentId,
      complaintId: comment.complaintId,
      commentedBy: comment.commentedBy,
      commentedByName: comment.commentedByName,
      commentedByRole: comment.commentedByRole,
      comment: comment.comment,
      commentedAt: comment.commentedAt,
      isInternal: comment.isInternal,
    )).toList();
  }

  @override
  Future<Map<String, dynamic>> getComplaintStatistics() async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    return MockDataSource.getComplaintStatistics();
  }

  @override
  Future<Map<String, dynamic>> getComplaintTrends({String? period}) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    return MockDataSource.getComplaintTrends(period: period);
  }

  @override
  Future<List<ComplaintEntity>> searchComplaints(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final complaints = MockDataSource.searchComplaints(query);
    return complaints.map((complaint) => ComplaintEntity(
      complaintId: complaint.complaintId,
      complaintType: complaint.complaintType,
      submittedBy: complaint.submittedBy,
      submittedByName: complaint.submittedByName,
      submittedByRole: complaint.submittedByRole,
      subject: complaint.subject,
      description: complaint.description,
      status: complaint.status,
      priority: complaint.priority,
      relatedOrderId: complaint.relatedOrderId,
      relatedVendorId: complaint.relatedVendorId,
      relatedUserId: complaint.relatedUserId,
      assignedTo: complaint.assignedTo,
      assignedToName: complaint.assignedToName,
      submittedAt: complaint.submittedAt,
      resolvedAt: complaint.resolvedAt,
      resolvedBy: complaint.resolvedBy,
      resolution: complaint.resolution,
      rejectionReason: complaint.rejectionReason,
      attachments: complaint.attachments,
      isAnonymous: complaint.isAnonymous,
      category: complaint.category,
      rating: complaint.rating,
      comments: complaint.comments?.map((comment) => CommentEntity(
        commentId: comment.commentId,
        complaintId: comment.complaintId,
        commentedBy: comment.commentedBy,
        commentedByName: comment.commentedByName,
        commentedByRole: comment.commentedByRole,
        comment: comment.comment,
        commentedAt: comment.commentedAt,
        isInternal: comment.isInternal,
      )).toList(),
    )).toList();
  }
}
