class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';

  static const String transactions = '/transactions';
  static const String transactionBalance = '/transactions/balance';

  static String transactionById(String id) {
    return '$transactions/$id';
  }
}
