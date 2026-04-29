import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_wallet/core/theme/app_colors.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/edit_transaction_controller.dart';
import 'package:mini_wallet/features/transaction/presentation/widgets/transaction_card.dart';
import 'package:mini_wallet/routes/route_names.dart';

class EditTransactionPage extends GetView<EditTransactionController> {
  const EditTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Transactions')),
      body: SafeArea(
        child: Obx(() {
          final transactions = controller.transactions.toList();
          final isLoading = controller.isLoading.value;

          if (isLoading && transactions.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.secondary),
            );
          }

          return RefreshIndicator(
            color: AppColors.secondary,
            onRefresh: controller.fetchTransactions,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Clean up your history',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Open any transaction to review, or swipe left to remove.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (transactions.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          'Nothing to manage yet.',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final transaction = transactions[index];

                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index == transactions.length - 1 ? 0 : 8,
                          ),
                          child: Dismissible(
                            key: ValueKey(transaction.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              decoration: BoxDecoration(
                                color: AppColors.expense,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.white,
                              ),
                            ),
                            confirmDismiss: (_) async {
                              return showDialog<bool>(
                                context: context,
                                builder: (dialogContext) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: const Text('Delete transaction?'),
                                    content: const Text(
                                      'This action cannot be undone.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(
                                            dialogContext,
                                          ).pop(false);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(dialogContext).pop(true);
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: AppColors.expense,
                                        ),
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onDismissed: (_) {
                              controller.deleteTransaction(transaction.id);
                            },
                            child: TransactionCard(
                              transaction: transaction,
                              onTap: () => context.pushNamed(
                                RouteNames.transactionDetails,
                                extra: transaction,
                              ),
                            ),
                          ),
                        );
                      }, childCount: transactions.length),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
