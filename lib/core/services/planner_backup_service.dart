import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import '../data/models/planner.dart';

class PlannerBackupService {
  // Converts the list of planners to JSON
  String _plannersToJson(List<Planner> planners) {
    final List<Map<String, dynamic>> jsonList = 
        planners.map((plan) => plan.toMap()).toList();
    return jsonEncode(jsonList);
  }

  // Converts JSON to list of planners
  List<Planner> _plannersFromJson(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map<Planner>((json) => Planner.fromMap(json)).toList();
  }

  // Exports planners to JSON file
  Future<String?> exportPlannersToJson(List<Planner> planners) async {
    try {
      // Converts planners to JSON
      final jsonData = _plannersToJson(planners);
      
      // Defines the date for the filename
      final now = DateTime.now();
      final fileName = 'planners_backup_${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}.json';
      
      // Alternative approach with temporary save
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/$fileName');
      await tempFile.writeAsString(jsonData);
      
      if (kDebugMode) {
        print("Temporary file created at: ${tempFile.path}");
      }

      // Uses FilePicker to save the file
      try {
        final result = await FilePicker.platform.saveFile(
          dialogTitle: 'Save planner backup',
          fileName: fileName,
        );
        
        if (result != null) {
          // Copies the temporary file to the selected location
          await tempFile.copy(result);
          return 'Successfully exported to $result';
        } else {
          // User canceled
          return null;
        }
      } catch (e) {
        // Fallback for devices that don't support saveFile
        if (kDebugMode) {
          print("Error using saveFile: $e, trying alternative method");
        }
        
        String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
          dialogTitle: 'Select folder to save backup',
        );
        
        if (selectedDirectory != null) {
          final file = File('$selectedDirectory/$fileName');
          await tempFile.copy(file.path);
          return 'Successfully exported to ${file.path}';
        }
      }
      
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error exporting: $e");
      }
      return 'Error exporting: $e';
    }
  }

  // Imports planners from JSON file
  Future<(List<Planner>?, String?)> importPlannersFromJson() async {
    try {
      // Selects JSON file with more robust error handling
      FilePickerResult? result;
      try {
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['json'],
          dialogTitle: 'Select backup file to import',
        );
      } catch (e) {
        if (kDebugMode) {
          print("Error using pickFiles: $e, trying alternative method");
        }
        // Tries again with simpler settings
        result = await FilePicker.platform.pickFiles();
      }
      
      if (result == null) {
        return (null, null); // User canceled
      }
      
      // Reads the file
      final path = result.files.single.path;
      if (path == null) {
        return (null, 'Invalid file path');
      }
      
      File file = File(path);
      String jsonData = await file.readAsString();
      
      // Converts JSON to planner list
      List<Planner> importedPlanners = _plannersFromJson(jsonData);
      
      return (importedPlanners, null);
    } catch (e) {
      if (kDebugMode) {
        print("Error importing: $e");
      }
      return (null, 'Error importing: $e');
    }
  }

  // Applies imported data replacing existing ones
  Future<String> applyImport() async {
    try {
      // Gets imported plans from JSON file
      final (importedPlanners, errorMessage) = await importPlannersFromJson();
      
      if (errorMessage != null) {
        return errorMessage;
      }
      
      if (importedPlanners == null || importedPlanners.isEmpty) {
        return 'No data to import';
      }
      
      // Clears current data
      await Planner.deleteAll();
      
      // Inserts imported plans
      int successCount = 0;
      int errorCount = 0;
      
      for (var plan in importedPlanners) {
        try {
          await Planner.insert(plan);
          successCount++;
        } catch (e) {
          if (kDebugMode) {
            print("Error importing plan: $e");
          }
          errorCount++;
        }
      }
      
      String message = 'Data imported successfully!';
      if (errorCount > 0) {
        message += ' ($successCount imported, $errorCount with errors)';
      }
      
      return message;
    } catch (e) {
      if (kDebugMode) {
        print("Error applying import: $e");
      }
      
      return 'Error applying import: $e';
    }
  }
}
