import 'package:mini_wallet/features/transaction/data/datasources/transaction_local_ds.dart';
import 'package:mini_wallet/features/transaction/data/models/account_balance.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionLocalDataSource local;

  TransactionRepositoryImpl({required this.local});

  @override
  Future<void> add(TransactionModel tx) {
    return local.saveTransaction(tx);
  }

  @override
  Future<List<TransactionModel>> getAll() {
    return local.getAllTransactions();
  }

  @override
  Future<AccountBalance> getAccountBalance() {
    return local.getAccountBalance();
  }

  @override
  Future<TransactionModel?> getById(String id) {
    return local.getTransactionById(id);
  }

  @override
  Future<void> update(TransactionModel tx) {
    return local.updateTransaction(tx);
  }

  @override
  Future<void> delete(String id) {
    return local.deleteTransaction(id);
  }
}
