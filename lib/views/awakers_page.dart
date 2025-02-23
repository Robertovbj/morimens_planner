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
  final TextEditingController _constitutionController = TextEditingController();
  final TextEditingController _attackController = TextEditingController();
  final TextEditingController _defenseController = TextEditingController();
  final TextEditingController _criticalRateController = TextEditingController();
  final TextEditingController _criticalDamageController = TextEditingController();
  final TextEditingController _realmMasteryController = TextEditingController();
  final TextEditingController _strongAttackController = TextEditingController();
  final TextEditingController _aliemusRechargeController = TextEditingController();
  final TextEditingController _silverKeyRechargeController = TextEditingController();
  final TextEditingController _blackSigilDropRateController = TextEditingController();
  final TextEditingController _resistanceController = TextEditingController();
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
    final constitution = int.tryParse(_constitutionController.text) ?? 0;
    final attack = int.tryParse(_attackController.text) ?? 0;
    final defense = int.tryParse(_defenseController.text) ?? 0;
    final criticalRate = double.tryParse(_criticalRateController.text) ?? 0.0;
    final criticalDamage = double.tryParse(_criticalDamageController.text) ?? 0.0;
    final realmMastery = int.tryParse(_realmMasteryController.text) ?? 0;
    final strongAttack = double.tryParse(_strongAttackController.text) ?? 0.0;
    final aliemusRecharge = int.tryParse(_aliemusRechargeController.text) ?? 0;
    final silverKeyRecharge = int.tryParse(_silverKeyRechargeController.text) ?? 0;
    final blackSigilDropRate = double.tryParse(_blackSigilDropRateController.text) ?? 0.0;
    final resistance = double.tryParse(_resistanceController.text) ?? 0.0;
    final level = int.tryParse(_levelController.text) ?? 0;

    if (name.isNotEmpty) {
      final awaker = Awaker(
        name: name,
        realm: realm,
        type: type,
        constitution: constitution,
        attack: attack,
        defense: defense,
        criticalRate: criticalRate,
        criticalDamage: criticalDamage,
        realmMastery: realmMastery,
        strongAttack: strongAttack,
        aliemusRecharge: aliemusRecharge,
        silverKeyRecharge: silverKeyRecharge,
        blackSigilDropRate: blackSigilDropRate,
        resistance: resistance,
        level: level,
      );
      await Awaker.insert(awaker);
      _nameController.clear();
      _realmController.clear();
      _typeController.clear();
      _constitutionController.clear();
      _attackController.clear();
      _defenseController.clear();
      _criticalRateController.clear();
      _criticalDamageController.clear();
      _realmMasteryController.clear();
      _strongAttackController.clear();
      _aliemusRechargeController.clear();
      _silverKeyRechargeController.clear();
      _blackSigilDropRateController.clear();
      _resistanceController.clear();
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
              controller: _constitutionController,
              decoration: const InputDecoration(labelText: 'Constitution'),
            ),
            TextField(
              controller: _attackController,
              decoration: const InputDecoration(labelText: 'Attack'),
            ),
            TextField(
              controller: _defenseController,
              decoration: const InputDecoration(labelText: 'Defense'),
            ),
            TextField(
              controller: _criticalRateController,
              decoration: const InputDecoration(labelText: 'Critical Rate'),
            ),
            TextField(
              controller: _criticalDamageController,
              decoration: const InputDecoration(labelText: 'Critical Damage'),
            ),
            TextField(
              controller: _realmMasteryController,
              decoration: const InputDecoration(labelText: 'Realm Mastery'),
            ),
            TextField(
              controller: _strongAttackController,
              decoration: const InputDecoration(labelText: 'Strong Attack'),
            ),
            TextField(
              controller: _aliemusRechargeController,
              decoration: const InputDecoration(labelText: 'Aliemus Recharge'),
            ),
            TextField(
              controller: _silverKeyRechargeController,
              decoration: const InputDecoration(labelText: 'Silver Key Recharge'),
            ),
            TextField(
              controller: _blackSigilDropRateController,
              decoration: const InputDecoration(labelText: 'Black Sigil Drop Rate'),
            ),
            TextField(
              controller: _resistanceController,
              decoration: const InputDecoration(labelText: 'Resistance'),
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
