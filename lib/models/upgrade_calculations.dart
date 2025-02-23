import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class UpgradeCalculations {
  final int? id;
  final int from;
  final int to;
  final int type;
  final int tier1;
  final int tier2;
  final int tier3;
  final int advanced;
  final int money;
  final int rarity;

  UpgradeCalculations({
    this.id,
    required this.from,
    required this.to,
    required this.type,
    required this.tier1,
    required this.tier2,
    required this.tier3,
    required this.advanced,
    required this.money,
    required this.rarity,
  });

  factory UpgradeCalculations.fromMap(Map<String, Object?> map) => UpgradeCalculations(
        id: map['id'] as int?,
        from: map['from'] as int,
        to: map['to'] as int,
        type: map['type'] as int,
        tier1: map['tier1'] as int,
        tier2: map['tier2'] as int,
        tier3: map['tier3'] as int,
        advanced: map['advanced'] as int,
        money: map['money'] as int,
        rarity: map['rarity'] as int,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'from': from,
        'to': to,
        'type': type,
        'tier1': tier1,
        'tier2': tier2,
        'tier3': tier3,
        'advanced': advanced,
        'money': money,
        'rarity': rarity,
      };

  @override
  String toString() {
    return 'UpgradeCalculations{id: $id, from: $from, to: $to, type: $type, tier1: $tier1, tier2: $tier2, tier3: $tier3, advanced: $advanced, money: $money, rarity: $rarity}';
  }

  // CRUD functions
  static Future<int> insert(UpgradeCalculations upgradeCalculations) async {
    final db = await DBHelper().database;
    return await db.insert(
      'UpgradeCalculations',
      upgradeCalculations.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<UpgradeCalculations?> get(int id) async {
    final db = await DBHelper().database;
    final maps = await db.query(
      'UpgradeCalculations',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return UpgradeCalculations.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(UpgradeCalculations upgradeCalculations) async {
    final db = await DBHelper().database;
    return await db.update(
      'UpgradeCalculations',
      upgradeCalculations.toMap(),
      where: 'id = ?',
      whereArgs: [upgradeCalculations.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'UpgradeCalculations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<UpgradeCalculations>> getAll() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('UpgradeCalculations');
    return List.generate(maps.length, (i) {
      return UpgradeCalculations.fromMap(maps[i]);
    });
  }
}
