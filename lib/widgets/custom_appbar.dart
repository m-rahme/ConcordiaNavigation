import 'package:concordia_navigation/models/buildings_data.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/location_search.dart';
import 'package:provider/provider.dart';
import 'package:concordia_navigation/models/map_data.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    BuildingsData buildingsService = Provider.of<MapData>(context).buildings;
    return AppBar(
      backgroundColor: Color(0xFF73C700),
      title: Text("ConNavigation"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.wb_sunny),
          onPressed: () {
            if (buildingsService.visible) {
              buildingsService.clearOutlines();
            } else {
              buildingsService.showOutlines();
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: LocationSearch());
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
