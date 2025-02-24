import 'package:flutter/material.dart';
import '../models/planner.dart';
import '../models/awaker.dart';
import 'add_plan_dialog.dart';
import 'plan_details_page.dart';
import '../utils/color_generator.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  List<Planner> plans = [];
  Map<int, Awaker> awakersMap = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final allPlans = await Planner.getAll();
    final allAwakers = await Awaker.getAll();
    final awakerMap = {for (var awaker in allAwakers) awaker.id!: awaker};
    
    // Sort plans based on awaker names
    allPlans.sort((a, b) {
      final awakerA = awakerMap[a.awaker]?.name ?? '';
      final awakerB = awakerMap[b.awaker]?.name ?? '';
      return awakerA.compareTo(awakerB);
    });
    
    setState(() {
      plans = allPlans;
      awakersMap = awakerMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planner'),
      ),
      body: GridView.builder(
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
                  builder: (context) => PlanDetailsPage(
                    plan: plan,
                    awaker: awaker!,
                  ),
                ),
              ).then((_) => _loadData()); // Recarrega os dados ao retornar
            },
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorGenerator.fromString(awaker?.name ?? ''),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      awaker?.name ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
