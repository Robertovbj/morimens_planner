class Awaker {
  final int id;
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
    required this.id,
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
        id: map['id'] as int,
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
}
