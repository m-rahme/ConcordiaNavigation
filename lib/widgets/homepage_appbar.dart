import '../providers/map_data.dart';
import '../screens/indoor_page.dart';
import '../storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

///Custom AppBar shown only in HomePage
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
          key: Key("LocationSearch"),
          icon: Icon(Icons.search),
          onPressed: () {
            Provider.of<MapData>(context, listen: false)
                    .panelController
                    .isPanelClosed
                ? Provider.of<MapData>(context, listen: false)
                    .panelController
                    .open()
                : Provider.of<MapData>(context, listen: false)
                    .panelController
                    .close();
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
