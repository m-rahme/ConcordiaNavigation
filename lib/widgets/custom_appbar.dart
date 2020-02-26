import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/location_search.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF73C700),
      title: Text("ConNavigation"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.wb_sunny),
          onPressed: () {},
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
