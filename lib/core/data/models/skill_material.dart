import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';

class SkillMaterial {
  final int? id;
  final String description;
  final int tier;
  final int realm;
  final String icon;
  final int family;

  SkillMaterial({
    this.id,
    required this.description,
    required this.tier,
    required this.realm,
    required this.icon,
    required this.family,
  });

  factory SkillMaterial.fromMap(Map<String, Object?> map) => SkillMaterial(
        id: map['id'] as int?,
        description: map['description'] as String,
        tier: map['tier'] as int,
        realm: map['realm'] as int,
        icon: map['icon'] as String,
        family: map['family'] as int,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'description': description,
        'tier': tier,
        'realm': realm,
        'icon': icon,
        'family': family,
      };

  @override
  String toString() {
    return 'SkillMaterial{id: $id, description: $description, tier: $tier, realm: $realm, icon: $icon, family: $family}';
  }

  // CRUD functions
  static Future<int> insert(SkillMaterial skillMaterial) async {
    final db = await DBHelper().database;
    return await db.insert(
      'SkillMaterials',
      skillMaterial.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<SkillMaterial?> get(int id) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'SkillMaterials',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return SkillMaterial.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(SkillMaterial skillMaterial) async {
    final db = await DBHelper().database;
    return await db.update(
      'SkillMaterials',
      skillMaterial.toMap(),
      where: 'id = ?',
      whereArgs: [skillMaterial.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'SkillMaterials',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<SkillMaterial>> getAll() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('SkillMaterials');
    return List.generate(maps.length, (i) {
      return SkillMaterial.fromMap(maps[i]);
    });
  }
}
