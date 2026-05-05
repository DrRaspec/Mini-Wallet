import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/theme/app_colors.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/core/translations/app_keys.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/edit_transaction_controller.dart';
import 'package:mini_wallet/features/transaction/presentation/widgets/transaction_card.dart';

class EditTransactionPage extends GetView<EditTransactionController> {
  const EditTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Get.back()),
        title: Text(AppKeys.editTransaction.tr),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.transaction.value == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  AppKeys.openTransactionDetail.tr,
                  textAlign: TextAlign.center,
                  style: Get.theme.textTheme.titleMedium?.copyWith(
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
                    AppKeys.updateEntry.tr,
                    style: Get.theme.textTheme.headlineSmall?.copyWith(
                      color: context.appTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppKeys.updateEntryDesc.tr,
                    style: Get.theme.textTheme.bodyMedium?.copyWith(
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
                          AppKeys.type.tr,
                          style: Get.theme.textTheme.titleMedium?.copyWith(
                            color: context.appTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SegmentedButton<bool>(
                          segments: [
                            ButtonSegment<bool>(
                              value: true,
                              icon: const Icon(Icons.south_west_rounded),
                              label: Text(AppKeys.income.tr),
                            ),
                            ButtonSegment<bool>(
                              value: false,
                              icon: const Icon(Icons.north_east_rounded),
                              label: Text(AppKeys.expenses.tr),
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
                          AppKeys.title.tr,
                          style: Get.theme.textTheme.titleMedium?.copyWith(
                            color: context.appTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: controller.titleController,
                          validator: controller.validateTitle,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: AppKeys.titleHint.tr,
                          ),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          AppKeys.amount.tr,
                          style: Get.theme.textTheme.titleMedium?.copyWith(
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
                    AppKeys.preview.tr,
                    style: Get.theme.textTheme.titleMedium?.copyWith(
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
                          : Text(AppKeys.saveChanges.tr),
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
                  ? AppKeys.untitledTransaction.tr
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
