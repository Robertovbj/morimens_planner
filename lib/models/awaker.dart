import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class Awaker {
  final int? id;
  final String name;
  final int realm;
  final int type;
  final int constitution;
  final int attack;
  final int defense;
  final double criticalRate;
  final double criticalDamage;
  final int realmMastery;
  final double strongAttack;
  final int aliemusRecharge;
  final int silverKeyRecharge;
  final double blackSigilDropRate;
  final double resistance;
  final int level;

  Awaker({
    this.id,
    required this.name,
    required this.realm,
    required this.type,
    required this.constitution,
    required this.attack,
    required this.defense,
    required this.criticalRate,
    required this.criticalDamage,
    required this.realmMastery,
    required this.strongAttack,
    required this.aliemusRecharge,
    required this.silverKeyRecharge,
    required this.blackSigilDropRate,
    required this.resistance,
    required this.level,
  });

  factory Awaker.fromMap(Map<String, Object?> map) => Awaker(
        id: map['id'] as int?,
        name: map['name'] as String,
        realm: map['realm'] as int,
        type: map['type'] as int,
        constitution: map['constitution'] as int,
        attack: map['attack'] as int,
        defense: map['defense'] as int,
        criticalRate: map['critical_rate'] as double,
        criticalDamage: map['critical_damage'] as double,
        realmMastery: map['realm_mastery'] as int,
        strongAttack: map['strong_attack'] as double,
        aliemusRecharge: map['aliemus_recharge'] as int,
        silverKeyRecharge: map['silver_key_recharge'] as int,
        blackSigilDropRate: map['black_sigil_drop_rate'] as double,
        resistance: map['resistance'] as double,
        level: map['level'] as int,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'name': name,
        'realm': realm,
        'type': type,
        'constitution': constitution,
        'attack': attack,
        'defense': defense,
        'critical_rate': criticalRate,
        'critical_damage': criticalDamage,
        'realm_mastery': realmMastery,
        'strong_attack': strongAttack,
        'aliemus_recharge': aliemusRecharge,
        'silver_key_recharge': silverKeyRecharge,
        'black_sigil_drop_rate': blackSigilDropRate,
        'resistance': resistance,
        'level': level,
      };

  @override
  String toString() {
    return 'Awaker{id: $id, name: $name, realm: $realm, type: $type, constitution: $constitution, attack: $attack, defense: $defense, criticalRate: $criticalRate, criticalDamage: $criticalDamage, realmMastery: $realmMastery, strongAttack: $strongAttack, aliemusRecharge: $aliemusRecharge, silverKeyRecharge: $silverKeyRecharge, blackSigilDropRate: $blackSigilDropRate, resistance: $resistance, level: $level}';
  }

  // CRUD functions
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
