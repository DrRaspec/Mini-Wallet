import 'package:intl/intl.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';

String formatCurrency(double amount) => '\$${amount.toStringAsFixed(2)}';

String formatTransactionAmount(TransactionModel transaction) {
  final prefix = transaction.isIncome ? '+' : '-';
  return '$prefix${formatCurrency(transaction.amount)}';
}

String formatTransactionDate(DateTime date) {
  return DateFormat('dd MMM yyyy').format(date);
}

String formatTransactionDay(DateTime date) {
  return DateFormat('EEEE, dd MMM').format(date);
}
