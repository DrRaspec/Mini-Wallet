import 'package:mini_wallet/core/services/database_service.dart';
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
}
