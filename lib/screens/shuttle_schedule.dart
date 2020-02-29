import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';

class ShuttleSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ConcordiaLocalizations.of(context).shuttle,
        ),
        backgroundColor: Color(0xFF73C700),
      ),
      body: DataTable(
        columns: [
          DataColumn(label: Text("SGW to Loyola")),
          DataColumn(label: Text("Loyola to SGW")),
        ],
      ),
    );
  }
}
