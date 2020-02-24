import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFF73C700),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Schedule"),
          color: Color(0xFF73C700),
          textColor: Colors.white,
          onPressed: () {
            showDialog(
                context: context,
                child: new AlertDialog(
                  title: new Text("Schedule"),
                  content: new Text("Coming Soon!"),
                ));
          },
        ),
      ),
    );
  }
}
