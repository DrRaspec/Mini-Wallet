import 'package:get/get.dart';
import 'package:mini_wallet/core/utils/app_logger.dart';
import 'package:mini_wallet/features/transaction/data/models/account_balance.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';

class HomeController extends GetxController {
  final TransactionRepository repository;

  HomeController({required this.repository});

  final isLoadingTransaction = false.obs;
  final isLoadingBalance = false.obs;
  final transactions = <TransactionModel>[].obs;
  final accountBalance = AccountBalance(
    income: 0.0,
    expense: 0.0,
    total: 0.0,
  ).obs;

  @override
  void onInit() async {
    await refreshHome();
    super.onInit();
  }

  Future<void> refreshHome() async {
    await fetchTotalBalance();
    await fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      isLoadingTransaction.value = true;
      transactions.value = await repository.getAll();
    } catch (e) {
      AppLogger.log('Error fetching transactions: $e');
    } finally {
      isLoadingTransaction.value = false;
    }
  }

  Future<void> fetchTotalBalance() async {
    try {
      isLoadingBalance.value = true;
      accountBalance.value = await repository.getAccountBalance();
      AppLogger.log('Fetched account balance: ${accountBalance.value}');
    } catch (e) {
      AppLogger.log('Error fetching total balance: $e');
    } finally {
      isLoadingBalance.value = false;
    }
  }
}
