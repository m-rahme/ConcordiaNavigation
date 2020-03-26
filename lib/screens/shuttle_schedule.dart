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
            selected: false,
            cells: [
              DataCell(Text('07:30')),
              DataCell(Text('07:40')),
              DataCell(Text('07:35')),
              DataCell(Text('07:45')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('07:40')),
              DataCell(Text('08:15')),
              DataCell(Text('08:05')),
              DataCell(Text('08:20')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('07:55')),
              DataCell(Text('08:15')),
              DataCell(Text('08:20')),
              DataCell(Text('08:55')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('08:20')),
              DataCell(Text('09:10')),
              DataCell(Text('08:35')),
              DataCell(Text('09:30')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('08:35')),
              DataCell(Text('09:10')),
              DataCell(Text('08:55')),
              DataCell(Text('09:30')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('08:55')),
              DataCell(Text('10:20')),
              DataCell(Text('09:10')),
              DataCell(Text('10:05')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('09:10')),
              DataCell(Text('10:35')),
              DataCell(Text('09:30')),
              DataCell(Text('10:55')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('09:30')),
              DataCell(Text('11:10')),
              DataCell(Text('09:45')),
              DataCell(Text('11:10')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('09:45')),
              DataCell(Text('11:30')),
              DataCell(Text('10:05')),
              DataCell(Text('11:45')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('10:20')),
              DataCell(Text('11:45')),
              DataCell(Text('10:20')),
              DataCell(Text('12:05')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('10:35')),
              DataCell(Text('12:20')),
              DataCell(Text('10:55')),
              DataCell(Text('12:20')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('10:55')),
              DataCell(Text('12:40')),
              DataCell(Text('11:10')),
              DataCell(Text('12:55')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('11:10')),
              DataCell(Text('12:55')),
              DataCell(Text('11:45')),
              DataCell(Text('13:30')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('11:30')),
              DataCell(Text('13:30')),
              DataCell(Text('12:15')),
              DataCell(Text('13:45')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('12:00')),
              DataCell(Text('14:05')),
              DataCell(Text('12:45')),
              DataCell(Text('14:05')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('12:30')),
              DataCell(Text('14:20')),
              DataCell(Text('13:15')),
              DataCell(Text('14:40')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('13:00')),
              DataCell(Text('14:40')),
              DataCell(Text('13:45')),
              DataCell(Text('14:55')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('13:30')),
              DataCell(Text('15:15')),
              DataCell(Text('14:15')),
              DataCell(Text('15:15')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('14:00')),
              DataCell(Text('15:30')),
              DataCell(Text('14:45')),
              DataCell(Text('15:50')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('14:30')),
              DataCell(Text('15:50')),
              DataCell(Text('15:15')),
              DataCell(Text('16:05')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('15:00')),
              DataCell(Text('16:25')),
              DataCell(Text('15:45')),
              DataCell(Text('16:25')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('15:30')),
              DataCell(Text('16:40')),
              DataCell(Text('16:15')),
              DataCell(Text('17:15')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('16:00')),
              DataCell(Text('17:00')),
              DataCell(Text('16:45')),
              DataCell(Text('17:30')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('16:30')),
              DataCell(Text('18:05')),
              DataCell(Text('17:15')),
              DataCell(Text('18:05')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('17:00')),
              DataCell(Text('18:40')),
              DataCell(Text('17:45')),
              DataCell(Text('18:40')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('17:30')),
              DataCell(Text('19:15')),
              DataCell(Text('18:15')),
              DataCell(Text('19:15')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('18:00')),
              DataCell(Text('19:50')),
              DataCell(Text('18:45')),
              DataCell(Text('19:50')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('18:30')),
              DataCell(Text('--:--')),
              DataCell(Text('19:15')),
              DataCell(Text('--:--')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('19:00')),
              DataCell(Text('--:--')),
              DataCell(Text('19:45')),
              DataCell(Text('--:--')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('19:30')),
              DataCell(Text('--:--')),
              DataCell(Text('20:00')),
              DataCell(Text('--:--')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('20:00')),
              DataCell(Text('--:--')),
              DataCell(Text('20:10')),
              DataCell(Text('--:--')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('20:30')),
              DataCell(Text('--:--')),
              DataCell(Text('20:30')),
              DataCell(Text('--:--')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('20:45')),
              DataCell(Text('--:--')),
              DataCell(Text('21:00')),
              DataCell(Text('--:--')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('21:05')),
              DataCell(Text('--:--')),
              DataCell(Text('21:25')),
              DataCell(Text('--:--')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('21:30')),
              DataCell(Text('--:--')),
              DataCell(Text('21:45')),
              DataCell(Text('--:--')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('22:00')),
              DataCell(Text('--:--')),
              DataCell(Text('22:00')),
              DataCell(Text('--:--')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('22:30')),
              DataCell(Text('--:--')),
              DataCell(Text('22:30')),
              DataCell(Text('--:--')),
            ],
          ),
          DataRow(
            selected: false,
            cells: [
              DataCell(Text('23:00')),
              DataCell(Text('--:--')),
              DataCell(Text('23:00')),
              DataCell(Text('--:--')),
            ],
          ),


        ],
      ),
    );
  }
}
