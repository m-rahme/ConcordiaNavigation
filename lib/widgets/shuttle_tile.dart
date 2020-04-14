import 'package:concordia_navigation/services/outdoor/shuttle_service.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///Tile with shuttle information used in the shuttle widget
class ShuttleTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String shuttleTime = ShuttleService.getNextShuttle("sgw");

    return Container(
      child: ListTile(
        leading: IconButton(
          icon: Image.asset('assets/png/concordia_logo.png'),
          tooltip: 'Concordia',
          onPressed: () {},
          iconSize: 45.0,
        ),
        title: Text(
          shuttleTime == null ? "Check Shuttle Schedule" : shuttleTime,
          style: GoogleFonts.raleway(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: constants.blackColor,
          ),
        ),
        subtitle: Text(
          shuttleTime == null ? "No Shuttle Bus" : "via Shuttle Bus",
          style: GoogleFonts.raleway(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: constants.blackColor,
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Text(
            '''
           8.6km
          20 mins
          ''',
            style: GoogleFonts.raleway(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: constants.blueColor,
            ),
          ),
        ),
      ),
    );
  }
}
