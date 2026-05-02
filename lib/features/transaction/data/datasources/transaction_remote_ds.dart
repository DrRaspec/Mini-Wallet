import 'package:dio/dio.dart';
import 'package:mini_wallet/core/constants/api_endpoints.dart';
import 'package:mini_wallet/core/network/api_client.dart';
import 'package:mini_wallet/features/transaction/data/models/account_balance.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';

class TransactionRemoteDataSource {
  TransactionRemoteDataSource(this.apiClient);

  final ApiClient apiClient;

  Future<void> saveTransaction(TransactionModel tx) async {
    await apiClient.dio.post(ApiEndpoints.transactions, data: tx.toMap());
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final res = await apiClient.dio.get(ApiEndpoints.transactions);
    final data = res.data as List<dynamic>;

    return data
        .map((e) => TransactionModel.fromMap(e as Map<String, dynamic>))
        .toList();
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

      rethrow;
    }
  }

  Future<AccountBalance> getAccountBalance() async {
    final res = await apiClient.dio.get(ApiEndpoints.transactionBalance);

    return AccountBalance.fromMap(res.data as Map<String, dynamic>);
  }

  Future<void> updateTransaction(TransactionModel tx) async {
    await apiClient.dio.put(
      ApiEndpoints.transactionById(tx.id),
      data: tx.toMap(),
    );
  }

  Future<void> deleteTransaction(String id) async {
    await apiClient.dio.delete(ApiEndpoints.transactionById(id));
  }
}
