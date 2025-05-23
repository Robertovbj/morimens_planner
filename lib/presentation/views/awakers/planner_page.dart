import 'package:flutter/material.dart';
import '../../../core/data/models/planner.dart';
import '../../../core/data/models/awaker.dart';
import '../../../core/services/planner_service.dart';
import 'add_plan_dialog.dart';
import 'plan_details_page.dart';
import '../../widgets/awaker_card.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  List<Planner> plans = [];
  Map<int, Awaker> awakersMap = {};
  final PlannerService _plannerService = PlannerService();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final (loadedPlans, awakerMap) =
        await _plannerService.loadPlansWithAwakers();

    setState(() {
      plans = loadedPlans;
      awakersMap = awakerMap;
    });
  }

  Future<void> _togglePlanActive(Planner plan) async {
    if (plan.id != null) {
      final awaker = awakersMap[plan.awaker];
      final isActive = await _plannerService.togglePlanActive(plan.id!);

      // User feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isActive
                ? '${awaker?.name} activated'
                : '${awaker?.name} deactivated',
          ),
          duration: const Duration(seconds: 1),
        ),
      );
      // Important: Only updates the visual state of the current list
      // without reordering items
      setState(() {
        // Find the index of the plan in the list
        final index = plans.indexWhere((p) => p.id == plan.id);
        if (index >= 0) {
          // Update only the active state of the plan
          plans[index] = Planner(
            id: plan.id,
            awaker: plan.awaker,
            basicAttackFrom: plan.basicAttackFrom,
            basicAttackTo: plan.basicAttackTo,
            basicDefenseFrom: plan.basicDefenseFrom,
            basicDefenseTo: plan.basicDefenseTo,
            exaltFrom: plan.exaltFrom,
            exaltTo: plan.exaltTo,
            rouseFrom: plan.rouseFrom,
            rouseTo: plan.rouseTo,
            skillOneFrom: plan.skillOneFrom,
            skillOneTo: plan.skillOneTo,
            skillTwoFrom: plan.skillTwoTo,
            skillTwoTo: plan.skillTwoTo,
            edifyFrom: plan.edifyFrom,
            edifyTo: plan.edifyTo,
            active: isActive,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: plans.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Nothing to show here. Try adding some Awakers :)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                final awaker = awakersMap[plan.awaker];

                // Skip if awaker is null
                if (awaker == null) {
                  return const SizedBox.shrink();
                }
                
                return AwakerCard(
                  awaker: awaker,
                  isActive: plan.active,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PlanDetailsPage(plan: plan, awaker: awaker),
                      ),
                    ).then((_) => _loadData());
                  },
                  onLongPress: () => _togglePlanActive(plan),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (context) => const AddPlanDialog(),
          );

          if (result == true) {
            _loadData();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
