import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class Realm {
  final int? id;
  final String description;
  final String? icon;

  Realm({this.id, required this.description, this.icon});

  factory Realm.fromMap(Map<String, Object?> map) => Realm(
        id: map['id'] as int?,
        description: map['description'] as String,
        icon: map['icon'] as String?,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'description': description,
        'icon': icon,
      };

  @override
  String toString() {
    return 'Realm{id: $id, description: $description, icon: $icon}';
  }

  // CRUD functions
  static Future<int> insert(Realm realm) async {
    final db = await DBHelper().database;
    return await db.insert(
      'Realm',
      realm.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Realm?> get(int id) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'Realm',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Realm.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(Realm realm) async {
    final db = await DBHelper().database;
    return await db.update(
      'Realm',
      realm.toMap(),
      where: 'id = ?',
      whereArgs: [realm.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'Realm',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Realm>> getAll() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('Realm');
    return List.generate(maps.length, (i) {
      return Realm.fromMap(maps[i]);
    });
  }
}
