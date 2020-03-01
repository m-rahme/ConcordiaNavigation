import 'package:concordia_navigation/widgets/custom_drawer.dart';
import 'package:concordia_navigation/widgets/directions_appbar.dart';
import 'package:concordia_navigation/widgets/listview_widget.dart';
import 'package:concordia_navigation/widgets/shuttle_widget.dart';
import 'package:flutter/material.dart';

//Directions page where itinerary will be displayed.
class DirectionsPage extends StatefulWidget {
  @override
  _DirectionsPageState createState() => _DirectionsPageState();
}

class _DirectionsPageState extends State<DirectionsPage> {
  @override
  Widget build(BuildContext context) {
    ///Listen to taps to hide keyboard
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        drawer: CustomDrawer(),
        body: Builder(
          builder: (context) => Column(
            children: <Widget>[
              DirectionsAppBar(),
              ListViewWidget(),
              ShuttleWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
