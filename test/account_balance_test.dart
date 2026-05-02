import 'package:flutter_test/flutter_test.dart';
import 'package:mini_wallet/features/transaction/data/models/account_balance.dart';

void main() {
  test('AccountBalance.fromMap handles int and double values', () {
    final balance = AccountBalance.fromMap({
      'income': 100, // int
      'expense': 50.5, // double
      'total': '49.5', // string that can be parsed to double
    });

    expect(balance.income, equals(100));
    expect(balance.expense, equals(50.5));
    expect(balance.total, equals(49.5));
  });
}
