import 'package:flutter/material.dart';
import '../../../core/services/planner_backup_service.dart';
import '../../../core/data/models/planner.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // Export planner data to JSON
  Future<void> _exportData(BuildContext context) async {
    final backupService = PlannerBackupService();
    final planners = await Planner.getAll();
    await backupService.exportPlannersToJson(planners, context);
  }

  // Import planner data from JSON
  Future<void> _importData(BuildContext context) async {
    final backupService = PlannerBackupService();
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
    await backupService.applyImport(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data Management',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _importData(context),
                      icon: const Icon(Icons.download),
                      label: const Text('Import Data'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _exportData(context),
                      icon: const Icon(Icons.upload),
                      label: const Text('Export Data'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
