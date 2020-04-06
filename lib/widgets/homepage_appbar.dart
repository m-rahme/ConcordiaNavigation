import 'package:concordia_navigation/screens/indoor_page.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/location_search.dart';

//Custom AppBar shown only in HomePage
class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: constants.appColor,
      title: Text("ConNavigation"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.domain),
          tooltip: "Go Indoor!",
          onPressed: () {
            Navigator.pushNamed(context, '/indoor',
                arguments: Arguments(false));
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
