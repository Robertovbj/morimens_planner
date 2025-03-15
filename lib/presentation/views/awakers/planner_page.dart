import 'package:flutter/material.dart';
import '../../../core/data/models/planner.dart';
import '../../../core/data/models/awaker.dart';
import '../../../core/services/planner_backup_service.dart';
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
  final PlannerBackupService _backupService = PlannerBackupService();

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

  // Export planner data to JSON
  Future<void> _exportData() async {
    await _backupService.exportPlannersToJson(plans, context);
  }

  // Import planner data from JSON
  Future<void> _importData() async {
    // Confirmation before importing
    final bool? confirmImport = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import Data'),
        content: const Text(
            'Importing will replace all current planner data. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Import'),
          ),
        ],
      ),
    );

    if (confirmImport != true) return;

    // Apply import using the service
    final success = await _backupService.applyImport(context);
    
    // Reload data if import was successful
    if (success) {
      await _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awakers'),
        actions: [
          // Export icon
          IconButton(
            icon: const Icon(Icons.upload),
            tooltip: 'Export data',
            onPressed: _exportData,
          ),
          // Import icon
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Import data',
            onPressed: _importData,
          ),
        ],
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
              ).then((_) => _loadData()); // Reload data when returning
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
