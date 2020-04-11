import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/screens/indoor_page.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//Custom AppBar shown only in HomePage
class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: constants.appColor,
      title: Text("ConNavigation"),
      actions: <Widget>[
        Center(
          child: InkWell(
            child: Text(
              "Indoor",
              style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w600, fontSize: 18.0),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/indoor',
                  arguments: Arguments(false));
            },
          ),
        ),
        SizedBox(width: 7.0),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
//            showSearch(context: context, delegate: LocationSearch());
            Provider.of<MapData>(context, listen: false).togglePanel();
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
