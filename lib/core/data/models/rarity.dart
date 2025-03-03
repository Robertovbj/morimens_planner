import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';

class Rarity {
  final int? id;
  final String description;

  Rarity({this.id, required this.description});

  factory Rarity.fromMap(Map<String, Object?> map) => Rarity(
        id: map['id'] as int?,
        description: map['description'] as String,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'description': description,
      };

  @override
  String toString() {
    return 'Rarity{id: $id, description: $description}';
  }

  // CRUD functions
  static Future<int> insert(Rarity rarity) async {
    final db = await DBHelper().database;
    return await db.insert(
      'Rarity',
      rarity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Rarity?> get(int id) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'Rarity',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Rarity.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(Rarity rarity) async {
    final db = await DBHelper().database;
    return await db.update(
      'Rarity',
      rarity.toMap(),
      where: 'id = ?',
      whereArgs: [rarity.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'Rarity',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Rarity>> getAll() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('Rarity');
    return List.generate(maps.length, (i) {
      return Rarity.fromMap(maps[i]);
    });
  }
}
