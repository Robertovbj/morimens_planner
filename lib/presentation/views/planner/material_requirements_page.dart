import 'package:flutter/material.dart';
import '../../../core/data/models/material_requirements.dart';
import '../../../core/services/material_calculator.dart';
import '../../widgets/material_card.dart';

class MaterialRequirementsPage extends StatelessWidget {
  const MaterialRequirementsPage({super.key});

  Widget _buildFamilyCard(MaterialRequirement family) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              family.familyName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  if (family.tier3 > 0)
                    TierMaterialCard(title: 'Tier 3', quantity: family.tier3, tier: 3),
                  if (family.tier2 > 0)
                    TierMaterialCard(title: 'Tier 2', quantity: family.tier2, tier: 2),
                  if (family.tier1 > 0)
                    TierMaterialCard(title: 'Tier 1', quantity: family.tier1, tier: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFamilySection(String title, List<MaterialRequirement> families) {
    // Filter out families where all tiers are 0
    final nonEmptyFamilies = families.where((family) =>
        family.tier1 > 0 || family.tier2 > 0 || family.tier3 > 0).toList();

    // Don't show section if there are no families with materials
    if (nonEmptyFamilies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...nonEmptyFamilies.map(_buildFamilyCard).toList(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildAdvancedMaterialsCard(List<AdvancedMaterialRequirement> materials) {
    // Filter out materials with 0 quantity
    final nonEmptyMaterials = materials.where((m) => m.quantity > 0).toList();

    // Don't show card if there are no materials
    if (nonEmptyMaterials.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Advanced Materials',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: nonEmptyMaterials.length,
                itemBuilder: (context, index) {
                  final material = nonEmptyMaterials[index];
                  return TierMaterialCard(
                    title: material.materialName,
                    quantity: material.quantity,
                    tier: 4,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUniversalMaterialsCard(int quantity, String materialName) {
    if (quantity <= 0) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Universal Materials',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 140,
              child: TierMaterialCard(
                title: materialName,
                quantity: quantity,
                tier: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Requirements'),
      ),
      body: FutureBuilder<MaterialRequirements>(
        future: MaterialCalculator.calculate(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final requirements = snapshot.data!;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFamilySection('Edify Materials', requirements.edifyFamilies),
                _buildFamilySection('Skill Materials', requirements.skillFamilies),
                if (requirements.advancedMaterials.any((m) => m.quantity > 0)) ...[
                  _buildAdvancedMaterialsCard(requirements.advancedMaterials),
                  const SizedBox(height: 16),
                ],
                if (requirements.universalMaterials > 0) ...[
                  _buildUniversalMaterialsCard(
                    requirements.universalMaterials, 
                    requirements.universalMaterialName // Passa o nome específico
                  ),
                  const SizedBox(height: 16),
                ],
                if (requirements.totalMoney > 0)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.monetization_on, color: Colors.amber),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Money Required',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${requirements.totalMoney}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
