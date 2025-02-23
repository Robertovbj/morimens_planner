import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'morimens_planner.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Realm (
        id INTEGER PRIMARY KEY,
        description TEXT NOT NULL,
        icon TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE Type (
        id INTEGER PRIMARY KEY,
        description TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE Awakers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        realm INTEGER NOT NULL,
        type INTEGER NOT NULL,
        constitution INTEGER NOT NULL,
        attack INTEGER NOT NULL,
        defense INTEGER NOT NULL,
        critical_rate INTEGER NOT NULL,
        critical_damage INTEGER NOT NULL,
        realm_mastery INTEGER NOT NULL,
        strong_attack INTEGER NOT NULL,
        aliemus_recharge INTEGER NOT NULL,
        silver_key_recharge INTEGER NOT NULL,
        black_sigil_drop_rate INTEGER NOT NULL,
        resistance INTEGER NOT NULL,
        level INTEGER NOT NULL,
        FOREIGN KEY (realm) REFERENCES Realm(id),
        FOREIGN KEY (type) REFERENCES Type(id)
      )
    ''');
  }
}
