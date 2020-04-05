import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:concordia_navigation/services/shuttle_service.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Tile with shuttle information used in the shuttle widget
class ShuttleTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String campus = Provider.of<MapData>(context, listen: false).getCampus;
    String shuttleTime = ShuttleService.getNextShuttle(campus);

    return Container(
      decoration: BoxDecoration(
        color: constants.whiteColor,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(
            left: SizeConfig.safeBlockHorizontal * 5.0,
            right: SizeConfig.safeBlockHorizontal * 0.0,
            top: SizeConfig.safeBlockHorizontal * 0.0),
        leading: IconButton(
          icon: Image.asset('assets/logo.png'),
          tooltip: 'Concordia',
          onPressed: () {},
          iconSize: 45.0,
        ),
        title: Text(
          shuttleTime == null ? "No Shuttle Bus" : "via Shuttle Bus",
          style: GoogleFonts.raleway(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: constants.blackColor,
          ),
        ),
        subtitle: Text(
          shuttleTime == null
              ? "Check Shuttle Schedule For More Info"
              : shuttleTime,
          style: GoogleFonts.raleway(
            fontSize: 10.0,
            fontWeight: FontWeight.w600,
            color: constants.blackColor,
          ),
        ),
      ),
    );
  }
}
