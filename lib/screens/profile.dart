import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF73C700),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Connect Google Calendar"),
          color: Color(0xFF73C700),
          textColor: Colors.white,
          onPressed: () {
            showDialog(
                context: context,
                child: new AlertDialog(
                  title: new Text("Google Calendar"),
                  content: new Text("Coming Soon!"),
                ));
          },
        ),
      ),
    );
  }
}
