import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';

//Concordia Shuttle Schedule Screen
class ShuttleSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ConcordiaLocalizations.of(context).shuttle,
        ),
        backgroundColor: greenColor,
      ),
      body: DataTable(
        columns: [
          DataColumn(label: Text('SGW to Loyola')),
        ],
        rows: [
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('07:40')),
            ],
          ),
        ],
      ),
    );
  }
}
