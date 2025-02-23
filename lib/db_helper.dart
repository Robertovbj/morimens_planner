import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'migrations/migration_v2.dart';
import 'migrations/migration_v3.dart';
import 'seed/seed_data.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;
  static const String _databaseName = 'morimens_planner.db';
  static const int _databaseVersion = 3;

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
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Realm (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL,
        icon TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE AwakerType (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL
      )
    ''');
    
    await db.execute('''
      CREATE TABLE EdifyMaterialFamily (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE SkillMaterialFamily (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE SkillMaterials (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL,
        tier INTEGER NOT NULL,
        realm INTEGER NOT NULL,
        icon TEXT NOT NULL,
        family INTEGER NOT NULL,
        FOREIGN KEY (realm) REFERENCES Realm(id),
        FOREIGN KEY (family) REFERENCES SkillMaterialFamily(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE AdvancedSkillMaterials (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL,
        icon TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE EdifyMaterials (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL,
        tier INTEGER NOT NULL,
        realm INTEGER NOT NULL,
        icon TEXT NOT NULL,
        family INTEGER NOT NULL,
        FOREIGN KEY (realm) REFERENCES Realm(id),
        FOREIGN KEY (family) REFERENCES EdifyMaterialFamily(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE Awakers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        realm INTEGER NOT NULL,
        type INTEGER NOT NULL,
        skillMaterialFamily INTEGER NOT NULL,
        edifyMaterialFamily INTEGER NOT NULL,
        advancedSkillMaterial INTEGER NOT NULL,
        level INTEGER NOT NULL,
        FOREIGN KEY (realm) REFERENCES Realm(id),
        FOREIGN KEY (type) REFERENCES AwakerType(id)
        FOREIGN KEY (skillMaterialFamily) REFERENCES SkillMaterialFamily(id),
        FOREIGN KEY (edifyMaterialFamily) REFERENCES EdifyMaterialFamily(id),
        FOREIGN KEY (advancedSkillMaterial) REFERENCES AdvancedSkillMaterials(id),
      )
    ''');

    await DatabaseSeeder(db).seed();
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await MigrationV2().upgrade(db);
    }
    if (oldVersion < 3) {
      await MigrationV3().upgrade(db);
    }
    await DatabaseSeeder(db).seedUpgrade(oldVersion, newVersion);
  }
}
