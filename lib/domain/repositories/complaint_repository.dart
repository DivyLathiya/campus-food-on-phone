import 'package:campus_food_app/domain/entities/complaint_entity.dart';

abstract class ComplaintRepository {
  // Get all complaints
  Future<List<ComplaintEntity>> getAllComplaints();
  
  // Get complaints by type
  Future<List<ComplaintEntity>> getComplaintsByType(String complaintType);
  
  // Get complaints by status
  Future<List<ComplaintEntity>> getComplaintsByStatus(String status);
  
  // Get complaints by priority
  Future<List<ComplaintEntity>> getComplaintsByPriority(String priority);
  
  // Get complaints by category
  Future<List<ComplaintEntity>> getComplaintsByCategory(String category);
  
  // Get complaints by submitter
  Future<List<ComplaintEntity>> getComplaintsBySubmitter(String submittedBy);
  
  // Get complaints related to vendor
  Future<List<ComplaintEntity>> getComplaintsByVendor(String vendorId);
  
  // Get complaints related to user
  Future<List<ComplaintEntity>> getComplaintsByUser(String userId);
  
  // Get single complaint by ID
  Future<ComplaintEntity?> getComplaintById(String complaintId);
  
  // Create new complaint
  Future<ComplaintEntity> createComplaint(ComplaintEntity complaint);
  
  // Update complaint
  Future<ComplaintEntity> updateComplaint(ComplaintEntity complaint);
  
  // Assign complaint to admin
  Future<ComplaintEntity> assignComplaint(String complaintId, String assignedTo, String assignedToName);
  
  // Resolve complaint
  Future<ComplaintEntity> resolveComplaint(String complaintId, String resolution, String resolvedBy);
  
  // Reject complaint
  Future<ComplaintEntity> rejectComplaint(String complaintId, String rejectionReason);
  
  // Add comment to complaint
  Future<CommentEntity> addComment(CommentEntity comment);
  
  // Get comments for complaint
  Future<List<CommentEntity>> getCommentsByComplaint(String complaintId);
  
  // Get complaint statistics
  Future<Map<String, dynamic>> getComplaintStatistics();
  
  // Get complaint trends
  Future<Map<String, dynamic>> getComplaintTrends({String? period});
  
  // Search complaints
  Future<List<ComplaintEntity>> searchComplaints(String query);
}
