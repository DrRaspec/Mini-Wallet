import 'package:get/get.dart';
import 'package:mini_wallet/core/utils/app_logger.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';

class HomeController extends GetxController {
  final TransactionRepository repository;

  HomeController({required this.repository});

  final isLoading = false.obs;
  final transactions = <TransactionModel>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    await fetchTransactions();
    super.onInit();
  }

  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      transactions.value = await repository.getAll();
    } catch (e) {
      AppLogger.log('Error fetching transactions: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
