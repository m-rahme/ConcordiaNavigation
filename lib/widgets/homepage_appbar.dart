import 'package:concordia_navigation/providers/buildings_data.dart';
import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/location_search.dart';
import 'package:provider/provider.dart';
import 'package:concordia_navigation/providers/map_data.dart';

//Custom AppBar shown only in HomePage
class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: greenColor,
      title: Text("ConNavigation"),
      actions: <Widget>[
        Consumer<BuildingsData>(
          builder: (BuildContext context, buildings, Widget child) =>
              IconButton(
            icon: Icon(Icons.wb_sunny),
            onPressed: () {
              if (buildings.visible) {
                buildings.clearOutlines();
              } else {
                buildings.showOutlines();
              }
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Provider.of<MapData>(context, listen: false).setDrawer(false);
            showSearch(context: context, delegate: LocationSearch());
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
