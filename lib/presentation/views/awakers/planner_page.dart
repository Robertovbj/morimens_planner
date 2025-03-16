import 'package:flutter/material.dart';
import '../../../core/data/models/planner.dart';
import '../../../core/data/models/awaker.dart';
import '../../../core/services/planner_service.dart';
import 'add_plan_dialog.dart';
import 'plan_details_page.dart';
import '../../../core/utils/color_generator.dart';

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
    final (loadedPlans, awakerMap) = await _plannerService.loadPlansWithAwakers();

    setState(() {
      plans = loadedPlans;
      awakersMap = awakerMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          plans.isEmpty
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

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  PlanDetailsPage(plan: plan, awaker: awaker!),
                        ),
                      ).then((_) => _loadData()); // Reload data when returning
                    },
                    onLongPress: () async {
                      // Toggle the plan's active state when long pressing
                      if (plan.id != null) {
                        final isActive = await _plannerService.togglePlanActive(plan.id!);
                        
                        // User feedback
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isActive 
                                ? '${awaker?.name} activated' 
                                : '${awaker?.name} deactivated'
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                        
                        // Update the list
                        _loadData();
                      }
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: ColorGenerator.fromString(
                                      awaker?.name ?? '',
                                    ),
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(4),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 64,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // Add a darkened overlay for disabled plans
                                if (!plan.active)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.8),
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(4),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.mode_night,
                                        size: 64,
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              awaker?.name ?? 'Unknown',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: plan.active 
                                    ? null 
                                    : Theme.of(context).disabledColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
