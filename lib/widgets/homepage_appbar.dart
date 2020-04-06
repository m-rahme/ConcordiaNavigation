import 'package:concordia_navigation/providers/buildings_data.dart';
import 'package:concordia_navigation/providers/indoor_data.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/location_search.dart';
import 'package:provider/provider.dart';

//Custom AppBar shown only in HomePage
class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: constants.appColor,
      title: Text("ConNavigation"),
      actions: <Widget>[
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
