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

          DataColumn(label: Text('Loyola Departure')),
          DataColumn(label: Text('Loyola Fri')),
          DataColumn(label: Text('SGW Departure')),
          DataColumn(label: Text('SGW Fri'))
        ],
        rows: [
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('07:30')),
              DataCell(Text('07:40')),
              DataCell(Text('07:35')),
              DataCell(Text('07:45')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('07:40')),
              DataCell(Text('08:15')),
              DataCell(Text('08:05')),
              DataCell(Text('08:20')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('07:55')),
              DataCell(Text('08:15')),
              DataCell(Text('08:20')),
              DataCell(Text('08:55')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('08:20')),
              DataCell(Text('09:10')),
              DataCell(Text('08:35')),
              DataCell(Text('09:30')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('08:35')),
              DataCell(Text('09:10')),
              DataCell(Text('08:55')),
              DataCell(Text('09:30')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('08:55')),
              DataCell(Text('10:20')),
              DataCell(Text('09:10')),
              DataCell(Text('10:05')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('09:10')),
              DataCell(Text('10:35')),
              DataCell(Text('09:30')),
              DataCell(Text('10:55')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('09:30')),
              DataCell(Text('11:10')),
              DataCell(Text('09:45')),
              DataCell(Text('11:10')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('09:45')),
              DataCell(Text('11:30')),
              DataCell(Text('10:05')),
              DataCell(Text('11:45')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('10:20')),
              DataCell(Text('11:45')),
              DataCell(Text('10:20')),
              DataCell(Text('12:05')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('10:35')),
              DataCell(Text('12:20')),
              DataCell(Text('10:55')),
              DataCell(Text('12:20')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('10:55')),
              DataCell(Text('12:40')),
              DataCell(Text('11:10')),
              DataCell(Text('12:55')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('11:10')),
              DataCell(Text('12:55')),
              DataCell(Text('11:45')),
              DataCell(Text('13:30')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('11:30')),
              DataCell(Text('13:30')),
              DataCell(Text('12:15')),
              DataCell(Text('13:45')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
            ],
          ),
          DataRow(
            selected: true,
            cells: [
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
              DataCell(Text('07:40')),
            ],
          ),

        ],
      ),
    );
  }
}
