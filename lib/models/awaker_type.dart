import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class AwakerType {
  final int? id;
  final String description;

  AwakerType({this.id, required this.description});

  factory AwakerType.fromMap(Map<String, Object?> map) => AwakerType(
        id: map['id'] as int?,
        description: map['description'] as String,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'description': description,
      };

  @override
  String toString() {
    return 'AwakerType{id: $id, description: $description}';
  }

  // CRUD functions
  static Future<int> insert(AwakerType awakerType) async {
    final db = await DBHelper().database;
    return await db.insert(
      'AwakerType',
      awakerType.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<AwakerType?> get(int id) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'AwakerType',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return AwakerType.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(AwakerType awakerType) async {
    final db = await DBHelper().database;
    return await db.update(
      'AwakerType',
      awakerType.toMap(),
      where: 'id = ?',
      whereArgs: [awakerType.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'AwakerType',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<AwakerType>> getAll() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('AwakerType');
    return List.generate(maps.length, (i) {
      return AwakerType.fromMap(maps[i]);
    });
  }
}
