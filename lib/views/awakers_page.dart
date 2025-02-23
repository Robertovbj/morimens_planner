import 'package:flutter/material.dart';
import '../models/awaker.dart';

class AwakersPage extends StatefulWidget {
  const AwakersPage({super.key});

  @override
  State<AwakersPage> createState() => _AwakersPageState();
}

class _AwakersPageState extends State<AwakersPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _realmController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _skillMaterialController = TextEditingController();
  final TextEditingController _edifyMaterialController = TextEditingController();
  final TextEditingController _advancedSkillMaterialController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  List<Awaker> _awakers = [];

  @override
  void initState() {
    super.initState();
    _loadAwakers();
  }

  Future<void> _loadAwakers() async {
    final awakers = await Awaker.getAll();
    setState(() {
      _awakers = awakers;
    });
  }

  Future<void> _addAwaker() async {
    final name = _nameController.text;
    final realm = int.tryParse(_realmController.text) ?? 0;
    final type = int.tryParse(_typeController.text) ?? 0;
    final skillMaterial = int.tryParse(_skillMaterialController.text) ?? 0;
    final edifyMaterial = int.tryParse(_edifyMaterialController.text) ?? 0;
    final advancedSkillMaterial = int.tryParse(_advancedSkillMaterialController.text) ?? 0;
    final level = int.tryParse(_levelController.text) ?? 0;

    if (name.isNotEmpty) {
      final awaker = Awaker(
        name: name,
        realm: realm,
        type: type,
        skillMaterial: skillMaterial,
        edifyMaterial: edifyMaterial,
        advancedSkillMaterial: advancedSkillMaterial,
        level: level,
      );
      await Awaker.insert(awaker);
      _nameController.clear();
      _realmController.clear();
      _typeController.clear();
      _skillMaterialController.clear();
      _edifyMaterialController.clear();
      _advancedSkillMaterialController.clear();
      _levelController.clear();
      _loadAwakers();
      print('Added Awaker: $awaker');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awakers'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _realmController,
              decoration: const InputDecoration(labelText: 'Realm'),
            ),
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            TextField(
              controller: _skillMaterialController,
              decoration: const InputDecoration(labelText: 'Skill Material'),
            ),
            TextField(
              controller: _edifyMaterialController,
              decoration: const InputDecoration(labelText: 'Edify Material'),
            ),
            TextField(
              controller: _advancedSkillMaterialController,
              decoration: const InputDecoration(labelText: 'Advanced Skill Material'),
            ),
            TextField(
              controller: _levelController,
              decoration: const InputDecoration(labelText: 'Level'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addAwaker,
              child: const Text('Add Awaker'),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _awakers.length,
              itemBuilder: (context, index) {
                final awaker = _awakers[index];
                return ListTile(
                  title: Text(awaker.name),
                  subtitle: Text('Level: ${awaker.level}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
