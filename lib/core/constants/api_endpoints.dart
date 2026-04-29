class ApiEndpoints {
  ApiEndpoints._();

  static const String transactions = '/transactions';
  static const String transactionBalance = '/transactions/balance';

  static String transactionById(String id) {
    return '$transactions/$id';
  }
}
