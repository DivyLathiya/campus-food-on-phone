import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/admin/bloc/admin_message_bloc.dart';
import 'package:campus_food_app/domain/entities/user_entity.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';

class AdminMessageScreen extends StatelessWidget {
  const AdminMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminMessageBloc(
        notificationRepository: context.read(),
        userRepository: context.read(),
      )..add(const LoadUsers()),
      child: const AdminMessageView(),
    );
  }
}

class AdminMessageView extends StatefulWidget {
  const AdminMessageView({super.key});

  @override
  State<AdminMessageView> createState() => _AdminMessageViewState();
}

class _AdminMessageViewState extends State<AdminMessageView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  String? _selectedUserId;
  List<String> _selectedUserIds = [];
  bool _isBroadcast = false;

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Admin Messages'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<AdminMessageBloc, AdminMessageState>(
        listener: (context, state) {
          if (state is AdminMessageSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Admin message sent successfully!'),
                backgroundColor: AppTheme.successColor,
              ),
            );
            _clearForm();
          } else if (state is AdminMessageBroadcastSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Admin message broadcast to ${state.recipientCount} users!'),
                backgroundColor: AppTheme.successColor,
              ),
            );
            _clearForm();
          } else if (state is AdminMessageError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AdminMessageLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AdminMessageError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: AppTheme.errorColor),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AdminMessageBloc>().add(const LoadUsers());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is AdminMessageUsersLoaded) {
            return _buildMessageForm(context, state.users);
          }

          if (state is AdminMessageSending) {
            return Stack(
              children: [
                _buildMessageForm(context, []),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildMessageForm(BuildContext context, List<UserEntity> users) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Message Type Selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Message Type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('Send to Individual User'),
                            value: false,
                            groupValue: _isBroadcast,
                            onChanged: (value) {
                              setState(() {
                                _isBroadcast = value!;
                                _selectedUserId = null;
                                _selectedUserIds = [];
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('Broadcast to Multiple Users'),
                            value: true,
                            groupValue: _isBroadcast,
                            onChanged: (value) {
                              setState(() {
                                _isBroadcast = value!;
                                _selectedUserId = null;
                                _selectedUserIds = [];
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // User Selection
            if (!_isBroadcast) _buildIndividualUserSelection(users),
            if (_isBroadcast) _buildBroadcastUserSelection(users),
            const SizedBox(height: 16),

            // Message Content
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Message Content',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                        hintText: 'Enter message title',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(),
                        hintText: 'Enter your message',
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a message';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Send Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _sendMessage(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  _isBroadcast ? 'Send Broadcast' : 'Send Message',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndividualUserSelection(List<UserEntity> users) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select User',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedUserId,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User',
                hintText: 'Select a user',
              ),
              items: users.map((user) {
                return DropdownMenuItem<String>(
                  value: user.userId,
                  child: Text('${user.name} (${user.email})'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedUserId = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a user';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBroadcastUserSelection(List<UserEntity> users) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Users',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedUserIds = users.map((u) => u.userId).toList();
                        });
                      },
                      child: const Text('Select All'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedUserIds = [];
                        });
                      },
                      child: const Text('Clear All'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${_selectedUserIds.length} of ${users.length} users selected',
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final isSelected = _selectedUserIds.contains(user.userId);
                  return CheckboxListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          _selectedUserIds.add(user.userId);
                        } else {
                          _selectedUserIds.remove(user.userId);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_isBroadcast && (_selectedUserId == null || _selectedUserId!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a user'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    if (_isBroadcast && _selectedUserIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one user'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    if (!_isBroadcast) {
      context.read<AdminMessageBloc>().add(
        SendAdminMessage(
          userId: _selectedUserId!,
          title: _titleController.text.trim(),
          message: _messageController.text.trim(),
        ),
      );
    } else {
      context.read<AdminMessageBloc>().add(
        SendBroadcastAdminMessage(
          userIds: _selectedUserIds,
          title: _titleController.text.trim(),
          message: _messageController.text.trim(),
        ),
      );
    }
  }

  void _clearForm() {
    _titleController.clear();
    _messageController.clear();
    setState(() {
      _selectedUserId = null;
      _selectedUserIds = [];
      _isBroadcast = false;
    });
    context.read<AdminMessageBloc>().add(const ClearAdminMessageForm());
  }
}
