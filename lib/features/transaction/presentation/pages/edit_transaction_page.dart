import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/theme/app_colors.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/edit_transaction_controller.dart';
import 'package:mini_wallet/features/transaction/presentation/widgets/transaction_card.dart';

class EditTransactionPage extends GetView<EditTransactionController> {
  const EditTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Get.back()),
        title: const Text('Edit Transaction'),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.transaction.value == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Open a transaction detail before editing.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: context.appTextSecondary,
                  ),
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Form(
              key: controller.editTransactionFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Update this entry',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: context.appTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Adjust the title, amount, or type.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: context.appTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: context.appCard,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Type',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: context.appTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SegmentedButton<bool>(
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
                            minimumSize: WidgetStateProperty.all(
                              const Size.fromHeight(54),
                            ),
                            side: WidgetStateProperty.all(BorderSide.none),
                            backgroundColor: WidgetStateProperty.resolveWith((
                              states,
                            ) {
                              if (states.contains(WidgetState.selected)) {
                                return context.appPrimary;
                              }
                              return context.appSurfaceMuted;
                            }),
                            foregroundColor: WidgetStateProperty.resolveWith((
                              states,
                            ) {
                              if (states.contains(WidgetState.selected)) {
                                return Colors.white;
                              }
                              return context.appTextSecondary;
                            }),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          'Title',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: context.appTextPrimary,
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
                        const SizedBox(height: 22),
                        Text(
                          'Amount',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: context.appTextPrimary,
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
                  const SizedBox(height: 24),
                  Text(
                    'Preview',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: context.appTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _TransactionPreview(controller: controller),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                              final updatedTransaction = await controller
                                  .onUpdateTransaction();
                              if (!context.mounted ||
                                  updatedTransaction == null) {
                                return;
                              }
                              Get.back(result: updatedTransaction);
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
                          : const Text('Save Changes'),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _TransactionPreview extends StatelessWidget {
  const _TransactionPreview({required this.controller});

  final EditTransactionController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller.titleController,
      builder: (context, titleValue, _) {
        return ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller.amountController,
          builder: (context, amountValue, _) {
            return Obx(() {
              final currentTransaction = controller.transaction.value;
              final title = titleValue.text.trim().isEmpty
                  ? 'Untitled transaction'
                  : titleValue.text.trim();
              final amount = double.tryParse(amountValue.text.trim()) ?? 0;
              final preview = TransactionModel(
                id: currentTransaction?.id ?? 'preview',
                title: title,
                amount: amount,
                isIncome: controller.isIncome.value,
                date: currentTransaction?.date ?? DateTime.now(),
              );

              return Opacity(
                opacity: amount > 0 ? 1 : 0.6,
                child: TransactionCard(transaction: preview),
              );
            });
          },
        );
      },
    );
  }
}
