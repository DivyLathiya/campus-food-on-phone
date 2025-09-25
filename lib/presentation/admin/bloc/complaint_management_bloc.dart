import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/domain/entities/complaint_entity.dart';
import 'package:campus_food_app/domain/repositories/complaint_repository.dart';
import 'package:campus_food_app/presentation/admin/bloc/complaint_management_event.dart';
import 'package:campus_food_app/presentation/admin/bloc/complaint_management_state.dart';

class ComplaintManagementBloc extends Bloc<ComplaintManagementEvent, ComplaintManagementState> {
  final ComplaintRepository complaintRepository;

  ComplaintManagementBloc({required this.complaintRepository}) : super(const ComplaintManagementInitial()) {
    on<LoadComplaints>(_onLoadComplaints);
    on<LoadComplaintDetails>(_onLoadComplaintDetails);
    on<AssignComplaint>(_onAssignComplaint);
    on<ResolveComplaint>(_onResolveComplaint);
    on<RejectComplaint>(_onRejectComplaint);
    on<AddComment>(_onAddComment);
    on<LoadComplaintComments>(_onLoadComplaintComments);
    on<UpdateComplaintPriority>(_onUpdateComplaintPriority);
    on<SearchComplaints>(_onSearchComplaints);
    on<LoadComplaintStatistics>(_onLoadComplaintStatistics);
    on<LoadComplaintTrends>(_onLoadComplaintTrends);
    on<ExportComplaintsData>(_onExportComplaintsData);
    on<RefreshComplaints>(_onRefreshComplaints);
  }

  Future<void> _onLoadComplaints(
    LoadComplaints event,
    Emitter<ComplaintManagementState> emit,
  ) async {
    emit(const ComplaintManagementLoading());
    
    try {
      List<ComplaintEntity> complaints;
      
      if (event.status != null) {
        complaints = await complaintRepository.getComplaintsByStatus(event.status!);
      } else if (event.priority != null) {
        complaints = await complaintRepository.getComplaintsByPriority(event.priority!);
      } else if (event.category != null) {
        complaints = await complaintRepository.getComplaintsByCategory(event.category!);
      } else if (event.type != null) {
        complaints = await complaintRepository.getComplaintsByType(event.type!);
      } else {
        complaints = await complaintRepository.getAllComplaints();
      }

      final pendingComplaints = complaints.where((c) => c.isPending).toList();
      final inProgressComplaints = complaints.where((c) => c.isInProgress).toList();
      final resolvedComplaints = complaints.where((c) => c.isResolved).toList();
      final rejectedComplaints = complaints.where((c) => c.isRejected).toList();

      final complaintStats = {
        'total': complaints.length,
        'pending': pendingComplaints.length,
        'in_progress': inProgressComplaints.length,
        'resolved': resolvedComplaints.length,
        'rejected': rejectedComplaints.length,
        'urgent': complaints.where((c) => c.priority == 'urgent').length,
        'high': complaints.where((c) => c.priority == 'high').length,
        'medium': complaints.where((c) => c.priority == 'medium').length,
        'low': complaints.where((c) => c.priority == 'low').length,
        'student_complaints': complaints.where((c) => c.complaintType == 'student_complaint').length,
        'vendor_complaints': complaints.where((c) => c.complaintType == 'vendor_complaint').length,
        'feedback': complaints.where((c) => c.complaintType == 'feedback').length,
      };

      emit(ComplaintsLoaded(
        complaints: complaints,
        pendingComplaints: pendingComplaints,
        inProgressComplaints: inProgressComplaints,
        resolvedComplaints: resolvedComplaints,
        rejectedComplaints: rejectedComplaints,
        complaintStats: complaintStats,
      ));
    } catch (e) {
      emit(ComplaintOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadComplaintDetails(
    LoadComplaintDetails event,
    Emitter<ComplaintManagementState> emit,
  ) async {
    try {
      final complaint = await complaintRepository.getComplaintById(event.complaintId);
      final comments = await complaintRepository.getCommentsByComplaint(event.complaintId);
      
      if (complaint != null) {
        emit(ComplaintDetailsLoaded(
          complaint: complaint,
          comments: comments,
        ));
      } else {
        emit(const ComplaintOperationFailure(error: 'Complaint not found'));
      }
    } catch (e) {
      emit(ComplaintOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onAssignComplaint(
    AssignComplaint event,
    Emitter<ComplaintManagementState> emit,
  ) async {
    try {
      final result = await complaintRepository.assignComplaint(
        event.complaintId,
        event.assignedTo,
        event.assignedToName,
      );
      
      emit(ComplaintOperationSuccess(
        message: 'Complaint assigned successfully',
        complaint: result,
      ));

      // Reload complaints list
      add(const LoadComplaints());
    } catch (e) {
      emit(ComplaintOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onResolveComplaint(
    ResolveComplaint event,
    Emitter<ComplaintManagementState> emit,
  ) async {
    try {
      final result = await complaintRepository.resolveComplaint(
        event.complaintId,
        event.resolution,
        event.resolvedBy,
      );
      
      emit(ComplaintOperationSuccess(
        message: 'Complaint resolved successfully',
        complaint: result,
      ));

      // Reload complaints list
      add(const LoadComplaints());
    } catch (e) {
      emit(ComplaintOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onRejectComplaint(
    RejectComplaint event,
    Emitter<ComplaintManagementState> emit,
  ) async {
    try {
      final result = await complaintRepository.rejectComplaint(
        event.complaintId,
        event.rejectionReason,
      );
      
      emit(ComplaintOperationSuccess(
        message: 'Complaint rejected successfully',
        complaint: result,
      ));

      // Reload complaints list
      add(const LoadComplaints());
    } catch (e) {
      emit(ComplaintOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onAddComment(
    AddComment event,
    Emitter<ComplaintManagementState> emit,
  ) async {
    try {
      await complaintRepository.addComment(event.comment);
      
      emit(ComplaintOperationSuccess(
        message: 'Comment added successfully',
      ));

      // Reload comments for this complaint
      add(LoadComplaintComments(complaintId: event.comment.complaintId));
    } catch (e) {
      emit(ComplaintOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadComplaintComments(
    LoadComplaintComments event,
    Emitter<ComplaintManagementState> emit,
  ) async {
    try {
      final comments = await complaintRepository.getCommentsByComplaint(event.complaintId);
      
      emit(ComplaintCommentsLoaded(comments: comments));
    } catch (e) {
      emit(ComplaintOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onUpdateComplaintPriority(
    UpdateComplaintPriority event,
    Emitter<ComplaintManagementState> emit,
  ) async {
    try {
      final complaint = await complaintRepository.getComplaintById(event.complaintId);
      
      if (complaint != null) {
        final updatedComplaint = complaint.copyWith(priority: event.priority);
        final result = await complaintRepository.updateComplaint(updatedComplaint);
        
        emit(ComplaintOperationSuccess(
          message: 'Priority updated successfully',
          complaint: result,
        ));

        // Reload complaints list
        add(const LoadComplaints());
      } else {
        emit(const ComplaintOperationFailure(error: 'Complaint not found'));
      }
    } catch (e) {
      emit(ComplaintOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onSearchComplaints(
    SearchComplaints event,
    Emitter<ComplaintManagementState> emit,
  ) async {
    try {
      final filteredComplaints = await complaintRepository.searchComplaints(event.query);
      
      emit(ComplaintsFiltered(
        filteredComplaints: filteredComplaints,
        filter: event.query,
      ));
    } catch (e) {
      emit(ComplaintOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadComplaintStatistics(
    LoadComplaintStatistics event,
    Emitter<ComplaintManagementState> emit,
  ) async {
    try {
      final statistics = await complaintRepository.getComplaintStatistics();
      
      emit(ComplaintStatisticsLoaded(statistics: statistics));
    } catch (e) {
      emit(ComplaintOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadComplaintTrends(
    LoadComplaintTrends event,
    Emitter<ComplaintManagementState> emit,
  ) async {
    try {
      final trends = await complaintRepository.getComplaintTrends(period: event.period);
      
      emit(ComplaintTrendsLoaded(trends: trends));
    } catch (e) {
      emit(ComplaintOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onExportComplaintsData(
    ExportComplaintsData event,
    Emitter<ComplaintManagementState> emit,
  ) async {
    try {
      // Mock export functionality
      final downloadUrl = '/api/exports/complaints.${event.format}?timestamp=${DateTime.now().millisecondsSinceEpoch}';
      
      emit(ComplaintDataExported(
        downloadUrl: downloadUrl,
        format: event.format,
      ));
    } catch (e) {
      emit(ComplaintOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onRefreshComplaints(
    RefreshComplaints event,
    Emitter<ComplaintManagementState> emit,
  ) async {
    add(const LoadComplaints());
  }
}
