import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class Planner {
  final int? id;
  final int awaker;
  final int basicAttackFrom;
  final int basicAttackTo;
  final int basicDefenseFrom;
  final int basicDefenseTo;
  final int exaltFrom;
  final int exaltTo;
  final int rouseFrom;
  final int rouseTo;
  final int skillOneFrom;
  final int skillOneTo;
  final int skillTwoFrom;
  final int skillTwoTo;

  Planner({
    this.id,
    required this.awaker,
    required this.basicAttackFrom,
    required this.basicAttackTo,
    required this.basicDefenseFrom,
    required this.basicDefenseTo,
    required this.exaltFrom,
    required this.exaltTo,
    required this.rouseFrom,
    required this.rouseTo,
    required this.skillOneFrom,
    required this.skillOneTo,
    required this.skillTwoFrom,
    required this.skillTwoTo,
  }) {
    if (basicAttackTo < basicAttackFrom ||
        basicDefenseTo < basicDefenseFrom ||
        exaltTo < exaltFrom ||
        rouseTo < rouseFrom ||
        skillOneTo < skillOneFrom ||
        skillTwoTo < skillTwoFrom) {
      throw ArgumentError('The "to" value must be greater than or equal to the "from" value.');
    }

    if (rouseTo > 6 || skillOneTo > 6 || skillTwoTo > 6) {
      throw ArgumentError('Skill, exalt, and rouse values cannot be greater than 6.');
    }
    if (exaltTo > 60) {
      throw ArgumentError('Skill, exalt, and rouse values cannot be greater than 6.');
    }
  }

  factory Planner.fromMap(Map<String, Object?> map) => Planner(
        id: map['id'] as int?,
        awaker: map['awaker'] as int,
        basicAttackFrom: map['basicAttack_from'] as int,
        basicAttackTo: map['basicAttack_to'] as int,
        basicDefenseFrom: map['basicDefense_from'] as int,
        basicDefenseTo: map['basicDefense_to'] as int,
        exaltFrom: map['exalt_from'] as int,
        exaltTo: map['exalt_to'] as int,
        rouseFrom: map['rouse_from'] as int,
        rouseTo: map['rouse_to'] as int,
        skillOneFrom: map['skillOne_from'] as int,
        skillOneTo: map['skillOne_to'] as int,
        skillTwoFrom: map['skillTwo_from'] as int,
        skillTwoTo: map['skillTwo_to'] as int,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'awaker': awaker,
        'basicAttack_from': basicAttackFrom,
        'basicAttack_to': basicAttackTo,
        'basicDefense_from': basicDefenseFrom,
        'basicDefense_to': basicDefenseTo,
        'exalt_from': exaltFrom,
        'exalt_to': exaltTo,
        'rouse_from': rouseFrom,
        'rouse_to': rouseTo,
        'skillOne_from': skillOneFrom,
        'skillOne_to': skillOneTo,
        'skillTwo_from': skillTwoFrom,
        'skillTwo_to': skillTwoTo,
      };

  @override
  String toString() {
    return 'Planner{id: $id, awaker: $awaker, basicAttackFrom: $basicAttackFrom, basicAttackTo: $basicAttackTo, basicDefenseFrom: $basicDefenseFrom, basicDefenseTo: $basicDefenseTo, exaltFrom: $exaltFrom, exaltTo: $exaltTo, rouseFrom: $rouseFrom, rouseTo: $rouseTo, skillOneFrom: $skillOneFrom, skillOneTo: $skillOneTo, skillTwoFrom: $skillTwoFrom, skillTwoTo: $skillTwoTo}';
  }

  // CRUD functions
  static Future<int> insert(Planner planner) async {
    final db = await DBHelper().database;
    final existingPlanner = await db.query(
      'Planner',
      where: 'awaker = ?',
      whereArgs: [planner.awaker],
    );
    if (existingPlanner.isNotEmpty) {
      throw ArgumentError('A plan with the same awaker already exists.');
    }
    return await db.insert(
      'Planner',
      planner.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Planner?> get(int id) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'Planner',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Planner.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(Planner planner) async {
    final db = await DBHelper().database;
    return await db.update(
      'Planner',
      planner.toMap(),
      where: 'id = ?',
      whereArgs: [planner.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'Planner',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Planner>> getAll() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('Planner');
    return List.generate(maps.length, (i) {
      return Planner.fromMap(maps[i]);
    });
  }
}
