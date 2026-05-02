import 'package:mini_wallet/features/transaction/data/datasources/transaction_remote_ds.dart';
import 'package:mini_wallet/features/transaction/data/models/account_balance.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionRemoteDataSource remote;

  TransactionRepositoryImpl({required this.remote});

  @override
  Future<void> add(TransactionModel tx) {
    return remote.saveTransaction(tx);
  }

  @override
  Future<List<TransactionModel>> getAll() {
    return remote.getAllTransactions();
  }

  @override
  Future<AccountBalance> getAccountBalance() {
    return remote.getAccountBalance();
  }

  @override
  Future<TransactionModel?> getById(String id) {
    return remote.getTransactionById(id);
  }

  @override
  Future<void> update(TransactionModel tx) {
    return remote.updateTransaction(tx);
  }

  @override
  Future<void> delete(String id) {
    return remote.deleteTransaction(id);
  }
}
