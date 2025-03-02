import 'package:sqflite/sqflite.dart';

class DatabaseSeeder {
  final Database db;

  DatabaseSeeder(this.db);

  Future<void> seed() async {
    await _seedRealms();
    await _seedAwakerTypes();
    await _seedSkillMaterialFamilies();
    await _seedEdifyMaterialFamilies();
    await _seedUniversalMaterialFamilies();
    await _seedSkillMaterials();
    await _seedEdifyMaterials();
    await _seedUniversalMaterials();
    await _seedAdvancedSkillMaterials();
    await _seedRarities();
    await _seedUpgradeTypes();
    await _seedUpgradeCalculations();
    await _seedAwakers();
  }

  Future<void> seedUpgrade(int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _seedV2();
    }
    if (oldVersion < 3) {
      await _seedV3();
    }
  }

  Future<void> _seedRealms() async {
    final realms = [
      {'id': 1, 'description': 'Chaos', 'icon': 'chaos_icon'},
      {'id': 2, 'description': 'Aequor', 'icon': 'aequor_icon'},
      {'id': 3, 'description': 'Caro', 'icon': 'caro_icon'},
      {'id': 4, 'description': 'Ultra', 'icon': 'ultra_icon'},
    ];

    for (var realm in realms) {
      await db.insert('Realm', realm);
    }
  }

  Future<void> _seedAwakerTypes() async {
    final types = [
      {'id': 1, 'description': 'Damage'},
      {'id': 2, 'description': 'Defense'},
      {'id': 3, 'description': 'Assist'},
    ];

    for (var type in types) {
      await db.insert('AwakerType', type);
    }
  }

  Future<void> _seedSkillMaterialFamilies() async {
    final families = [
      {'id': 1, 'description': 'Chaos Cluster'},
      {'id': 2, 'description': 'Ruins of Ponape'},
      {'id': 3, 'description': 'Worm\'s Lair'},
      {'id': 4, 'description': 'Schwarzschild Throat'},
    ];

    for (var family in families) {
      await db.insert('SkillMaterialFamily', family);
    }
  }

  Future<void> _seedEdifyMaterialFamilies() async {
    final families = [
      {'id': 1, 'description': 'Murky Afterimage'},
      {'id': 2, 'description': 'Abyssal Afterimage'},
      {'id': 3, 'description': 'Organic Afterimage'},
      {'id': 4, 'description': 'Dimensional Afterimage'},
    ];

    for (var family in families) {
      await db.insert('EdifyMaterialFamily', family);
    }
  }

  Future<void> _seedUniversalMaterialFamilies() async {
    final families = [
      {'id': 1, 'description': 'Philosopher\'s Stone'},
    ];

    for (var family in families) {
      await db.insert('UniversalMaterialFamily', family);
    }
  }

  Future<void> _seedSkillMaterials() async {
    final materials = [
      {'id': 1, 'description': 'Chaos Crystal', 'realm': 1, 'tier': 3, 'icon': 'chaos_crystal.png', 'family': 1},
      {'id': 2, 'description': 'Gleaming Crystal Butterfly', 'realm': 1, 'tier': 2, 'icon': 'gleaming_crystal_butterfly.png', 'family': 1},
      {'id': 3, 'description': 'Faded Crystal Butterfly', 'realm': 1, 'tier': 1, 'icon': 'faded_cystal_butterfly.png', 'family': 1},
      {'id': 4, 'description': 'Ewing Lily', 'realm': 2, 'tier': 3, 'icon': 'ewing_lily.png', 'family': 2},
      {'id': 5, 'description': 'Tall Sea Lily', 'realm': 2, 'tier': 2, 'icon': 'tall_sea_lily.png', 'family': 2},
      {'id': 6, 'description': 'Short-Stemmed Sea Lily', 'realm': 2, 'tier': 1, 'icon': 'short_stemmed_sea_lily.png', 'family': 2},
      {'id': 7, 'description': 'Spore Polymer', 'realm': 3, 'tier': 3, 'icon': 'spore_polymer.png', 'family': 3},
      {'id': 8, 'description': 'Primal Chrysalis', 'realm': 3, 'tier': 2, 'icon': 'primal_chrysalis.png', 'family': 3},
      {'id': 9, 'description': 'Dried Insect Pupa', 'realm': 3, 'tier': 1, 'icon': 'dried_insect_pupa.png', 'family': 3},
      {'id': 10, 'description': 'Yucatan Star', 'realm': 4, 'tier': 3, 'icon': 'yucatan_star.png', 'family': 4},
      {'id': 11, 'description': 'Metor Shard', 'realm': 4, 'tier': 2, 'icon': 'metor_shard.png', 'family': 4},
      {'id': 12, 'description': 'Damaged Ore Crystal', 'realm': 4, 'tier': 1, 'icon': 'damaged_ore_crystal.png', 'family': 4}
    ];

    for (var material in materials) {
      await db.insert('SkillMaterials', material);
    }
  }

  Future<void> _seedEdifyMaterials() async {
    final materials = [
      {'id': 1, 'description': 'Pure White Secret Tome', 'realm': 1, 'tier': 3, 'icon': 'pure_white_secret_tome.png', 'family': 1},
      {'id': 2, 'description': 'Pure White Document', 'realm': 1, 'tier': 2, 'icon': 'pure_white_document.png', 'family': 1},
      {'id': 3, 'description': 'Pure White Fragment', 'realm': 1, 'tier': 1, 'icon': 'pure_white_fragment.png', 'family': 1},
      {'id': 4, 'description': 'Tempered Mind', 'realm': 2, 'tier': 3, 'icon': 'tempered_mind.png', 'family': 2},
      {'id': 5, 'description': 'Tempered Sanity', 'realm': 2, 'tier': 2, 'icon': 'tempered_sanity.png', 'family': 2},
      {'id': 6, 'description': 'Tempered Instinct', 'realm': 2, 'tier': 1, 'icon': 'tempered_instinct.png', 'family': 2},
      {'id': 7, 'description': 'Mind Dungeon', 'realm': 3, 'tier': 3, 'icon': 'mind_dungeon.png', 'family': 3},
      {'id': 8, 'description': 'Emotional Dungeon', 'realm': 3, 'tier': 2, 'icon': 'emotional_dungeon.png', 'family': 3},
      {'id': 9, 'description': 'Memory Replica', 'realm': 3, 'tier': 1, 'icon': 'memory_replica.png', 'family': 3},
      {'id': 10, 'description': 'Arcane Knowledge Template', 'realm': 4, 'tier': 3, 'icon': 'arcane_knowledge_template.png', 'family': 4},
      {'id': 11, 'description': 'Mental Template', 'realm': 4, 'tier': 2, 'icon': 'mental_template.png', 'family': 4},
      {'id': 12, 'description': 'Cognitive Template', 'realm': 4, 'tier': 1, 'icon': 'cognitive_template.png', 'family': 4}
    ];

    for (var material in materials) {
      await db.insert('EdifyMaterials', material);
    }
  }

  Future<void> _seedUniversalMaterials() async {
    final materials = [
      {'id': 1, 'description': 'Shard of Sage Stone', 'icon': 'shard_of_sage_stone.png', 'family': 1, 'shard': 1},
      {'id': 2, 'description': 'Philosopher\'s Stone', 'icon': 'philosophers_stone.png', 'family': 1, 'shard': 0},
    ];

    for (var material in materials) {
      await db.insert('UniversalMaterials', material);
    }
  }

  Future<void> _seedAdvancedSkillMaterials() async {
    final materials = [
      {'id': 1, 'description': 'Lucky Candy', 'icon': 'lucky_candy.png'},
      {'id': 2, 'description': 'Wax Figurine Clay', 'icon': 'wax_figurine_clay.png'},
      {'id': 3, 'description': 'Midnight Shackles', 'icon': 'midnight_shackles.png'},
      {'id': 4, 'description': 'Dimensional Crystal', 'icon': 'dimensional_crystal.png'},
      {'id': 5, 'description': 'Devout Holy Heart', 'icon': 'devout_holy_heart.png'},
      {'id': 6, 'description': 'Crown of the Holy Fetus', 'icon': 'crown_of_the_holy_fetus.png'},
      {'id': 7, 'description': 'Mother Tree Remains', 'icon': 'mother_tree_remains.png'},
      {'id': 8, 'description': 'Dreamcatcher', 'icon': 'dreamcatcher.png'}
    ];

    for (var material in materials) {
      await db.insert('AdvancedSkillMaterials', material);
    }
  }

  Future<void> _seedRarities() async {
    final rarities = [
      {'id': 1, 'description': 'R'},
      {'id': 2, 'description': 'SR'},
      {'id': 3, 'description': 'SSR'},
    ];

    for (var rarity in rarities) {
      await db.insert('Rarity', rarity);
    }
  }

  Future<void> _seedUpgradeTypes() async {
    final types = [
      {'id': 1, 'description': 'Skill'},
      {'id': 2, 'description': 'Exalt'},
      {'id': 3, 'description': 'Edify'},
    ];

    for (var type in types) {
      await db.insert('UpgradeType', type);
    }
  }

  Future<void> _seedUpgradeCalculations() async {
    final calculations = [
      {'fromLevel': 1, 'toLevel': 2, 'type': 1, 'tier1': 9, 'tier2': 0, 'tier3': 0, 'advanced': 0, 'universal': 0, 'money': 3150, 'rarity': 3},
      {'fromLevel': 2, 'toLevel': 3, 'type': 1, 'tier1': 0, 'tier2': 9, 'tier3': 0, 'advanced': 0, 'universal': 0, 'money': 12150, 'rarity': 3},
      {'fromLevel': 3, 'toLevel': 4, 'type': 1, 'tier1': 0, 'tier2': 15, 'tier3': 0, 'advanced': 1, 'universal': 0, 'money': 24750, 'rarity': 3},
      {'fromLevel': 4, 'toLevel': 5, 'type': 1, 'tier1': 0, 'tier2': 0, 'tier3': 9, 'advanced': 2, 'universal': 0, 'money': 44550, 'rarity': 3},
      {'fromLevel': 10, 'toLevel': 20, 'type': 3, 'tier1': 9, 'tier2': 0, 'tier3': 0, 'advanced': 0, 'universal': 0, 'money': 0, 'rarity': 3},
      {'fromLevel': 20, 'toLevel': 30, 'type': 3, 'tier1': 0, 'tier2': 9, 'tier3': 0, 'advanced': 0, 'universal': 0, 'money': 8100, 'rarity': 3},
      {'fromLevel': 30, 'toLevel': 40, 'type': 3, 'tier1': 0, 'tier2': 18, 'tier3': 0, 'advanced': 0, 'universal': 0, 'money': 21600, 'rarity': 3},
      {'fromLevel': 40, 'toLevel': 50, 'type': 3, 'tier1': 0, 'tier2': 0, 'tier3': 15, 'advanced': 0, 'universal': 0, 'money': 67500, 'rarity': 3},
      {'fromLevel': 50, 'toLevel': 60, 'type': 3, 'tier1': 0, 'tier2': 0, 'tier3': 24, 'advanced': 0, 'universal': 0, 'money': 129600, 'rarity': 3},
      {'fromLevel': 1, 'toLevel': 2, 'type': 2, 'tier1': 18, 'tier2': 0, 'tier3': 0, 'advanced': 1, 'universal': 0, 'money': 6300, 'rarity': 3},
      {'fromLevel': 2, 'toLevel': 3, 'type': 2, 'tier1': 0, 'tier2': 18, 'tier3': 0, 'advanced': 2, 'universal': 0, 'money': 24300, 'rarity': 3},
      {'fromLevel': 3, 'toLevel': 4, 'type': 2, 'tier1': 0, 'tier2': 30, 'tier3': 0, 'advanced': 3, 'universal': 1, 'money': 49500, 'rarity': 3},
      {'fromLevel': 4, 'toLevel': 5, 'type': 2, 'tier1': 0, 'tier2': 0, 'tier3': 18, 'advanced': 4, 'universal': 1, 'money': 89100, 'rarity': 3},
    ];

    for (var calculation in calculations) {
      await db.insert('UpgradeCalculations', calculation);
    }
  }

  Future<void> _seedAwakers() async {
    final awakers = [
      {'name': 'Sorel', 'realm': 3, 'type': 1, 'rarity': 3, 'skillMaterialFamily': 3, 'edifyMaterialFamily': 3, 'advancedSkillMaterial': 5, 'universalMaterialFamily': 1},
      {'name': 'Leigh', 'realm': 3, 'type': 3, 'rarity': 3, 'skillMaterialFamily': 3, 'edifyMaterialFamily': 3, 'advancedSkillMaterial': 1, 'universalMaterialFamily': 1},
      {'name': 'Faint', 'realm': 3, 'type': 2, 'rarity': 3, 'skillMaterialFamily': 3, 'edifyMaterialFamily': 3, 'advancedSkillMaterial': 2, 'universalMaterialFamily': 1},
      {'name': 'Helot', 'realm': 3, 'type': 1, 'rarity': 3, 'skillMaterialFamily': 3, 'edifyMaterialFamily': 3, 'advancedSkillMaterial': 1, 'universalMaterialFamily': 1},
      {'name': 'Agrippa', 'realm': 3, 'type': 2, 'rarity': 3, 'skillMaterialFamily': 3, 'edifyMaterialFamily': 3, 'advancedSkillMaterial': 3, 'universalMaterialFamily': 1},
      {'name': 'Aigis', 'realm': 3, 'type': 3, 'rarity': 3, 'skillMaterialFamily': 3, 'edifyMaterialFamily': 3, 'advancedSkillMaterial': 2, 'universalMaterialFamily': 1},
      {'name': 'Lily', 'realm': 1, 'type': 2, 'rarity': 3, 'skillMaterialFamily': 1, 'edifyMaterialFamily': 1, 'advancedSkillMaterial': 5, 'universalMaterialFamily': 1},
      {'name': 'Karen', 'realm': 1, 'type': 3, 'rarity': 3, 'skillMaterialFamily': 1, 'edifyMaterialFamily': 1, 'advancedSkillMaterial': 3, 'universalMaterialFamily': 1},
      {'name': 'Celeste', 'realm': 2, 'type': 3, 'rarity': 3, 'skillMaterialFamily': 2, 'edifyMaterialFamily': 2, 'advancedSkillMaterial': 1, 'universalMaterialFamily': 1},
      {'name': 'Aurita', 'realm': 2, 'type': 1, 'rarity': 3, 'skillMaterialFamily': 2, 'edifyMaterialFamily': 2, 'advancedSkillMaterial': 3, 'universalMaterialFamily': 1},
      {'name': 'Sanga', 'realm': 2, 'type': 2, 'rarity': 3, 'skillMaterialFamily': 2, 'edifyMaterialFamily': 2, 'advancedSkillMaterial': 4, 'universalMaterialFamily': 1},
      {'name': 'Faros', 'realm': 2, 'type': 3, 'rarity': 3, 'skillMaterialFamily': 2, 'edifyMaterialFamily': 2, 'advancedSkillMaterial': 1, 'universalMaterialFamily': 1},
      {'name': 'Tulu', 'realm': 2, 'type': 1, 'rarity': 3, 'skillMaterialFamily': 2, 'edifyMaterialFamily': 2, 'advancedSkillMaterial': 5, 'universalMaterialFamily': 1},
      {'name': 'Liz', 'realm': 4, 'type': 1, 'rarity': 3, 'skillMaterialFamily': 4, 'edifyMaterialFamily': 4, 'advancedSkillMaterial': 3, 'universalMaterialFamily': 1},
      {'name': 'Casiah', 'realm': 4, 'type': 3, 'rarity': 3, 'skillMaterialFamily': 4, 'edifyMaterialFamily': 4, 'advancedSkillMaterial': 4, 'universalMaterialFamily': 1},
      {'name': 'Erica', 'realm': 4, 'type': 2, 'rarity': 3, 'skillMaterialFamily': 4, 'edifyMaterialFamily': 4, 'advancedSkillMaterial': 3, 'universalMaterialFamily': 1},
      {'name': 'Daffodil', 'realm': 4, 'type': 1, 'rarity': 3, 'skillMaterialFamily': 4, 'edifyMaterialFamily': 4, 'advancedSkillMaterial': 5, 'universalMaterialFamily': 1},
    ];

    for (var awaker in awakers) {
      await db.insert('Awakers', awaker);
    }
  }

  Future<void> _seedV2() async {
  }

  Future<void> _seedV3() async {
    // Add seed data for version 3
  }
}
