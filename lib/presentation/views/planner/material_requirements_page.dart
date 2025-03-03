import 'package:flutter/material.dart';
import '../../../core/data/models/material_requirements.dart';
import '../../../core/services/material_calculator.dart';

class MaterialRequirementsPage extends StatelessWidget {
  const MaterialRequirementsPage({super.key});

  Color _getTierColor(int tier) {
    switch (tier) {
      case 3:
        return Colors.purple;
      case 2:
        return Colors.blue;
      case 1:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget _buildMaterialCard(String title, int quantity, Color color) {
    return Card(
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.storage,
                color: color,
                size: 32,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'x$quantity',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                    _buildMaterialCard('Tier 3', family.tier3, _getTierColor(3)),
                  if (family.tier2 > 0)
                    _buildMaterialCard('Tier 2', family.tier2, _getTierColor(2)),
                  if (family.tier1 > 0)
                    _buildMaterialCard('Tier 1', family.tier1, _getTierColor(1)),
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
                  return _buildMaterialCard(
                    material.materialName,
                    material.quantity,
                    Colors.orange,
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
              child: _buildMaterialCard(
                materialName, // Usa o nome específico do material
                quantity,
                Colors.orange,
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
