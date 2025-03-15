import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import '../data/models/planner.dart';

class PlannerBackupService {
  // Converte a lista de planejadores para JSON
  String _plannersToJson(List<Planner> planners) {
    final List<Map<String, dynamic>> jsonList = 
        planners.map((plan) => plan.toMap()).toList();
    return jsonEncode(jsonList);
  }

  // Converte JSON para lista de planejadores
  List<Planner> _plannersFromJson(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map<Planner>((json) => Planner.fromMap(json)).toList();
  }

  // Exporta planejadores para arquivo JSON
  Future<String?> exportPlannersToJson(List<Planner> planners) async {
    try {
      // Converte planejadores para JSON
      final jsonData = _plannersToJson(planners);
      
      // Define a data para o nome do arquivo
      final now = DateTime.now();
      final fileName = 'planners_backup_${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}.json';
      
      // Abordagem alternativa com salvamento temporário
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/$fileName');
      await tempFile.writeAsString(jsonData);
      
      if (kDebugMode) {
        print("Arquivo temporário criado em: ${tempFile.path}");
      }

      // Usa o FilePicker para salvar o arquivo
      try {
        final result = await FilePicker.platform.saveFile(
          dialogTitle: 'Salvar backup dos planejadores',
          fileName: fileName,
        );
        
        if (result != null) {
          // Copia o arquivo temporário para o local selecionado
          await tempFile.copy(result);
          return 'Exportado com sucesso para $result';
        } else {
          // Usuário cancelou
          return null;
        }
      } catch (e) {
        // Fallback para dispositivos que não suportam saveFile
        if (kDebugMode) {
          print("Erro ao usar saveFile: $e, tentando método alternativo");
        }
        
        String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
          dialogTitle: 'Selecione a pasta para salvar o backup',
        );
        
        if (selectedDirectory != null) {
          final file = File('$selectedDirectory/$fileName');
          await tempFile.copy(file.path);
          return 'Exportado com sucesso para ${file.path}';
        }
      }
      
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao exportar: $e");
      }
      return 'Erro ao exportar: $e';
    }
  }

  // Importa planejadores de arquivo JSON
  Future<(List<Planner>?, String?)> importPlannersFromJson() async {
    try {
      // Seleciona arquivo JSON com tratamento de erro mais robusto
      FilePickerResult? result;
      try {
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['json'],
          dialogTitle: 'Selecione o arquivo de backup para importar',
        );
      } catch (e) {
        if (kDebugMode) {
          print("Erro ao usar pickFiles: $e, tentando método alternativo");
        }
        // Tenta novamente com configurações mais simples
        result = await FilePicker.platform.pickFiles();
      }
      
      if (result == null) {
        return (null, null); // Usuário cancelou
      }
      
      // Lê o arquivo
      final path = result.files.single.path;
      if (path == null) {
        return (null, 'Caminho do arquivo inválido');
      }
      
      File file = File(path);
      String jsonData = await file.readAsString();
      
      // Converte JSON para lista de planejadores
      List<Planner> importedPlanners = _plannersFromJson(jsonData);
      
      return (importedPlanners, null);
    } catch (e) {
      if (kDebugMode) {
        print("Erro na importação: $e");
      }
      return (null, 'Erro ao importar: $e');
    }
  }

  // Aplica os dados importados substituindo os existentes
  Future<String> applyImport() async {
    try {
      // Obtém os planos importados do arquivo JSON
      final (importedPlanners, errorMessage) = await importPlannersFromJson();
      
      if (errorMessage != null) {
        return errorMessage;
      }
      
      if (importedPlanners == null || importedPlanners.isEmpty) {
        return 'Nenhum dado para importar';
      }
      
      // Limpa os dados atuais
      await Planner.deleteAll();
      
      // Insere os planos importados
      int successCount = 0;
      int errorCount = 0;
      
      for (var plan in importedPlanners) {
        try {
          await Planner.insert(plan);
          successCount++;
        } catch (e) {
          if (kDebugMode) {
            print("Erro ao importar plano: $e");
          }
          errorCount++;
        }
      }
      
      String message = 'Dados importados com sucesso!';
      if (errorCount > 0) {
        message += ' ($successCount importados, $errorCount com erro)';
      }
      
      return message;
    } catch (e) {
      if (kDebugMode) {
        print("Erro na aplicação da importação: $e");
      }
      
      return 'Erro ao aplicar importação: $e';
    }
  }
}
