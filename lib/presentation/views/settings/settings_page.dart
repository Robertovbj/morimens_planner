import 'package:flutter/material.dart';
import '../../../core/services/planner_backup_service.dart';
import '../../../core/data/models/planner.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Export planner data to JSON
  Future<void> _exportData() async {
    final backupService = PlannerBackupService();
    final planners = await Planner.getAll();
    final result = await backupService.exportPlannersToJson(planners);
    
    if (result != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  // Import planner data from JSON
  Future<void> _importData() async {
    if (!mounted) return;
    
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

    if (confirmImport != true || !mounted) return;

    // Apply import using the service
    final message = await backupService.applyImport();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
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
                      onPressed: _importData,
                      icon: const Icon(Icons.download),
                      label: const Text('Import Data'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _exportData,
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
