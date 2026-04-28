import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_wallet/core/theme/app_colors.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/add_transaction_controller.dart';
import 'package:mini_wallet/routes/route_paths.dart';

class AddTransactionPage extends GetView<AddTransactionController> {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.addTransactionFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Record a new entry',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Capture what came in or went out so your balance stays accurate.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(8),
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
                              const Size.fromHeight(52),
                            ),
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
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                              final didSave =
                                  await controller.onAddTransaction();
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
