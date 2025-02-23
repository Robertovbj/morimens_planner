import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class EdifyMaterial {
  final int? id;
  final String description;
  final int tier;
  final int realm;
  final String icon;

  EdifyMaterial({
    this.id,
    required this.description,
    required this.tier,
    required this.realm,
    required this.icon,
  });

  factory EdifyMaterial.fromMap(Map<String, Object?> map) => EdifyMaterial(
        id: map['id'] as int?,
        description: map['description'] as String,
        tier: map['tier'] as int,
        realm: map['realm'] as int,
        icon: map['icon'] as String,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'description': description,
        'tier': tier,
        'realm': realm,
        'icon': icon,
      };

  @override
  String toString() {
    return 'EdifyMaterial{id: $id, description: $description, tier: $tier, realm: $realm, icon: $icon}';
  }

  // CRUD functions
  static Future<int> insert(EdifyMaterial edifyMaterial) async {
    final db = await DBHelper().database;
    return await db.insert(
      'EdifyMaterials',
      edifyMaterial.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<EdifyMaterial?> get(int id) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'EdifyMaterials',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return EdifyMaterial.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(EdifyMaterial edifyMaterial) async {
    final db = await DBHelper().database;
    return await db.update(
      'EdifyMaterials',
      edifyMaterial.toMap(),
      where: 'id = ?',
      whereArgs: [edifyMaterial.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'EdifyMaterials',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<EdifyMaterial>> getAll() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('EdifyMaterials');
    return List.generate(maps.length, (i) {
      return EdifyMaterial.fromMap(maps[i]);
    });
  }
}
