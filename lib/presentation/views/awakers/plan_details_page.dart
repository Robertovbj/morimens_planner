import 'package:flutter/material.dart';
import '../../../core/data/models/planner.dart';
import '../../../core/data/models/awaker.dart';
import '../../../core/data/models/material_requirements.dart';
import '../../../core/services/material_calculator.dart';
import '../../../core/utils/color_generator.dart';
import '../../widgets/material_requirements_view.dart';
import 'add_plan_dialog.dart';

class PlanDetailsPage extends StatefulWidget {
  final Planner plan;
  final Awaker awaker;

  const PlanDetailsPage({
    super.key,
    required this.plan,
    required this.awaker,
  });

  @override
  State<PlanDetailsPage> createState() => _PlanDetailsPageState();
}

class _PlanDetailsPageState extends State<PlanDetailsPage> {
  late Planner currentPlan;

  @override
  void initState() {
    super.initState();
    currentPlan = widget.plan;
  }

  Future<void> _confirmDelete() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete the plan for ${widget.awaker.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (result == true && mounted) {
      try {
        await Planner.delete(currentPlan.id!);
        if (mounted) {
          Navigator.of(context).pop(true); // Return true to trigger refresh
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting plan: $e')),
          );
        }
      }
    }
  }

  String _formatValue(String label, int from, int to) {
    if (label == 'Edify') {
      return '$from/$from → $to/$to';
    }
    return '$from → $to';
  }

  Widget _buildDetailRow(String label, int from, int to) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(_formatValue(label, from, to)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.awaker.name),
        backgroundColor: ColorGenerator.fromString(widget.awaker.name),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _confirmDelete,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Edify', currentPlan.edifyFrom, currentPlan.edifyTo),
            _buildDetailRow('Basic Attack', currentPlan.basicAttackFrom, currentPlan.basicAttackTo),
            _buildDetailRow('Basic Defense', currentPlan.basicDefenseFrom, currentPlan.basicDefenseTo),
            _buildDetailRow('Rouse', currentPlan.rouseFrom, currentPlan.rouseTo),
            _buildDetailRow('Skill One', currentPlan.skillOneFrom, currentPlan.skillOneTo),
            _buildDetailRow('Skill Two', currentPlan.skillTwoFrom, currentPlan.skillTwoTo),
            _buildDetailRow('Exalt (Ult)', currentPlan.exaltFrom, currentPlan.exaltTo),
            
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            
            const Text(
              'Material Requirements',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            FutureBuilder<MaterialRequirements>(
              future: MaterialCalculator.calculateForPlan(currentPlan, widget.awaker),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                
                final requirements = snapshot.data!;
                return MaterialRequirementsView(
                  requirements: requirements,
                  showTitle: false,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (context) => AddPlanDialog(planToEdit: currentPlan),
          );
          
          if (result == true) {
            final updatedPlan = await Planner.get(currentPlan.id!);
            if (updatedPlan != null) {
              setState(() {
                currentPlan = updatedPlan;
              });
            }
          }
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
