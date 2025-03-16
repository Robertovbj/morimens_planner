import 'package:flutter/material.dart';
import '../../../core/data/models/material_requirements.dart';
import '../../../core/services/material_calculator.dart';
import '../../widgets/material_requirements_view.dart';

class MaterialRequirementsPage extends StatelessWidget {
  
  final bool onlyActive;
  
  const MaterialRequirementsPage({
    super.key, 
    this.onlyActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MaterialRequirements>(
      // Explicitly pass the onlyActive parameter
      future: MaterialCalculator.calculate(onlyActive: onlyActive),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final requirements = snapshot.data!;
        
        // Check if there's nothing to show
        if (MaterialRequirementsView(requirements: requirements).hasNoRequirements()) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  const SizedBox(height: 16),
                  Text(
                    onlyActive 
                        ? 'No active awakers to show. Try activating some plans!'
                        : 'Nothing to show here. Try adding some Awakers :)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: MaterialRequirementsView(requirements: requirements),
        );
      },
    );
  }
}
