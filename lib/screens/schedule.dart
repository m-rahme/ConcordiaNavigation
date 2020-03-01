import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';

//User Schedule Screen
class Schedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ConcordiaLocalizations.of(context).schedule,
        ),
        backgroundColor: greenColor,
      ),
      body: Center(
        child: RaisedButton(
          child: Text(
            ConcordiaLocalizations.of(context).schedule,
          ),
          color: greenColor,
          textColor: whiteColor,
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
