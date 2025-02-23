import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;
  static const String _databaseName = 'morimens_planner.db';
  static const int _databaseVersion = 2;

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
      CREATE TABLE SkillMaterials (
        id INTEGER PRIMARY KEY,
        description TEXT NOT NULL,
        tier INTEGER NOT NULL,
        realm INTEGER NOT NULL,
        icon TEXT NOT NULL,
        FOREIGN KEY (realm) REFERENCES Realm(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE AdvancedSkillMaterials (
        id INTEGER PRIMARY KEY,
        description TEXT NOT NULL,
        icon TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE EdifyMaterials (
        id INTEGER PRIMARY KEY,
        description TEXT NOT NULL,
        tier INTEGER NOT NULL,
        realm INTEGER NOT NULL,
        icon TEXT NOT NULL,
        FOREIGN KEY (realm) REFERENCES Realm(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE Awakers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        realm INTEGER NOT NULL,
        type INTEGER NOT NULL,
        skillMaterial INTEGER NOT NULL,
        edifyMaterial INTEGER NOT NULL,
        advancedSkillMaterial INTEGER NOT NULL,
        level INTEGER NOT NULL,
        FOREIGN KEY (realm) REFERENCES Realm(id),
        FOREIGN KEY (type) REFERENCES AwakerType(id)
        FOREIGN KEY (skillMaterial) REFERENCES SkillMaterials(id),
        FOREIGN KEY (edifyMaterial) REFERENCES EdifyMaterials(id),
        FOREIGN KEY (advancedSkillMaterial) REFERENCES AdvancedSkillMaterials(id),
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
