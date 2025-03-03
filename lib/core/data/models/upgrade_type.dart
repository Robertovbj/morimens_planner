import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';

class UpgradeType {
  final int? id;
  final String description;

  UpgradeType({this.id, required this.description});

  factory UpgradeType.fromMap(Map<String, Object?> map) => UpgradeType(
        id: map['id'] as int?,
        description: map['description'] as String,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'description': description,
      };

  @override
  String toString() {
    return 'UpgradeType{id: $id, description: $description}';
  }

  // CRUD functions
  static Future<int> insert(UpgradeType upgradeType) async {
    final db = await DBHelper().database;
    return await db.insert(
      'UpgradeType',
      upgradeType.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<UpgradeType?> get(int id) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'UpgradeType',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return UpgradeType.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(UpgradeType upgradeType) async {
    final db = await DBHelper().database;
    return await db.update(
      'UpgradeType',
      upgradeType.toMap(),
      where: 'id = ?',
      whereArgs: [upgradeType.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'UpgradeType',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<UpgradeType>> getAll() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('UpgradeType');
    return List.generate(maps.length, (i) {
      return UpgradeType.fromMap(maps[i]);
    });
  }
}
