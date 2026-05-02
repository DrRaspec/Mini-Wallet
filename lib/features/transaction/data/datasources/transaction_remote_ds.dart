import 'package:dio/dio.dart';
import 'package:mini_wallet/core/constants/api_endpoints.dart';
import 'package:mini_wallet/core/network/api_client.dart';
import 'package:mini_wallet/core/utils/app_logger.dart';
import 'package:mini_wallet/features/transaction/data/models/account_balance.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';

class TransactionRemoteDataSource {
  TransactionRemoteDataSource(this.apiClient);

  final ApiClient apiClient;

  Future<void> saveTransaction(TransactionModel tx) async {
    try {
      await apiClient.dio.post(ApiEndpoints.transactions, data: tx.toMap());
    } on DioException catch (e) {
      AppLogger.log('Error saving transaction: ${e.message}');
      rethrow;
    }
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    try {
      final res = await apiClient.dio.get(ApiEndpoints.transactions);
      final data = res.data as List<dynamic>;

      return data
          .map((e) => TransactionModel.fromMap(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      AppLogger.log('Error fetching transactions: ${e.message}');
      rethrow;
    }
  }

  Future<TransactionModel?> getTransactionById(String id) async {
    try {
      final res = await apiClient.dio.get(ApiEndpoints.transactionById(id));

      if (res.data == null) return null;

      return TransactionModel.fromMap(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }

      AppLogger.log('Error fetching transaction: ${e.message}');
      rethrow;
    }
  }

  Future<AccountBalance> getAccountBalance() async {
    try {
      final res = await apiClient.dio.get(ApiEndpoints.transactionBalance);

      return AccountBalance.fromMap(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      AppLogger.log('Error fetching account balance: ${e.message}');
      rethrow;
    }
  }

  Future<void> updateTransaction(TransactionModel tx) async {
    try {
      await apiClient.dio.put(
        ApiEndpoints.transactionById(tx.id),
        data: tx.toMap(),
      );
    } on DioException catch (e) {
      AppLogger.log('Error update transaction: ${e.message}');
      rethrow;
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      await apiClient.dio.delete(ApiEndpoints.transactionById(id));
    } on DioException catch (e) {
      AppLogger.log('Error deleting transaction: ${e.message}');
      rethrow;
    }
  }
}
