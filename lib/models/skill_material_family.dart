import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class SkillMaterialFamily {
  final int? id;
  final String description;

  SkillMaterialFamily({this.id, required this.description});

  factory SkillMaterialFamily.fromMap(Map<String, Object?> map) => SkillMaterialFamily(
        id: map['id'] as int?,
        description: map['description'] as String,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'description': description,
      };

  @override
  String toString() {
    return 'SkillMaterialFamily{id: $id, description: $description}';
  }

  // CRUD functions
  static Future<int> insert(SkillMaterialFamily family) async {
    final db = await DBHelper().database;
    return await db.insert(
      'SkillMaterialFamily',
      family.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<SkillMaterialFamily?> get(int id) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'SkillMaterialFamily',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return SkillMaterialFamily.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(SkillMaterialFamily family) async {
    final db = await DBHelper().database;
    return await db.update(
      'SkillMaterialFamily',
      family.toMap(),
      where: 'id = ?',
      whereArgs: [family.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'SkillMaterialFamily',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<SkillMaterialFamily>> getAll() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('SkillMaterialFamily');
    return List.generate(maps.length, (i) {
      return SkillMaterialFamily.fromMap(maps[i]);
    });
  }
}
