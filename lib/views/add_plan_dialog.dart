import 'package:flutter/material.dart';
import '../models/planner.dart';
import '../models/awaker.dart';

class AddPlanDialog extends StatefulWidget {
  const AddPlanDialog({super.key});

  @override
  State<AddPlanDialog> createState() => _AddPlanDialogState();
}

class _AddPlanDialogState extends State<AddPlanDialog> {
  Awaker? selectedAwaker;
  List<Awaker> awakers = [];
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for all "from" and "to" fields
  final basicAttackFromController = TextEditingController(text: '1');
  final basicAttackToController = TextEditingController(text: '1');
  final basicDefenseFromController = TextEditingController(text: '1');
  final basicDefenseToController = TextEditingController(text: '1');
  final exaltFromController = TextEditingController(text: '1');
  final exaltToController = TextEditingController(text: '1');
  final rouseFromController = TextEditingController(text: '1');
  final rouseToController = TextEditingController(text: '1');
  final skillOneFromController = TextEditingController(text: '1');
  final skillOneToController = TextEditingController(text: '1');
  final skillTwoFromController = TextEditingController(text: '1');
  final skillTwoToController = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    _loadAwakers();
    // Inicializar os controllers com valores válidos
    exaltFromController.text = '10';  // Menor valor possível para Exalt
    exaltToController.text = '10';    // Menor valor possível para Exalt
  }

  Future<void> _loadAwakers() async {
    final loadedAwakers = await Awaker.getAll();
    final existingPlans = await Planner.getAll();
    
    // Create a set of awaker IDs that are already in the planner
    final plannedAwakerIds = existingPlans.map((plan) => plan.awaker).toSet();
    
    // Filter out awakers that are already in the planner
    final availableAwakers = loadedAwakers.where(
      (awaker) => !plannedAwakerIds.contains(awaker.id)
    ).toList();
    
    // Sort the filtered list by name
    availableAwakers.sort((a, b) => a.name.compareTo(b.name));
    
    setState(() {
      awakers = availableAwakers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Plan'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<Awaker>(
                value: selectedAwaker,
                items: awakers.map((awaker) {
                  return DropdownMenuItem(
                    value: awaker,
                    child: Text(awaker.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAwaker = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Select Awaker'),
                validator: (value) {
                  if (value == null) return 'Please select an awaker';
                  return null;
                },
              ),
              _buildLevelInputRow('Basic Attack', basicAttackFromController, basicAttackToController),
              _buildLevelInputRow('Basic Defense', basicDefenseFromController, basicDefenseToController),
              _buildLevelInputRow('Exalt', exaltFromController, exaltToController, maxValue: 6),
              _buildLevelInputRow('Rouse', rouseFromController, rouseToController, maxValue: 6),
              _buildLevelInputRow('Skill One', skillOneFromController, skillOneToController, maxValue: 6),
              _buildLevelInputRow('Skill Two', skillTwoFromController, skillTwoToController, maxValue: 6),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _savePlan,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildLevelInputRow(String label, TextEditingController fromController, TextEditingController toController, {int maxValue = 6}) {
    final isExalt = label == 'Exalt';
    final List<int> values = isExalt 
        ? [10, 20, 30, 40, 50, 60]
        : List.generate(maxValue, (i) => i + 1);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label),
          ),
          Expanded(
            child: DropdownButtonFormField<int>(
              isExpanded: true, // Previne overflow
              value: int.tryParse(fromController.text),
              items: values.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: FittedBox( // Ajusta o tamanho do texto automaticamente
                    fit: BoxFit.scaleDown,
                    child: Text(
                      isExalt ? '$value/$value' : value.toString(),
                      style: const TextStyle(fontSize: 14), // Tamanho base menor
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  fromController.text = value.toString();
                  final toValue = int.tryParse(toController.text) ?? 1;
                  if (toValue < value) {
                    toController.text = value.toString();
                  }
                }
              },
              decoration: const InputDecoration(
                labelText: 'From',
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduz o padding
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField<int>(
              isExpanded: true, // Previne overflow
              value: int.tryParse(toController.text),
              items: values.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: FittedBox( // Ajusta o tamanho do texto automaticamente
                    fit: BoxFit.scaleDown,
                    child: Text(
                      isExalt ? '$value/$value' : value.toString(),
                      style: const TextStyle(fontSize: 14), // Tamanho base menor
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  toController.text = value.toString();
                  final fromValue = int.tryParse(fromController.text) ?? 1;
                  if (fromValue > value) {
                    fromController.text = value.toString();
                  }
                }
              },
              decoration: const InputDecoration(
                labelText: 'To',
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduz o padding
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _validateLevel(String? value, int maxValue) {
    if (value == null || value.isEmpty) return 'Required';
    final number = int.tryParse(value);
    if (number == null) return 'Invalid number';
    if (number < 1) return 'Min is 1';
    if (number > maxValue) return 'Max is $maxValue';
    return null;
  }

  void _savePlan() async {
    if (!_formKey.currentState!.validate()) return;
    
    try {
      final planner = Planner(
        awaker: selectedAwaker!.id!,
        basicAttackFrom: int.parse(basicAttackFromController.text),
        basicAttackTo: int.parse(basicAttackToController.text),
        basicDefenseFrom: int.parse(basicDefenseFromController.text),
        basicDefenseTo: int.parse(basicDefenseToController.text),
        exaltFrom: int.parse(exaltFromController.text),
        exaltTo: int.parse(exaltToController.text),
        rouseFrom: int.parse(rouseFromController.text),
        rouseTo: int.parse(rouseToController.text),
        skillOneFrom: int.parse(skillOneFromController.text),
        skillOneTo: int.parse(skillOneToController.text),
        skillTwoFrom: int.parse(skillTwoFromController.text),
        skillTwoTo: int.parse(skillTwoToController.text),
      );

      await Planner.insert(planner);
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}
