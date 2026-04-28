import 'package:get/get.dart';
import 'package:mini_wallet/core/utils/app_logger.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/home_controller.dart';

class EditTransactionController extends GetxController {
  EditTransactionController({required this.repository});

  final TransactionRepository repository;

  final isLoading = false.obs;
  final transactions = <TransactionModel>[].obs;

  @override
  void onInit() {
    fetchTransactions();
    super.onInit();
  }

  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      transactions.value = await repository.getAll();
    } catch (e) {
      AppLogger.log('Error fetching transactions for edit page: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteTransaction(String id) async {
    try {
      await repository.delete(id);
      await fetchTransactions();
      if (Get.isRegistered<HomeController>()) {
        await Get.find<HomeController>().refreshHome();
      }
      Get.snackbar(
        'Deleted',
        'Transaction removed successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      AppLogger.log('Error deleting transaction: $e');
      Get.snackbar(
        'Error',
        'Unable to delete transaction right now.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
