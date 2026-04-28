import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_wallet/core/theme/app_colors.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/add_transaction_controller.dart';
import 'package:mini_wallet/features/transaction/presentation/widgets/transaction_card.dart';
import 'package:mini_wallet/routes/route_paths.dart';

class AddTransactionPage extends GetView<AddTransactionController> {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('Add Transaction'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Form(
            key: controller.addTransactionFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Record a new entry',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Keep it quick and minimal. Add the title, amount, and whether it is money in or out.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(
                        () => SegmentedButton<bool>(
                          segments: const [
                            ButtonSegment<bool>(
                              value: true,
                              icon: Icon(Icons.south_west_rounded),
                              label: Text('Income'),
                            ),
                            ButtonSegment<bool>(
                              value: false,
                              icon: Icon(Icons.north_east_rounded),
                              label: Text('Expense'),
                            ),
                          ],
                          selected: {controller.isIncome.value},
                          onSelectionChanged: (selection) {
                            controller.isIncome.value = selection.first;
                          },
                          showSelectedIcon: false,
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size.fromHeight(54),
                            ),
                            side: MaterialStateProperty.all(BorderSide.none),
                            backgroundColor: MaterialStateProperty.resolveWith((
                              states,
                            ) {
                              if (states.contains(MaterialState.selected)) {
                                return AppColors.primary;
                              }
                              return AppColors.surfaceMuted;
                            }),
                            foregroundColor: MaterialStateProperty.resolveWith((
                              states,
                            ) {
                              if (states.contains(MaterialState.selected)) {
                                return Colors.white;
                              }
                              return AppColors.textSecondary;
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Title',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.titleController,
                        validator: controller.validateTitle,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Salary, groceries, coffee...',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Amount',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.amountController,
                        validator: controller.validateAmount,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          hintText: '0.00',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Preview',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                _TransactionPreview(controller: controller),
                const SizedBox(height: 24),
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                              final didSave = await controller
                                  .onAddTransaction();
                              if (!context.mounted || !didSave) {
                                return;
                              }
                              context.go(RoutePaths.home);
                            },
                      child: controller.isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Save Transaction'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TransactionPreview extends StatelessWidget {
  const _TransactionPreview({required this.controller});

  final AddTransactionController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller.titleController,
      builder: (context, titleValue, _) {
        return ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller.amountController,
          builder: (context, amountValue, __) {
            return Obx(() {
              final title = titleValue.text.trim().isEmpty
                  ? 'Untitled transaction'
                  : titleValue.text.trim();
              final amount = double.tryParse(amountValue.text.trim()) ?? 0;
              final preview = TransactionModel(
                id: 'preview',
                title: title,
                amount: amount,
                isIncome: controller.isIncome.value,
                date: DateTime.now(),
              );

              return Opacity(
                opacity: amount > 0 ? 1 : 0.78,
                child: TransactionCard(transaction: preview),
              );
            });
          },
        );
      },
    );
  }
}
