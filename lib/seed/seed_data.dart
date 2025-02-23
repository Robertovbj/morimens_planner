import 'package:sqflite/sqflite.dart';

class DatabaseSeeder {
  final Database db;

  DatabaseSeeder(this.db);

  Future<void> seed() async {
    await _seedRealms();
    await _seedAwakerTypes();
    await _seedSkillMaterialFamilies();
    await _seedEdifyMaterialFamilies();
    await _seedSkillMaterials();
    await _seedEdifyMaterials();
    await _seedAdvancedSkillMaterials();
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
      {'id': 1, 'description': 'Crystal'},
      {'id': 2, 'description': 'Lily'},
      {'id': 3, 'description': 'Polymer'},
      {'id': 4, 'description': 'Star'},
    ];

    for (var family in families) {
      await db.insert('SkillMaterialFamily', family);
    }
  }

  Future<void> _seedEdifyMaterialFamilies() async {
    final families = [
      {'id': 1, 'description': 'Tome'},
      {'id': 2, 'description': 'Mind'},
      {'id': 3, 'description': 'Dungeon'},
      {'id': 4, 'description': 'Template'},
    ];

    for (var family in families) {
      await db.insert('EdifyMaterialFamily', family);
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

  Future<void> _seedV2() async {
    // Add seed data for version 2
  }

  Future<void> _seedV3() async {
    // Add seed data for version 3
  }
}
