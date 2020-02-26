import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';

class OutdoorInterest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ConcordiaLocalizations.of(context).interest,
        ),
        backgroundColor: Color(0xFF73C700),
      ),
      body: Center(
        child: RaisedButton(
          child: Text(
            ConcordiaLocalizations.of(context).interest,
          ),
          color: Color(0xFF73C700),
          textColor: Colors.white,
          onPressed: () {
            showDialog(
                context: context,
                child: new AlertDialog(
                  title: new Text(
                    ConcordiaLocalizations.of(context).interest,
                  ),
                  content: new Text("Coming Soon!"),
                ));
          },
        ),
      ),
    );
  }
}
