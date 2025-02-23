import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class Awaker {
  final int? id;
  final String name;
  final int realm;
  final int type;
  final int skillMaterial;
  final int edifyMaterial;
  final int advancedSkillMaterial;

  Awaker({
    this.id,
    required this.name,
    required this.realm,
    required this.type,
    required this.skillMaterial,
    required this.edifyMaterial,
    required this.advancedSkillMaterial,
  });

  factory Awaker.fromMap(Map<String, Object?> map) => Awaker(
        id: map['id'] as int?,
        name: map['name'] as String,
        realm: map['realm'] as int,
        type: map['type'] as int,
        skillMaterial: map['skillMaterial'] as int,
        edifyMaterial: map['edifyMaterial'] as int,
        advancedSkillMaterial: map['advancedSkillMaterial'] as int,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'name': name,
        'realm': realm,
        'type': type,
        'skillMaterial': skillMaterial,
        'edifyMaterial': edifyMaterial,
        'advancedSkillMaterial': advancedSkillMaterial,
      };

  @override
  String toString() {
    return 'Awaker{id: $id, name: $name, realm: $realm, type: $type, skillMaterial: $skillMaterial, edifyMaterial: $edifyMaterial, advancedSkillMaterial: $advancedSkillMaterial}';
  }

  // CRUD functions remain the same
  static Future<int> insert(Awaker awaker) async {
    final db = await DBHelper().database;
    return await db.insert(
      'Awakers',
      awaker.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Awaker?> get(int id) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'Awakers',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Awaker.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(Awaker awaker) async {
    final db = await DBHelper().database;
    return await db.update(
      'Awakers',
      awaker.toMap(),
      where: 'id = ?',
      whereArgs: [awaker.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'Awakers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Awaker>> getAll() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('Awakers');
    return List.generate(maps.length, (i) {
      return Awaker.fromMap(maps[i]);
    });
  }
}
