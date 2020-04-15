import '../storage/app_constants.dart';
import 'package:flutter/material.dart';
import '../services/localization.dart';

//App Settings Screen
class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ConcordiaLocalizations.of(context).settings,
        ),
        backgroundColor: appColor,
      ),
      body: Center(
        child: RaisedButton(
          child: Text(ConcordiaLocalizations.of(context).settings),
          color: appColor,
          textColor: whiteColor,
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
