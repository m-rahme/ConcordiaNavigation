import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';

//Outdoor Interests Page
class OutdoorInterest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ConcordiaLocalizations.of(context).interest,
        ),
        backgroundColor: greenColor,
      ),
      body: Center(
        child: RaisedButton(
          child: Text(
            ConcordiaLocalizations.of(context).interest,
          ),
          color: greenColor,
          textColor: whiteColor,
          onPressed: () {
            showDialog(
                context: context,
                child: new AlertDialog(
                  title: new Text(
                    ConcordiaLocalizations.of(context).interest,
                  ),
                  content: new Text(ConcordiaLocalizations.of(context).comingSoon),
                ));
          },
        ),
      ),
    );
  }
}
