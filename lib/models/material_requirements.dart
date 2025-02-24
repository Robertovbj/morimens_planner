class MaterialRequirement {
  final int familyId;
  final String familyName;
  final int tier1;
  final int tier2;
  final int tier3;

  MaterialRequirement({
    required this.familyId,
    required this.familyName,
    required this.tier1,
    required this.tier2,
    required this.tier3,
  });
}

class AdvancedMaterialRequirement {
  final int materialId;
  final String materialName;
  final int quantity;

  AdvancedMaterialRequirement({
    required this.materialId,
    required this.materialName,
    required this.quantity,
  });
}

class MaterialRequirements {
  final List<MaterialRequirement> skillFamilies;
  final List<MaterialRequirement> edifyFamilies;
  final List<AdvancedMaterialRequirement> advancedMaterials;
  final int totalMoney;

  MaterialRequirements({
    required this.skillFamilies,
    required this.edifyFamilies,
    required this.advancedMaterials,
    required this.totalMoney,
  });
}
