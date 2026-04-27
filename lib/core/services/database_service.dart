import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  final String databaseName = 'mini_wallet.db';
  final int databaseVersion = 1;
  final String transactionsTable = 'transactions';

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), databaseName);

    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $transactionsTable (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            amount REAL NOT NULL,
            isIncome INTEGER NOT NULL,
            date TEXT NOT NULL
          )
      ''');
      },
    );
  }
}
