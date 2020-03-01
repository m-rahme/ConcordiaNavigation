import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:concordia_navigation/services/shuttle_data.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Tile with shuttle information used in the shuttle widget
class ShuttleTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var response1 = "via Shuttle Bus";
    var campus = Provider.of<MapData>(context, listen: false).getCampus;
    if (Provider.of<ShuttleData>(context, listen: false)
            .getNextShuttle(campus) ==
        "Check Shuttle Schedule for More Info") {
      response1 = "No Shuttle Bus Until Monday";
    }
    return Container(
      decoration: BoxDecoration(
        color: offWhiteColor,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(
            left: SizeConfig.safeBlockHorizontal * 5.0,
            right: SizeConfig.safeBlockHorizontal * 0.0,
            top: SizeConfig.safeBlockHorizontal * 0.0),
        leading: IconButton(
          icon: new Image.asset('assets/logo.png'),
          tooltip: 'Concordia',
          onPressed: () {},
          iconSize: 45.0,
        ),
        title: Text(
          response1,
          style: GoogleFonts.raleway(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: blackColor,
          ),
        ),
        subtitle: Text(
          Provider.of<ShuttleData>(context, listen: false)
              .getNextShuttle(campus),
          style: GoogleFonts.raleway(
            fontSize: 10.0,
            fontWeight: FontWeight.w600,
            color: blackColor,
          ),
        ),
      ),
    );
  }
}
