import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/theme/app_colors.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/home_controller.dart';
import 'package:mini_wallet/features/transaction/presentation/widgets/transaction_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Mini Wallet')),
      body: Obx(() {
        final transactions = controller.transactions.toList();
        final isLoading = controller.isLoading.value;

        final incomeTotal = transactions
            .where((item) => item.isIncome)
            .fold<double>(0, (sum, item) => sum + item.amount);
        final expenseTotal = transactions
            .where((item) => !item.isIncome)
            .fold<double>(0, (sum, item) => sum + item.amount);
        final balance = incomeTotal - expenseTotal;

        if (isLoading && transactions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.fetchTransactions,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                sliver: SliverToBoxAdapter(
                  child: _SummaryCard(
                    balance: balance,
                    incomeTotal: incomeTotal,
                    expenseTotal: expenseTotal,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent transactions',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '${transactions.length} total',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (transactions.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _EmptyState(theme: theme),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final transaction = transactions[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == transactions.length - 1 ? 0 : 10,
                        ),
                        child: TransactionCard(transaction: transaction),
                      );
                    }, childCount: transactions.length),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.balance,
    required this.incomeTotal,
    required this.expenseTotal,
  });

  final double balance;
  final double incomeTotal;
  final double expenseTotal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current balance',
            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            _currency(balance),
            style: theme.textTheme.headlineLarge?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _TotalTile(
                  label: 'Income',
                  value: _currency(incomeTotal),
                  icon: Icons.south_west_rounded,
                  tone: AppColors.income,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TotalTile(
                  label: 'Expense',
                  value: _currency(expenseTotal),
                  icon: Icons.north_east_rounded,
                  tone: AppColors.expense,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TotalTile extends StatelessWidget {
  const _TotalTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.tone,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: tone, size: 20),
          const SizedBox(height: 10),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.primary,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No transactions yet',
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Use the Add tab below to record your first income or expense.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

String _currency(double amount) => '\$${amount.toStringAsFixed(2)}';
