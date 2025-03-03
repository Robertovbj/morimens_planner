import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';

class EdifyMaterialFamily {
  final int? id;
  final String description;

  EdifyMaterialFamily({this.id, required this.description});

  factory EdifyMaterialFamily.fromMap(Map<String, Object?> map) => EdifyMaterialFamily(
        id: map['id'] as int?,
        description: map['description'] as String,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'description': description,
      };

  @override
  String toString() {
    return 'EdifyMaterialFamily{id: $id, description: $description}';
  }

  // CRUD functions
  static Future<int> insert(EdifyMaterialFamily family) async {
    final db = await DBHelper().database;
    return await db.insert(
      'EdifyMaterialFamily',
      family.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<EdifyMaterialFamily?> get(int id) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'EdifyMaterialFamily',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return EdifyMaterialFamily.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(EdifyMaterialFamily family) async {
    final db = await DBHelper().database;
    return await db.update(
      'EdifyMaterialFamily',
      family.toMap(),
      where: 'id = ?',
      whereArgs: [family.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'EdifyMaterialFamily',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<EdifyMaterialFamily>> getAll() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('EdifyMaterialFamily');
    return List.generate(maps.length, (i) {
      return EdifyMaterialFamily.fromMap(maps[i]);
    });
  }
}
