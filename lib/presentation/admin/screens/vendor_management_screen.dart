import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/admin/bloc/vendor_management_bloc.dart';
import 'package:campus_food_app/presentation/admin/bloc/vendor_management_event.dart';
import 'package:campus_food_app/presentation/admin/bloc/vendor_management_state.dart';
import 'package:campus_food_app/domain/entities/enhanced_vendor_entity.dart';

class VendorManagementScreen extends StatelessWidget {
  const VendorManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VendorManagementBloc(
        vendorRepository: context.read(),
      )..add(const LoadVendors()),
      child: const VendorManagementView(),
    );
  }
}

class VendorManagementView extends StatefulWidget {
  const VendorManagementView({super.key});

  @override
  State<VendorManagementView> createState() => _VendorManagementViewState();
}

class _VendorManagementViewState extends State<VendorManagementView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Management'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pending'),
            Tab(text: 'Approved'),
            Tab(text: 'Rejected'),
            Tab(text: 'Suspended'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _showExportDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatsCards(context),
          Expanded(
            child: BlocBuilder<VendorManagementBloc, VendorManagementState>(
              builder: (context, state) {
                if (state is VendorManagementLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is VendorsLoaded) {
                  List<EnhancedVendorEntity> vendors;
                  switch (_tabController.index) {
                    case 0:
                      vendors = state.vendors;
                      break;
                    case 1:
                      vendors = state.pendingVendors;
                      break;
                    case 2:
                      vendors = state.approvedVendors;
                      break;
                    case 3:
                      vendors = state.rejectedVendors;
                      break;
                    case 4:
                      vendors = state.suspendedVendors;
                      break;
                    default:
                      vendors = state.vendors;
                  }

                  if (_searchQuery.isNotEmpty) {
                    vendors = vendors.where((vendor) {
                      final query = _searchQuery.toLowerCase();
                      return vendor.name.toLowerCase().contains(query) ||
                          vendor.description.toLowerCase().contains(query) ||
                          (vendor.location?.toLowerCase().contains(query) ?? false);
                    }).toList();
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<VendorManagementBloc>().add(const RefreshVendors());
                    },
                    child: ListView.builder(
                      itemCount: vendors.length,
                      itemBuilder: (context, index) {
                        final vendor = vendors[index];
                        return _buildVendorCard(context, vendor);
                      },
                    ),
                  );
                } else if (state is VendorOperationFailure) {
                  return Center(child: Text('Error: ${state.error}'));
                } else {
                  return const Center(child: Text('No vendors found'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards(BuildContext context) {
    return BlocBuilder<VendorManagementBloc, VendorManagementState>(
      builder: (context, state) {
        if (state is VendorsLoaded) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildStatCard('Total', state.vendorStats['total'].toString(), Colors.blue),
                const SizedBox(width: 8),
                _buildStatCard('Pending', state.vendorStats['pending'].toString(), Colors.orange),
                const SizedBox(width: 8),
                _buildStatCard('Approved', state.vendorStats['approved'].toString(), Colors.green),
                const SizedBox(width: 8),
                _buildStatCard('KYC Pending', state.vendorStats['kyc_pending'].toString(), Colors.purple),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVendorCard(BuildContext context, EnhancedVendorEntity vendor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: _getStatusColor(vendor.status),
              child: Text(
                vendor.name.isNotEmpty ? vendor.name[0].toUpperCase() : 'V',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vendor.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    vendor.location ?? 'No location',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            _buildStatusBadge(vendor.status),
          ],
        ),
        subtitle: Text('KYC: ${vendor.kycStatus.toUpperCase()}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Description', vendor.description),
                _buildInfoRow('Owner ID', vendor.ownerId ?? 'N/A'),
                _buildInfoRow('Phone', vendor.phoneNumber ?? 'N/A'),
                _buildInfoRow('Email', 'N/A'), // Email not available in EnhancedVendorEntity
                _buildInfoRow('Business License', vendor.businessLicense ?? 'N/A'),
                _buildInfoRow('Tax ID', vendor.taxId ?? 'N/A'),
                _buildInfoRow('Bank Account', vendor.bankAccount ?? 'N/A'),
                _buildInfoRow('Bank Name', vendor.bankName ?? 'N/A'),
                _buildInfoRow('Account Holder', vendor.accountHolderName ?? 'N/A'),
                if (vendor.kycVerifiedAt != null)
                  _buildInfoRow('KYC Verified At', vendor.kycVerifiedAt!),
                if (vendor.kycRejectedReason != null)
                  _buildInfoRow('KYC Rejection Reason', vendor.kycRejectedReason!),
                const SizedBox(height: 16),
                _buildActionButtons(context, vendor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'open':
      case 'approved':
        color = Colors.green;
        break;
      case 'pending':
        color = Colors.orange;
        break;
      case 'rejected':
        color = Colors.red;
        break;
      case 'suspended':
        color = Colors.grey;
        break;
      default:
        color = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, EnhancedVendorEntity vendor) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (vendor.isPendingApproval)
            ElevatedButton.icon(
              onPressed: () => _showApproveDialog(context, vendor),
              icon: const Icon(Icons.check),
              label: const Text('Approve'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          if (vendor.isPendingApproval)
            ElevatedButton.icon(
              onPressed: () => _showRejectDialog(context, vendor),
              icon: const Icon(Icons.close),
              label: const Text('Reject'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          if (vendor.isKycPending && !vendor.isPendingApproval)
            ElevatedButton.icon(
              onPressed: () => _showVerifyKYCDialog(context, vendor),
              icon: const Icon(Icons.verified),
              label: const Text('Verify KYC'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          if (vendor.isKycPending && !vendor.isPendingApproval)
            ElevatedButton.icon(
              onPressed: () => _showRejectKYCDialog(context, vendor),
              icon: const Icon(Icons.cancel),
              label: const Text('Reject KYC'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
          if (vendor.isActive)
            ElevatedButton.icon(
              onPressed: () => _showSuspendDialog(context, vendor),
              icon: const Icon(Icons.pause),
              label: const Text('Suspend'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            ),
          if (vendor.status == 'suspended')
            ElevatedButton.icon(
              onPressed: () => _showReactivateDialog(context, vendor),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Reactivate'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      case 'suspended':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Vendors'),
        content: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Enter vendor name, description, or location',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Vendor Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('CSV'),
              onTap: () {
                Navigator.pop(context);
                context.read<VendorManagementBloc>().add(
                  const ExportVendorsData(format: 'csv'),
                );
              },
            ),
            ListTile(
              title: const Text('JSON'),
              onTap: () {
                Navigator.pop(context);
                context.read<VendorManagementBloc>().add(
                  const ExportVendorsData(format: 'json'),
                );
              },
            ),
            ListTile(
              title: const Text('PDF'),
              onTap: () {
                Navigator.pop(context);
                context.read<VendorManagementBloc>().add(
                  const ExportVendorsData(format: 'pdf'),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showApproveDialog(BuildContext context, EnhancedVendorEntity vendor) {
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Approve ${vendor.name}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure you want to approve this vendor?'),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(
                hintText: 'Add notes (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<VendorManagementBloc>().add(
                ApproveVendor(
                  vendorId: vendor.vendorId,
                  approvedBy: 'admin',
                  notes: notesController.text.isNotEmpty ? notesController.text : null,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Approve'),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context, EnhancedVendorEntity vendor) {
    final reasonController = TextEditingController();
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reject ${vendor.name}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please provide a reason for rejection.'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                hintText: 'Rejection reason *',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(
                hintText: 'Additional notes (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (reasonController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please provide a rejection reason')),
                );
                return;
              }
              Navigator.pop(context);
              context.read<VendorManagementBloc>().add(
                RejectVendor(
                  vendorId: vendor.vendorId,
                  rejectionReason: reasonController.text,
                  rejectedBy: 'admin',
                  notes: notesController.text.isNotEmpty ? notesController.text : null,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  void _showVerifyKYCDialog(BuildContext context, EnhancedVendorEntity vendor) {
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Verify KYC for ${vendor.name}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure you want to verify the KYC for this vendor?'),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(
                hintText: 'Add notes (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<VendorManagementBloc>().add(
                VerifyKYC(
                  vendorId: vendor.vendorId,
                  verifiedBy: 'admin',
                  notes: notesController.text.isNotEmpty ? notesController.text : null,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text('Verify KYC'),
          ),
        ],
      ),
    );
  }

  void _showRejectKYCDialog(BuildContext context, EnhancedVendorEntity vendor) {
    final reasonController = TextEditingController();
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reject KYC for ${vendor.name}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please provide a reason for KYC rejection.'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                hintText: 'KYC rejection reason *',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(
                hintText: 'Additional notes (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (reasonController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please provide a KYC rejection reason')),
                );
                return;
              }
              Navigator.pop(context);
              context.read<VendorManagementBloc>().add(
                RejectKYC(
                  vendorId: vendor.vendorId,
                  rejectionReason: reasonController.text,
                  rejectedBy: 'admin',
                  notes: notesController.text.isNotEmpty ? notesController.text : null,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Reject KYC'),
          ),
        ],
      ),
    );
  }

  void _showSuspendDialog(BuildContext context, EnhancedVendorEntity vendor) {
    final reasonController = TextEditingController();
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Suspend ${vendor.name}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please provide a reason for suspension.'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                hintText: 'Suspension reason *',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(
                hintText: 'Additional notes (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (reasonController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please provide a suspension reason')),
                );
                return;
              }
              Navigator.pop(context);
              context.read<VendorManagementBloc>().add(
                SuspendVendor(
                  vendorId: vendor.vendorId,
                  suspensionReason: reasonController.text,
                  suspendedBy: 'admin',
                  notes: notesController.text.isNotEmpty ? notesController.text : null,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            child: const Text('Suspend'),
          ),
        ],
      ),
    );
  }

  void _showReactivateDialog(BuildContext context, EnhancedVendorEntity vendor) {
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reactivate ${vendor.name}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure you want to reactivate this vendor?'),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(
                hintText: 'Add notes (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<VendorManagementBloc>().add(
                ReactivateVendor(
                  vendorId: vendor.vendorId,
                  reactivatedBy: 'admin',
                  notes: notesController.text.isNotEmpty ? notesController.text : null,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Reactivate'),
          ),
        ],
      ),
    );
  }
}
