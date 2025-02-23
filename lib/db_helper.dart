import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

    //#region Seed Data

    //#region Realms
    await db.insert('Realm', {
      'id': 1,
      'description': 'Chaos',
      'icon': 'chaos_icon',
    });
    await db.insert('Realm', {
      'id': 2,
      'description': 'Aequor',
      'icon': 'aequor_icon',
    });
    await db.insert('Realm', {
      'id': 3,
      'description': 'Caro',
      'icon': 'caro_icon',
    });
    await db.insert('Realm', {
      'id': 4,
      'description': 'Ultra',
      'icon': 'ultra_icon',
    });
    //#endregion Realms

    //#region Awaker Types
    await db.insert('AwakerType', {'id': 1, 'description': 'Damage'});
    await db.insert('AwakerType', {'id': 2, 'description': 'Defense'});
    await db.insert('AwakerType', {'id': 3, 'description': 'Assist'});
    //#endregion Awaker Types

    //#region Skill Materials
    await db.insert('SkillMaterials', {
      'id': 1,
      'description': 'Chaos Crystal',
      'realm': 1,
      'tier': 3,
      'icon': 'chaos_crystal.png',
    });
    await db.insert('SkillMaterials', {
      'id': 2,
      'description': 'Gleaming Crystal Butterfly',
      'realm': 1,
      'tier': 2,
      'icon': 'gleaming_crystal_butterfly.png',
    });
    await db.insert('SkillMaterials', {
      'id': 3,
      'description': 'Faded Crystal Butterfly',
      'realm': 1,
      'tier': 1,
      'icon': 'faded_cystal_butterfly.png',
    });
    await db.insert('SkillMaterials', {
      'id': 4,
      'description': 'Ewing Lily',
      'realm': 2,
      'tier': 3,
      'icon': 'ewing_lily.png',
    });
    await db.insert('SkillMaterials', {
      'id': 5,
      'description': 'Tall Sea Lily',
      'realm': 2,
      'tier': 2,
      'icon': 'tall_sea_lily.png',
    });
    await db.insert('SkillMaterials', {
      'id': 6,
      'description': 'Short-Stemmed Sea Lily',
      'realm': 2,
      'tier': 1,
      'icon': 'short_stemmed_sea_lily.png',
    });
    await db.insert('SkillMaterials', {
      'id': 7,
      'description': 'Spore Polymer',
      'realm': 3,
      'tier': 3,
      'icon': 'spore_polymer.png',
    });
    await db.insert('SkillMaterials', {
      'id': 8,
      'description': 'Primal Chrysalis',
      'realm': 3,
      'tier': 2,
      'icon': 'primal_chrysalis.png',
    });
    await db.insert('SkillMaterials', {
      'id': 9,
      'description': 'Dried Insect Pupa',
      'realm': 3,
      'tier': 1,
      'icon': 'dried_insect_pupa.png',
    });
    await db.insert('SkillMaterials', {
      'id': 10,
      'description': 'Yucatan Star',
      'realm': 4,
      'tier': 3,
      'icon': 'yucatan_star.png',
    });
    await db.insert('SkillMaterials', {
      'id': 11,
      'description': 'Metor Shard',
      'realm': 4,
      'tier': 2,
      'icon': 'metor_shard.png',
    });
    await db.insert('SkillMaterials', {
      'id': 12,
      'description': 'Damaged Ore Crystal',
      'realm': 4,
      'tier': 1,
      'icon': 'damaged_ore_crystal.png',
    });
    //#endregion  Skill Materials

    //#region Edify Materials
    await db.insert('EdifyMaterials', {
      'id': 1,
      'description': 'Pure White Secret Tome',
      'realm': 1,
      'tier': 3,
      'icon': 'pure_white_secret_tome.png',
    });
    await db.insert('EdifyMaterials', {
      'id': 2,
      'description': 'Pure White Document',
      'realm': 1,
      'tier': 2,
      'icon': 'pure_white_document.png',
    });
    await db.insert('EdifyMaterials', {
      'id': 3,
      'description': 'Pure White Fragment',
      'realm': 1,
      'tier': 1,
      'icon': 'pure_white_fragment.png',
    });
    await db.insert('EdifyMaterials', {
      'id': 4,
      'description': 'Tempered Mind',
      'realm': 2,
      'tier': 3,
      'icon': 'tempered_mind.png',
    });
    await db.insert('EdifyMaterials', {
      'id': 5,
      'description': 'Tempered Sanity',
      'realm': 2,
      'tier': 2,
      'icon': 'tempered_sanity.png',
    });
    await db.insert('EdifyMaterials', {
      'id': 6,
      'description': 'Tempered Instinct',
      'realm': 2,
      'tier': 1,
      'icon': 'tempered_instinct.png',
    });
    await db.insert('EdifyMaterials', {
      'id': 7,
      'description': 'Mind Dungeon',
      'realm': 3,
      'tier': 3,
      'icon': 'mind_dungeon.png',
    });
    await db.insert('EdifyMaterials', {
      'id': 8,
      'description': 'Emotional Dungeon',
      'realm': 3,
      'tier': 2,
      'icon': 'emotional_dungeon.png',
    });
    await db.insert('EdifyMaterials', {
      'id': 9,
      'description': 'Memory Replica',
      'realm': 3,
      'tier': 1,
      'icon': 'memory_replica.png',
    });
    await db.insert('EdifyMaterials', {
      'id': 10,
      'description': 'Arcane Knowledge Template',
      'realm': 4,
      'tier': 3,
      'icon': 'arcane_knowledge_template.png',
    });
    await db.insert('EdifyMaterials', {
      'id': 11,
      'description': 'Mental Template',
      'realm': 4,
      'tier': 2,
      'icon': 'mental_template.png',
    });
    await db.insert('EdifyMaterials', {
      'id': 12,
      'description': 'Cognitive Template',
      'realm': 4,
      'tier': 1,
      'icon': 'cognitive_template.png',
    });
    //#endregion Edify Materials

    //#region Advanced Skill Materials
    await db.insert('AdvancedSkillMaterials', {
      'id': 1,
      'description': 'Lucky Candy',
      'icon': 'lucky_candy.png',
    });
    await db.insert('AdvancedSkillMaterials', {
      'id': 2,
      'description': 'Wax Figurine Clay',
      'icon': 'wax_figurine_clay.png',
    });
    await db.insert('AdvancedSkillMaterials', {
      'id': 3,
      'description': 'Midnight Shackles',
      'icon': 'midnight_shackles.png',
    });
    await db.insert('AdvancedSkillMaterials', {
      'id': 4,
      'description': 'Dimensional Crystal',
      'icon': 'dimensional_crystal.png',
    });
    await db.insert('AdvancedSkillMaterials', {
      'id': 5,
      'description': 'Devout Holy Heart',
      'icon': 'devout_holy_heart.png',
    });
    await db.insert('AdvancedSkillMaterials', {
      'id': 6,
      'description': 'Crown of the Holy Fetus',
      'icon': 'crown_of_the_holy_fetus.png',
    });
    await db.insert('AdvancedSkillMaterials', {
      'id': 7,
      'description': 'Mother Tree Remains',
      'icon': 'mother_tree_remains.png',
    });
    await db.insert('AdvancedSkillMaterials', {
      'id': 8,
      'description': 'Dreamcatcher',
      'icon': 'dreamcatcher.png',
    });
    //#endregion  Advanced Skill Materials

    //#endregion Seed Data
  }
}
