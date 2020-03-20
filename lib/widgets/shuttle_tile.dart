import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/services/localization.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:concordia_navigation/providers/shuttle_data.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Tile with shuttle information used in the shuttle widget
class ShuttleTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var campus = Provider.of<MapData>(context, listen: false).getCampus;
    return FutureBuilder(
        future: Provider.of<ShuttleData>(context, listen: false)
            .getNextShuttle(campus),
        builder: (context, AsyncSnapshot shuttleTime) {
          switch (shuttleTime.connectionState) {
            // Uncompleted State
            case ConnectionState.none:
              return Text(ConcordiaLocalizations.of(context).errorOccurred);
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              // Completed with error
              if (shuttleTime.hasError)
                return Container(
                  child: Text(ConcordiaLocalizations.of(context).errorOccurred),
                );
          }
          return Container(
            decoration: BoxDecoration(
              color: constants.offWhiteColor,
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
                shuttleTime.data == null ? ConcordiaLocalizations.of(context).noShuttleBus : ConcordiaLocalizations.of(context).viaShuttleBus,
                style: GoogleFonts.raleway(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: constants.blackColor,
                ),
              ),
              subtitle: Text(
                shuttleTime.data == null
                    ? ConcordiaLocalizations.of(context).checkShuttleSchedule 
                    : shuttleTime.data,
                style: GoogleFonts.raleway(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                  color: constants.blackColor,
                ),
              ),
            ),
          );
        });
  }
}
