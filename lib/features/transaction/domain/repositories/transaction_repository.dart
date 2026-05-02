import 'package:mini_wallet/features/transaction/data/models/account_balance.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<List<TransactionModel>> getAll();
  Future<AccountBalance> getAccountBalance();
  Future<TransactionModel?> getById(String id);
  Future<void> add(TransactionModel tx);
  Future<void> update(TransactionModel tx);
  Future<void> delete(String id);
}
