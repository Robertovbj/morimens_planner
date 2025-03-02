import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class UniversalMaterial {
  final int? id;
  final String description;
  final String icon;
  final int family;
  final bool shard;

  UniversalMaterial({
    this.id,
    required this.description,
    required this.icon,
    required this.family,
    required this.shard,
  });

  factory UniversalMaterial.fromMap(Map<String, dynamic> map) =>
      UniversalMaterial(
        id: map['id'] as int?,
        description: map['description'] as String,
        icon: map['icon'] as String,
        family: map['family'] as int,
        shard: map['shard'] == 1,
      );

  Map<String, dynamic> toMap() => {
    'id': id,
    'description': description,
    'icon': icon,
    'family': family,
    'shard': shard ? 1 : 0,
  };

  @override
  String toString() {
    return 'UniversalMaterial{id: $id, description: $description, icon: $icon, family: $family, shard: $shard}';
  }

  // CRUD functions
  static Future<int> insert(UniversalMaterial universalMaterial) async {
    final db = await DBHelper().database;
    return await db.insert(
      'UniversalMaterials',
      universalMaterial.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<UniversalMaterial?> get(int id) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'UniversalMaterials',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return UniversalMaterial.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(UniversalMaterial universalMaterial) async {
    final db = await DBHelper().database;
    return await db.update(
      'UniversalMaterials',
      universalMaterial.toMap(),
      where: 'id = ?',
      whereArgs: [universalMaterial.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'UniversalMaterials',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<UniversalMaterial>> getAll() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(
      'UniversalMaterials',
    );
    return List.generate(maps.length, (i) {
      return UniversalMaterial.fromMap(maps[i]);
    });
  }

  static Future<UniversalMaterial?> getCompleteMaterialFromFamily(
    int familyId,
  ) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'UniversalMaterials',
      where: 'family = ? AND shard = 0',
      whereArgs: [familyId],
    );
    if (maps.isNotEmpty) {
      return UniversalMaterial.fromMap(maps.first);
    }
    return null;
  }
}
