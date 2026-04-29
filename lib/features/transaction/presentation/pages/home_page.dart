import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_wallet/core/theme/app_colors.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/home_controller.dart';
import 'package:mini_wallet/features/transaction/presentation/transaction_formatters.dart';
import 'package:mini_wallet/features/transaction/presentation/widgets/transaction_card.dart';
import 'package:mini_wallet/routes/route_names.dart';
import 'package:mini_wallet/routes/route_paths.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final transactions = controller.transactions.toList();
          final isLoading = controller.isLoadingTransaction.value;
          final incomeTotal = controller.accountBalance.value.income;
          final expenseTotal = controller.accountBalance.value.expense;
          final balance = controller.accountBalance.value.total;

          if (isLoading && transactions.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.secondary),
            );
          }

          return RefreshIndicator(
            color: AppColors.secondary,
            onRefresh: controller.refreshHome,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // ── Header ──────────────────────────────────────────
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  sliver: SliverToBoxAdapter(
                    child: _TopBar(theme: theme),
                  ),
                ),

                // ── Balance card ────────────────────────────────────
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                  sliver: SliverToBoxAdapter(
                    child: _BalanceSection(
                      balance: balance,
                      incomeTotal: incomeTotal,
                      expenseTotal: expenseTotal,
                    ),
                  ),
                ),

                // ── Quick add banner ────────────────────────────────
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  sliver: SliverToBoxAdapter(
                    child: _QuickAddBanner(
                      onAddPressed: () => context.go(RoutePaths.addTransaction),
                      isEmpty: transactions.isEmpty,
                    ),
                  ),
                ),

                // ── Section header ──────────────────────────────────
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Activity',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (transactions.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceMuted,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              '${transactions.length}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // ── Transaction list / empty state ──────────────────
                if (transactions.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: _EmptyState(theme: theme),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final transaction = transactions[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom:
                                index == transactions.length - 1 ? 0 : 8,
                          ),
                          child: TransactionCard(
                            transaction: transaction,
                            onTap: () async {
                              final shouldRefresh = await context
                                  .pushNamed<bool>(
                                    RouteNames.transactionDetails,
                                    extra: transaction,
                                  );

                              if (shouldRefresh == true && context.mounted) {
                                await controller.refreshHome();
                              }
                            },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RoutePaths.addTransaction),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Top bar — greeting + avatar
// ─────────────────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  const _TopBar({required this.theme});
  final ThemeData theme;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Wave icon
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(
            child: Text('MW', style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            )),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _greeting.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Mini Wallet',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        // Decorative wave icon (matches reference)
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.surfaceMuted,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.textPrimary,
            size: 20,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Balance section — big amount + income/expense tiles
// ─────────────────────────────────────────────────────────────────────────────
class _BalanceSection extends StatelessWidget {
  const _BalanceSection({
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Wallet Balance',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          formatCurrency(balance),
          style: theme.textTheme.displaySmall?.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 20),

        // Income / Expense tiles
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Income',
                value: formatCurrency(incomeTotal),
                icon: Icons.south_west_rounded,
                backgroundColor: AppColors.income.withValues(alpha: 0.08),
                iconColor: AppColors.income,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: 'Expense',
                value: formatCurrency(expenseTotal),
                icon: Icons.north_east_rounded,
                backgroundColor: AppColors.secondary.withValues(alpha: 0.10),
                iconColor: AppColors.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 14),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Quick add banner
// ─────────────────────────────────────────────────────────────────────────────
class _QuickAddBanner extends StatelessWidget {
  const _QuickAddBanner({
    required this.onAddPressed,
    required this.isEmpty,
  });

  final VoidCallback onAddPressed;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEmpty ? 'Get started' : 'Keep it current',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isEmpty
                      ? 'Add your first transaction'
                      : 'Record the next one',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Material(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onAddPressed,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty state
// ─────────────────────────────────────────────────────────────────────────────
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
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.secondary,
              size: 32,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No transactions yet',
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add an income or expense and your\nwallet summary will appear here.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
