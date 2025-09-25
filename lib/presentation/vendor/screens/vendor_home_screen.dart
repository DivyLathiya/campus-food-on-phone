import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';

class VendorHomeScreen extends StatelessWidget {
  const VendorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vendor Dashboard'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(const AuthLogoutRequested());
              },
            ),
          ],
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Section
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome, ${state.name}!',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Vendor Dashboard',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Quick Stats
                    const Text(
                      'Quick Stats',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'Pending Orders',
                            '5',
                            Icons.pending_actions,
                            AppTheme.warningColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            'Today\'s Revenue',
                            '₹2245.00',
                            Icons.attach_money,
                            AppTheme.successColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Vendor Actions
                    const Text(
                      'Vendor Actions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Use Wrap widget instead of GridView for better scrolling behavior
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 64) / 2, // Account for padding and spacing
                          height: 160, // Fixed height for consistent card sizes (increased to prevent overflow)
                          child: _buildQuickActionCard(
                            context,
                            icon: Icons.receipt_long,
                            title: 'Manage Orders',
                            subtitle: 'View & process orders',
                            onTap: () {
                              Navigator.pushNamed(context, '/vendor/orders');
                            },
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 64) / 2,
                          height: 160, // Fixed height for consistent card sizes (increased to prevent overflow)
                          child: _buildQuickActionCard(
                            context,
                            icon: Icons.restaurant_menu,
                            title: 'Menu Management',
                            subtitle: 'Edit menu items',
                            onTap: () {
                              Navigator.pushNamed(context, '/vendor/menu');
                            },
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 64) / 2,
                          height: 160, // Fixed height for consistent card sizes (increased to prevent overflow)
                          child: _buildQuickActionCard(
                            context,
                            icon: Icons.analytics,
                            title: 'Sales Reports',
                            subtitle: 'View analytics',
                            onTap: () {
                              final state = context.read<AuthBloc>().state;
                              if (state is AuthAuthenticated) {
                                Navigator.pushNamed(context, '/vendor/sales-reports', arguments: state.userId);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 64) / 2,
                          height: 160, // Fixed height for consistent card sizes (increased to prevent overflow)
                          child: _buildQuickActionCard(
                            context,
                            icon: Icons.local_offer,
                            title: 'Discounts',
                            subtitle: 'Manage promotions',
                            onTap: () {
                              Navigator.pushNamed(context, '/vendor/discounts');
                            },
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 64) / 2,
                          height: 160, // Fixed height for consistent card sizes (increased to prevent overflow)
                          child: _buildQuickActionCard(
                            context,
                            icon: Icons.access_time,
                            title: 'Pickup Slots',
                            subtitle: 'Manage time slots',
                            onTap: () {
                              final state = context.read<AuthBloc>().state;
                              if (state is AuthAuthenticated) {
                                Navigator.pushNamed(context, '/vendor/pickup-slots', arguments: state.userId);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Reduced padding to save space
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 36, // Reduced icon size
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 4), // Reduced spacing
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14, // Reduced font size
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2, // Limit to 2 lines
                  overflow: TextOverflow.ellipsis, // Handle overflow
                ),
              ),
              const SizedBox(height: 2),
              Expanded(
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11, // Reduced font size
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2, // Limit to 2 lines
                  overflow: TextOverflow.ellipsis, // Handle overflow
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
