import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:campus_food_app/presentation/student/bloc/wallet_bloc.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<WalletBloc>().add(LoadWalletBalance(userId: authState.userId));
      context.read<WalletBloc>().add(GetTransactionHistory(userId: authState.userId));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet'),
      ),
      body: BlocConsumer<WalletBloc, WalletState>(
        listener: (context, state) {
          if (state is WalletError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is WalletLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildBalanceCard(context, state),
                const SizedBox(height: 24),
                const Text(
                  'Transaction History',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: _buildTransactionList(state),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, WalletState state) {
    double balance = 0.0;
    if (state is WalletBalanceLoaded) {
      balance = state.balance;
    } else if (state is TransactionHistoryLoaded) {
      // Assuming the balance can be inferred from the latest transaction
    }

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Available Balance',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '₹${balance.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Top-up Balance'),
              onPressed: () => _showTopUpDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList(WalletState state) {
    if (state is TransactionHistoryLoaded) {
      if (state.transactions.isEmpty) {
        return const Center(child: Text('No transactions yet.'));
      }
      return ListView.builder(
        itemCount: state.transactions.length,
        itemBuilder: (context, index) {
          final transaction = state.transactions[index];
          final isCredit = transaction.type == 'credit';
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: ListTile(
              leading: Icon(
                isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                color: isCredit ? AppTheme.successColor : AppTheme.errorColor,
              ),
              title: Text(transaction.description),
              subtitle: Text(DateFormat.yMMMd().add_jm().format(transaction.createdAt)),
              trailing: Text(
                '${isCredit ? '+' : '-'} ₹${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: isCredit ? AppTheme.successColor : AppTheme.errorColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      );
    }
    return const Center(child: Text('Loading transactions...'));
  }

  void _showTopUpDialog(BuildContext context) {
    final amountController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Top-up Wallet'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (₹)',
                prefixText: '₹',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                if (double.tryParse(value) == null || double.parse(value) <= 0) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final amount = double.parse(amountController.text);
                  final authState = context.read<AuthBloc>().state;
                  if (authState is AuthAuthenticated) {
                    context.read<WalletBloc>().add(AddFundsToWallet(
                      userId: authState.userId,
                      amount: amount,
                      paymentMethod: 'credit_card',
                    ));
                  }
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text('Add Funds'),
            ),
          ],
        );
      },
    );
  }
}