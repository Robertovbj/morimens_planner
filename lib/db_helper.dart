import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;
  static const String _databaseName = 'morimens_planner.db';
  static const int _databaseVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
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
      CREATE TABLE AwakerType (
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
        critical_rate REAL NOT NULL,  -- Percentage value
        critical_damage REAL NOT NULL,
        realm_mastery INTEGER NOT NULL,
        strong_attack REAL NOT NULL,  -- Percentage value
        aliemus_recharge INTEGER NOT NULL,
        silver_key_recharge INTEGER NOT NULL,
        black_sigil_drop_rate REAL NOT NULL,  -- Percentage value
        resistance REAL NOT NULL,  -- Percentage value
        level INTEGER NOT NULL,
        FOREIGN KEY (realm) REFERENCES Realm(id),
        FOREIGN KEY (type) REFERENCES AwakerType(id)
      )
    ''');

    await db.insert('Realm', {'id': 1, 'description': 'Chaos', 'icon': 'chaos_icon'});
    await db.insert('Realm', {'id': 2, 'description': 'Aequor', 'icon': 'aequor_icon'});
    await db.insert('Realm', {'id': 3, 'description': 'Caro', 'icon': 'caro_icon'});
    await db.insert('Realm', {'id': 4, 'description': 'Ultra', 'icon': 'ultra_icon'});

    await db.insert('AwakerType', {'id': 1, 'description': 'Damage'});
    await db.insert('AwakerType', {'id': 2, 'description': 'Defense'});
    await db.insert('AwakerType', {'id': 3, 'description': 'Assist'});
  }

}
