import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';

class Awaker {
  final int? id;
  final String name;
  final int realm;
  final int type;
  final int rarity;
  final int skillMaterialFamily;
  final int edifyMaterialFamily;
  final int advancedSkillMaterial;
  final int universalMaterialFamily;

  Awaker({
    this.id,
    required this.name,
    required this.realm,
    required this.type,
    required this.rarity,
    required this.skillMaterialFamily,
    required this.edifyMaterialFamily,
    required this.advancedSkillMaterial,
    required this.universalMaterialFamily,
  });

  factory Awaker.fromMap(Map<String, Object?> map) => Awaker(
        id: map['id'] as int?,
        name: map['name'] as String,
        realm: (map['realm'] as num?)?.toInt() ?? 0,
        type: (map['type'] as num?)?.toInt() ?? 0,
        rarity: (map['rarity'] as num?)?.toInt() ?? 0,
        skillMaterialFamily: (map['skillMaterialFamily'] as num?)?.toInt() ?? 0,
        edifyMaterialFamily: (map['edifyMaterialFamily'] as num?)?.toInt() ?? 0,
        advancedSkillMaterial: (map['advancedSkillMaterial'] as num?)?.toInt() ?? 0,
        universalMaterialFamily: (map['universalMaterialFamily'] as num?)?.toInt() ?? 0,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'name': name,
        'realm': realm,
        'type': type,
        'rarity': rarity,
        'skillMaterialFamily': skillMaterialFamily,
        'edifyMaterialFamily': edifyMaterialFamily,
        'advancedSkillMaterial': advancedSkillMaterial,
        'universalMaterialFamily': universalMaterialFamily,
      };

  @override
  String toString() {
    return 'Awaker{id: $id, name: $name, realm: $realm, type: $type, rarity: $rarity, skillMaterialFamily: $skillMaterialFamily, edifyMaterialFamily: $edifyMaterialFamily, advancedSkillMaterial: $advancedSkillMaterial, universalMaterialFamily: $universalMaterialFamily}';
  }

  // CRUD functions remain the same
  static Future<int> insert(Awaker awaker) async {
    final db = await DBHelper().database;
    return await db.insert(
      'Awakers',
      awaker.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Awaker?> get(int id) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'Awakers',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Awaker.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(Awaker awaker) async {
    final db = await DBHelper().database;
    return await db.update(
      'Awakers',
      awaker.toMap(),
      where: 'id = ?',
      whereArgs: [awaker.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'Awakers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Awaker>> getAll() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('Awakers');
    return List.generate(maps.length, (i) {
      return Awaker.fromMap(maps[i]);
    });
  }
}
