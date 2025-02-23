import 'package:flutter/material.dart';
import '../../db_helper.dart';
import 'generic_table_view.dart';

class DebugViews {
  static List<Widget> debugMenuItems(BuildContext context) {
    return [
      const Divider(),
      const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Debug Views', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      _createDebugTile(context, 'Realms', 'SELECT * FROM Realm'),
      _createDebugTile(context, 'Awaker Types', 'SELECT * FROM AwakerType'),
      _createDebugTile(context, 'Rarities', 'SELECT * FROM Rarity'),
      _createDebugTile(
          context, 'Edify Material Families', 'SELECT * FROM EdifyMaterialFamily'),
      _createDebugTile(context, 'Skill Material Families',
          'SELECT * FROM SkillMaterialFamily'),
      _createDebugTile(context, 'Skill Materials', 'SELECT * FROM SkillMaterials'),
      _createDebugTile(context, 'Advanced Skill Materials',
          'SELECT * FROM AdvancedSkillMaterials'),
      _createDebugTile(
          context, 'Edify Materials', 'SELECT * FROM EdifyMaterials'),
      _createDebugTile(
          context, 'Upgrade Types', 'SELECT * FROM UpgradeType'),
      _createDebugTile(
          context, 'Upgrade Calculations', 'SELECT * FROM UpgradeCalculations'),
      _createDebugTile(context, 'Awakers', 'SELECT * FROM Awakers'),
      _createDebugTile(context, 'Planner', 'SELECT * FROM Planner'),
    ];
  }

  static Widget _createDebugTile(
      BuildContext context, String title, String query) {
    return ListTile(
      leading: const Icon(Icons.bug_report),
      title: Text(title),
      onTap: () async {
        final db = await DBHelper().database;
        final result = await db.rawQuery(query);
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  GenericTableView(title: title, data: result),
            ),
          );
        }
      },
    );
  }
}
