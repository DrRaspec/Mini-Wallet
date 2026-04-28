import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/theme/app_colors.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/transaction_details_controller.dart';
import 'package:mini_wallet/features/transaction/presentation/transaction_formatters.dart';

class TransactionDetailsPage extends GetView<TransactionDetailsController> {
  const TransactionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transaction = controller.transaction;
    final isIncome = transaction.isIncome;
    final toneColor = isIncome ? AppColors.income : AppColors.expense;

    return Scaffold(
      appBar: AppBar(title: const Text('Transaction')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: toneColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        isIncome
                            ? Icons.south_west_rounded
                            : Icons.north_east_rounded,
                        color: toneColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      transaction.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isIncome ? 'Money received' : 'Money spent',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      formatTransactionAmount(transaction),
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: toneColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _InfoRow(
                      label: 'Type',
                      value: isIncome ? 'Income' : 'Expense',
                      valueColor: toneColor,
                    ),
                    const SizedBox(height: 18),
                    _InfoRow(
                      label: 'Date',
                      value: formatTransactionDay(transaction.date),
                    ),
                    const SizedBox(height: 18),
                    _InfoRow(label: 'Reference', value: transaction.id),
                  ],
                ),
              ),

              const Spacer(),

              Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      return _DeleteButton(
                        onDeleteTap: () =>
                            controller.onDeleteTransaction(context),
                        isDeleting: controller.isDeleting.value,
                      );
                    }),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: _EditButton(
                      onEditTap: () => controller.onEdit(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor = AppColors.textPrimary,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: theme.textTheme.titleMedium?.copyWith(color: valueColor),
          ),
        ),
      ],
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({required this.onDeleteTap, required this.isDeleting});

  final VoidCallback onDeleteTap;
  final bool isDeleting;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;

    return SizedBox(
      height: 52,
      child: isDeleting
          ? const CircularProgressIndicator()
          : OutlinedButton.icon(
              onPressed: onDeleteTap,
              icon: const Icon(Icons.delete_outline_rounded, size: 20),
              label: const Text('Delete'),
              style: OutlinedButton.styleFrom(
                foregroundColor: errorColor,
                side: BorderSide(color: errorColor.withValues(alpha: 0.35)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({required this.onEditTap});

  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onEditTap,
        icon: const Icon(Icons.edit_outlined, size: 20),
        label: const Text('Edit transaction'),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
