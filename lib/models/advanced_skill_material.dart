import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class AdvancedSkillMaterial {
  final int? id;
  final String description;
  final String icon;

  AdvancedSkillMaterial({
    this.id,
    required this.description,
    required this.icon,
  });

  factory AdvancedSkillMaterial.fromMap(Map<String, Object?> map) => AdvancedSkillMaterial(
        id: map['id'] as int?,
        description: map['description'] as String,
        icon: map['icon'] as String,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'description': description,
        'icon': icon,
      };

  @override
  String toString() {
    return 'AdvancedSkillMaterial{id: $id, description: $description, icon: $icon}';
  }

  // CRUD functions
  static Future<int> insert(AdvancedSkillMaterial advancedSkillMaterial) async {
    final db = await DBHelper().database;
    return await db.insert(
      'AdvancedSkillMaterials',
      advancedSkillMaterial.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<AdvancedSkillMaterial?> get(int id) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'AdvancedSkillMaterials',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return AdvancedSkillMaterial.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(AdvancedSkillMaterial advancedSkillMaterial) async {
    final db = await DBHelper().database;
    return await db.update(
      'AdvancedSkillMaterials',
      advancedSkillMaterial.toMap(),
      where: 'id = ?',
      whereArgs: [advancedSkillMaterial.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'AdvancedSkillMaterials',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<AdvancedSkillMaterial>> getAll() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('AdvancedSkillMaterials');
    return List.generate(maps.length, (i) {
      return AdvancedSkillMaterial.fromMap(maps[i]);
    });
  }
}
