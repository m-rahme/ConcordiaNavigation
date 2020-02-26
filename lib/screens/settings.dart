import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ConcordiaLocalizations.of(context).settings,
        ),
        backgroundColor: Color(0xFF73C700),
      ),
      body: Center(
        child: RaisedButton(
          child: Text(ConcordiaLocalizations.of(context).settings),
          color: Color(0xFF73C700),
          textColor: Colors.white,
          onPressed: () {
            showDialog(
                context: context,
                child: new AlertDialog(
                  title: new Text(ConcordiaLocalizations.of(context).settings),
                  content: new Text("Soen 390 Team"),
                ));
          },
        ),
      ),
    );
  }
}
