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

    return Scaffold(
      appBar: AppBar(title: const Text('Transaction')),
      body: SafeArea(
        child: Obx(() {
          final transaction = controller.selectedTransaction.value;
          if (transaction == null) {
            return const SizedBox.shrink();
          }

          final isIncome = transaction.isIncome;
          final toneColor = isIncome ? AppColors.income : AppColors.expense;

          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: toneColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(16),
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
                      const SizedBox(height: 6),
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
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _InfoRow(
                        label: 'Type',
                        value: isIncome ? 'Income' : 'Expense',
                        valueColor: toneColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Divider(color: AppColors.border, height: 1),
                      ),
                      _InfoRow(
                        label: 'Date',
                        value: formatTransactionDay(transaction.date),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Divider(color: AppColors.border, height: 1),
                      ),
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
          );
        }),
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
    final errorColor = AppColors.expense;

    return SizedBox(
      height: 52,
      child: isDeleting
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.secondary),
            )
          : OutlinedButton.icon(
              onPressed: onDeleteTap,
              icon: const Icon(Icons.delete_outline_rounded, size: 20),
              label: const Text('Delete'),
              style: OutlinedButton.styleFrom(
                foregroundColor: errorColor,
                side: BorderSide(color: errorColor.withValues(alpha: 0.30)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
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
    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onEditTap,
        icon: const Icon(Icons.edit_outlined, size: 20),
        label: const Text('Edit transaction'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
