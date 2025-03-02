import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';
import '../models/material_requirements.dart';
import '../models/planner.dart';
import '../models/awaker.dart';
import '../models/universal_material.dart'; // Importar o modelo do material universal

class MaterialCalculator {
  static Future<MaterialRequirements> calculate() async {
    final db = await DBHelper().database;
    final plans = await Planner.getAll();
    Map<int, Awaker> awakersMap = {};
    
    // Load all awakers used in plans
    for (var plan in plans) {
      final awaker = await Awaker.get(plan.awaker);
      if (awaker != null) {
        awakersMap[awaker.id!] = awaker;
      }
    }

    // Group plans by material family
    Map<int, List<Map<String, dynamic>>> skillFamilyRanges = {};
    Map<int, List<Map<String, dynamic>>> edifyFamilyRanges = {};
    List<Map<String, dynamic>> exaltRanges = [];

    // Track advanced materials by ID
    Map<int, int> advancedMaterialsCount = {};

    // Grupo para rastrear famílias de materiais universais
    Set<int> universalFamilies = {};
    int totalUniversalMaterials = 0;

    for (var plan in plans) {
      final awaker = awakersMap[plan.awaker];
      if (awaker == null) continue;

      // Rastrear as famílias de materiais universais usadas
      if (awaker != null) {
        universalFamilies.add(awaker.universalMaterialFamily);
      }

      // Group skill upgrades by family
      final skillFamily = awaker.skillMaterialFamily;
      skillFamilyRanges.putIfAbsent(skillFamily, () => []);
      
      // Basic Attack
      skillFamilyRanges[skillFamily]!.add({
        'from': plan.basicAttackFrom,
        'to': plan.basicAttackTo,
        'rarity': awaker.rarity,
      });
      
      // Basic Defense
      skillFamilyRanges[skillFamily]!.add({
        'from': plan.basicDefenseFrom,
        'to': plan.basicDefenseTo,
        'rarity': awaker.rarity,
      });
      
      // Skills
      skillFamilyRanges[skillFamily]!.add({
        'from': plan.skillOneFrom,
        'to': plan.skillOneTo,
        'rarity': awaker.rarity,
      });
      skillFamilyRanges[skillFamily]!.add({
        'from': plan.skillTwoFrom,
        'to': plan.skillTwoTo,
        'rarity': awaker.rarity,
      });
      
      // Group edify upgrades
      final edifyFamily = awaker.edifyMaterialFamily;
      edifyFamilyRanges.putIfAbsent(edifyFamily, () => []);
      edifyFamilyRanges[edifyFamily]!.add({
        'from': plan.edifyFrom,
        'to': plan.edifyTo,
        'rarity': awaker.rarity,
      });
      
      // Exalt uses both advanced materials and skill materials
      exaltRanges.add({
        'from': plan.exaltFrom,
        'to': plan.exaltTo,
        'rarity': awaker.rarity,
        'skillFamily': awaker.skillMaterialFamily,
        'advancedMaterial': awaker.advancedSkillMaterial,
      });
    }

    // Calculate requirements for each family
    List<MaterialRequirement> skillRequirements = [];
    List<MaterialRequirement> edifyRequirements = [];
    int totalMoney = 0;

    // Calculate skill materials
    for (var entry in skillFamilyRanges.entries) {
      final result = await _calculateFamilyRequirements(
        db, entry.value, 1, // type 1 for skills
      );
      
      final familyName = await _getFamilyName(db, 'SkillMaterialFamily', entry.key);
      
      skillRequirements.add(MaterialRequirement(
        familyId: entry.key,
        familyName: familyName,
        tier1: result['tier1'] ?? 0,
        tier2: result['tier2'] ?? 0,
        tier3: result['tier3'] ?? 0,
      ));
      
      totalMoney += result['money'] ?? 0;
    }

    // Calculate edify materials
    for (var entry in edifyFamilyRanges.entries) {
      final result = await _calculateFamilyRequirements(
        db, entry.value, 3, // type 3 for edify
      );
      
      final familyName = await _getFamilyName(db, 'EdifyMaterialFamily', entry.key);
      
      edifyRequirements.add(MaterialRequirement(
        familyId: entry.key,
        familyName: familyName,
        tier1: result['tier1'] ?? 0,
        tier2: result['tier2'] ?? 0,
        tier3: result['tier3'] ?? 0,
      ));
      
      totalMoney += result['money'] ?? 0;
    }

    // Calculate exalt materials (both skill and advanced materials)
    for (var range in exaltRanges) {
      // Calculate advanced materials
      final exaltResult = await _calculateFamilyRequirements(
        db, [range], 2, // type 2 for exalt
      );
      totalMoney += exaltResult['money'] ?? 0;
      totalUniversalMaterials += exaltResult['universal'] ?? 0;

      // Track which advanced material is needed
      final advancedMaterialId = range['advancedMaterial'] as int;
      advancedMaterialsCount[advancedMaterialId] = 
          (advancedMaterialsCount[advancedMaterialId] ?? 0) + 
          (exaltResult['advanced'] ?? 0);

      // Add skill materials to the corresponding family
      final skillFamily = range['skillFamily'] as int;
      final skillResult = await _calculateFamilyRequirements(
        db, [range], 2, // type 2 for exalt
      );
      
      // Find or create the family requirement
      var familyReq = skillRequirements.firstWhere(
        (req) => req.familyId == skillFamily,
        orElse: () {
          final newReq = MaterialRequirement(
            familyId: skillFamily,
            familyName: '', // Will be set later
            tier1: 0,
            tier2: 0,
            tier3: 0,
          );
          skillRequirements.add(newReq);
          return newReq;
        },
      );

      // Update the requirement with exalt materials
      final index = skillRequirements.indexOf(familyReq);
      skillRequirements[index] = MaterialRequirement(
        familyId: familyReq.familyId,
        familyName: familyReq.familyName,
        tier1: familyReq.tier1 + (skillResult['tier1'] ?? 0),
        tier2: familyReq.tier2 + (skillResult['tier2'] ?? 0),
        tier3: familyReq.tier3 + (skillResult['tier3'] ?? 0),
      );
    }

    // Convert advanced materials count to requirements list
    List<AdvancedMaterialRequirement> advancedRequirements = [];
    for (var entry in advancedMaterialsCount.entries) {
      final materialName = await _getAdvancedMaterialName(db, entry.key);
      advancedRequirements.add(AdvancedMaterialRequirement(
        materialId: entry.key,
        materialName: materialName,
        quantity: entry.value,
      ));
    }

    // Update family names after all calculations
    for (var i = 0; i < skillRequirements.length; i++) {
      final req = skillRequirements[i];
      final familyName = await _getFamilyName(db, 'SkillMaterialFamily', req.familyId);
      skillRequirements[i] = MaterialRequirement(
        familyId: req.familyId,
        familyName: familyName,
        tier1: req.tier1,
        tier2: req.tier2,
        tier3: req.tier3,
      );
    }

    // Obter o nome do material universal completo (não o fragmento)
    String universalMaterialName = "Universal Material"; // Nome padrão
    if (universalFamilies.isNotEmpty) {
      // Pegamos o primeiro, pois normalmente todos os awakeners usarão o mesmo tipo de material universal
      final familyId = universalFamilies.first;
      final universalMaterial = await UniversalMaterial.getCompleteMaterialFromFamily(familyId);
      if (universalMaterial != null) {
        universalMaterialName = universalMaterial.description;
      }
    }

    return MaterialRequirements(
      skillFamilies: skillRequirements,
      edifyFamilies: edifyRequirements,
      advancedMaterials: advancedRequirements,
      universalMaterials: totalUniversalMaterials, // Novo campo
      universalMaterialName: universalMaterialName, // Novo campo
      totalMoney: totalMoney,
    );
  }

  static Future<Map<String, int>> _calculateFamilyRequirements(
    Database db,
    List<Map<String, dynamic>> ranges,
    int type,
  ) async {
    int totalTier1 = 0, totalTier2 = 0, totalTier3 = 0, 
        totalAdvanced = 0, totalUniversal = 0, totalMoney = 0;

    for (var range in ranges) {
      final results = await db.rawQuery('''
        SELECT 
          SUM(tier1) as total_tier1,
          SUM(tier2) as total_tier2,
          SUM(tier3) as total_tier3,
          SUM(advanced) as total_advanced,
          SUM(universal) as total_universal,
          SUM(money) as total_money
        FROM UpgradeCalculations
        WHERE rarity = ?
          AND type = ?
          AND fromLevel >= ?
          AND toLevel <= ?
      ''', [range['rarity'], type, range['from'], range['to']]);

      if (results.isNotEmpty) {
        totalTier1 += results.first['total_tier1'] as int? ?? 0;
        totalTier2 += results.first['total_tier2'] as int? ?? 0;
        totalTier3 += results.first['total_tier3'] as int? ?? 0;
        totalAdvanced += results.first['total_advanced'] as int? ?? 0;
        totalUniversal += results.first['total_universal'] as int? ?? 0;
        totalMoney += results.first['total_money'] as int? ?? 0;
      }
    }

    return {
      'tier1': totalTier1,
      'tier2': totalTier2,
      'tier3': totalTier3,
      'advanced': totalAdvanced,
      'universal': totalUniversal,
      'money': totalMoney,
    };
  }

  static Future<String> _getFamilyName(Database db, String table, int id) async {
    final result = await db.query(
      table,
      columns: ['description'],
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.first['description'] as String;
  }

  static Future<String> _getAdvancedMaterialName(Database db, int id) async {
    final result = await db.query(
      'AdvancedSkillMaterials',
      columns: ['description'],
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.first['description'] as String;
  }
}
