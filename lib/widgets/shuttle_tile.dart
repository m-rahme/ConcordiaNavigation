import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:concordia_navigation/models/uni_location.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/services/outdoor/shuttle_service.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//Tile with shuttle information used in the shuttle widget
class ShuttleTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: fix to use element's campus
    // var mapData = Provider.of<MapData>(context, listen: false);
    // String campus;
    // if (mapData.end is Building) {
    //   campus = (mapData.end as UniLocation).parent.name;
    // } else if (mapData.end is IndoorLocation) {
    //   campus = (mapData.end as UniLocation).parent.parent.name;
    // } else {
    //   campus = "loy";
    // }
    String shuttleTime = ShuttleService.getNextShuttle("sgw");

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
