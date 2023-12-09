import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('goals.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
     await db.execute('''
      CREATE TABLE User (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          coins INTEGER,
          totalInvested REAL
      )
    ''');
    await db.execute('''
      CREATE TABLE goals(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        targetAmount REAL NOT NULL,
        currentAmount REAL NOT NULL,
        startDate TEXT NOT NULL,
        endDate TEXT NOT NULL
      )
    ''');
    initializeUser();
  }
  Future<void> initializeUser() async {
    final db = await database;
    List<Map> result = await db.query('User', where: 'id = ?', whereArgs: [1]);
    if (result.isEmpty) {
      await db.insert('User', {
        'id': 1,
        'name': 'Hirdesh',
        'coins': 0,
        'totalInvested': 0.0
      });
    }
    print('user added');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
