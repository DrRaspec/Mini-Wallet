import 'package:mini_wallet/core/services/database_service.dart';
import 'package:mini_wallet/features/transaction/data/models/account_balance.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:sqflite/sqlite_api.dart';

class TransactionLocalDataSource {
  final DatabaseService dbService;

  TransactionLocalDataSource(this.dbService);

  // Create
  Future<void> saveTransaction(TransactionModel tx) async {
    final db = await dbService.database;

    await db.insert(
      dbService.transactionsTable,
      tx.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read All
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await dbService.database;

    final result = await db.query(
      dbService.transactionsTable,
      orderBy: 'date DESC',
    );

    return result.map((e) => TransactionModel.fromMap(e)).toList();
  }

  // Read by ID
  Future<TransactionModel?> getTransactionById(String id) async {
    final db = await dbService.database;
    final result = await db.query(
      dbService.transactionsTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) return null;
    return TransactionModel.fromMap(result.first);
  }

  // Read total balance
  Future<AccountBalance> getAccountBalance() async {
    final db = await dbService.database;
    final result = await db.rawQuery('''
      SELECT 
        SUM(CASE WHEN isIncome = 1 THEN amount ELSE 0 END) AS income,
        SUM(CASE WHEN isIncome = 0 THEN amount ELSE 0 END) AS expense
      FROM ${dbService.transactionsTable}
      ''');

    final income = _toDouble(result.first['income']);
    final expense = _toDouble(result.first['expense']);

    return AccountBalance(
      income: income,
      expense: expense,
      total: income - expense,
    );
  }

  // Update
  Future<void> updateTransaction(TransactionModel tx) async {
    final db = await dbService.database;

    await db.update(
      dbService.transactionsTable,
      tx.toMap(),
      where: 'id = ?',
      whereArgs: [tx.id],
    );
  }

  // Delete
  Future<void> deleteTransaction(String id) async {
    final db = await dbService.database;

    await db.delete(
      dbService.transactionsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Clear all transactions (for testing or reset)
  Future<void> clearAll() async {
    final db = await dbService.database;
    await db.delete('transactions');
  }

  double _toDouble(Object? value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
