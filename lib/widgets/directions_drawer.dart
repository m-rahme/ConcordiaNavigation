import 'package:concordia_navigation/providers/map_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DirectionsDrawer extends StatefulWidget {
  @override
  _DirectionsDrawerState createState() => _DirectionsDrawerState();
}

class _DirectionsDrawerState extends State<DirectionsDrawer> {
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
      bottom: Provider.of<MapData>(context).bottomSheetBottomPosition,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () {
                Provider.of<MapData>(context, listen: false).toggleDrawer();
              },
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                height: 80,
                child: Text(
                  "Directions",
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 600,
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
