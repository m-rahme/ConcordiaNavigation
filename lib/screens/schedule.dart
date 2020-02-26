import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';

class Schedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ConcordiaLocalizations.of(context).schedule,
        ),
        backgroundColor: Color(0xFF73C700),
      ),
      body: Center(
        child: RaisedButton(
          child: Text(
            ConcordiaLocalizations.of(context).schedule,
          ),
          color: Color(0xFF73C700),
          textColor: Colors.white,
          onPressed: () {
            showDialog(
                context: context,
                child: new AlertDialog(
                  title: new Text(
                    ConcordiaLocalizations.of(context).schedule,
                  ),
                  content: new Text("Coming Soon!"),
                ));
          },
        ),
      ),
    );
  }
}
