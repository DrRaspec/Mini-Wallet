import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/features/transaction/data/models/account_balance.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/home_controller.dart';

class FakeTransactionRepository implements TransactionRepository {
  @override
  Future<List<TransactionModel>> getAll() async {
    return [
      TransactionModel(
        id: '1',
        title: 'Salary',
        amount: 1000,
        isIncome: true,
        date: DateTime(2026, 4, 28),
      ),
    ];
  }

  @override
  Future<AccountBalance> getAccountBalance() async {
    return AccountBalance(income: 1000, expense: 250, total: 750);
  }

  @override
  Future<TransactionModel?> getById(String id) async => null;

  @override
  Future<void> add(TransactionModel tx) async {}

  @override
  Future<void> update(TransactionModel tx) async {}

  @override
  Future<void> delete(String id) async {}
}

void main() {
  setUp(() {
    Get.testMode = true;
  });

  test('HomeController loads balance and transactions', () async {
    final controller = HomeController(repository: FakeTransactionRepository());

    await controller.fetchTotalBalance();
    await controller.fetchTransactions();

    expect(controller.accountBalance.value.total, 750);
    expect(controller.transactions.length, 1);
    expect(controller.transactions.first.title, 'Salary');
  });
}
