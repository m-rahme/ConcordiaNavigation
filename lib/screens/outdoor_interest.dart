import 'package:flutter/material.dart';

class OutdoorInterest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outdoor Interest'),
        backgroundColor: Color(0xFF73C700),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("All Outdoor Iterests"),
          color: Color(0xFF73C700),
          textColor: Colors.white,
          onPressed: () {
            showDialog(
                context: context,
                child: new AlertDialog(
                  title: new Text("Outdoor Interests"),
                  content: new Text("Coming Soon!"),
                ));
          },
        ),
      ),
    );
  }
}
