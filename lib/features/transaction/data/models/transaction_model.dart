class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final bool isIncome;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.isIncome,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'isIncome': isIncome ? 1 : 0,
      'date': date.toIso8601String(),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      isIncome: map['isIncome'] == 1,
      date: DateTime.parse(map['date'] as String),
    );
  }

  TransactionModel copyWith({
    String? id,
    String? title,
    double? amount,
    bool? isIncome,
    DateTime? date,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      isIncome: isIncome ?? this.isIncome,
      date: date ?? this.date,
    );
  }
}
