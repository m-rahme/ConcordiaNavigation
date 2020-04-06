import 'package:concordia_navigation/providers/buildings_data.dart';
import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/location_search.dart';
import 'package:provider/provider.dart';

//Custom AppBar shown only in HomePage
class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appColor,
      title: Text("ConNavigation"),
      actions: <Widget>[
        Consumer<BuildingsData>(
          builder: (BuildContext context, buildings, Widget child) =>
              IconButton(
            icon: Icon(Icons.wb_sunny),
            onPressed: () {
              buildings.toggleOutline();
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.domain),
          tooltip: "Go indoor!",
          onPressed: () {
            Navigator.pushNamed(context, '/indoor');
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
