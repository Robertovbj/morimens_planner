import 'package:flutter/material.dart';

class GenericTableView extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> data;

  const GenericTableView({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: data.isEmpty
              ? const Center(child: Text('No data'))
              : DataTable(
                  columns: data.first.keys
                      .map((key) => DataColumn(label: Text(key)))
                      .toList(),
                  rows: data
                      .map(
                        (row) => DataRow(
                          cells: row.values
                              .map((value) =>
                                  DataCell(Text(value?.toString() ?? 'null')))
                              .toList(),
                        ),
                      )
                      .toList(),
                ),
        ),
      ),
    );
  }
}
