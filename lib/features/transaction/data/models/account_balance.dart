import 'dart:convert';

class AccountBalance {
  final double income;
  final double expense;
  final double total;

  AccountBalance({
    required this.income,
    required this.expense,
    required this.total,
  });

  AccountBalance copyWith({double? income, double? expense, double? total}) {
    return AccountBalance(
      income: income ?? this.income,
      expense: expense ?? this.expense,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'income': income,
      'expense': expense,
      'total': total,
    };
  }

  factory AccountBalance.fromMap(Map<String, dynamic> map) {
    return AccountBalance(
      income: _toDouble(map['income']),
      expense: _toDouble(map['expense']),
      total: _toDouble(map['total']),
    );
  }

  static double _toDouble(Object? value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  String toJson() => json.encode(toMap());

  factory AccountBalance.fromJson(String source) =>
      AccountBalance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AccountBalance(income: $income, expense: $expense, total: $total)';

  @override
  bool operator ==(covariant AccountBalance other) {
    if (identical(this, other)) return true;

    return other.income == income &&
        other.expense == expense &&
        other.total == total;
  }

  @override
  int get hashCode => income.hashCode ^ expense.hashCode ^ total.hashCode;
}
