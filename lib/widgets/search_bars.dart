import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/services/location_search.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:concordia_navigation/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapData>(
      builder: (context, mapData, child) => Container(
        decoration: BoxDecoration(
          color: constants.appColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14.0),
              bottomRight: Radius.circular(14.0)),
        ),
        height: SizeConfig.safeBlockVertical * 16,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    child: InkWell(
                      key: Key("StartLocation"),
                      onTap: () {
                        showSearch(
                            context: context, delegate: LocationSearch(true));
                      },
                      child: Container(
                        height: SizeConfig.safeBlockVertical * 5,
                        decoration: BoxDecoration(
                          color: constants.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              color: constants.greyColor,
                              blurRadius: 3.0,
                              spreadRadius: -1.0,
                              offset: Offset(
                                1.0,
                                3.0,
                                // Move to bottom 10 Vertically
                              ),
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Icon(Icons.search),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 3,
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                (mapData.controllerStarting != null &&
                                        mapData.controllerStarting.length > 35)
                                    ? mapData.controllerStarting.substring(0, 35)
                                    : mapData.controllerStarting ??
                                        "Start Location",
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                                style: GoogleFonts.raleway(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: constants.blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: InkWell(
                      key: Key("EndLocation"),
                      onTap: () {
                        showSearch(
                            context: context, delegate: LocationSearch(false));
                      },
                      child: Container(
                        height: SizeConfig.safeBlockVertical * 5,
                        decoration: BoxDecoration(
                          color: constants.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              color: constants.greyColor,
                              blurRadius: 3.0,
                              spreadRadius: -1.0,
                              offset: Offset(
                                1.0,
                                3.0,
                                // Move to bottom 10 Vertically
                              ),
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Icon(Icons.search),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 3,
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                (mapData.controllerEnding != null &&
                                        mapData.controllerEnding.length > 35)
                                    ? mapData.controllerEnding.substring(0, 35)
                                    : mapData.controllerEnding ??
                                        "End Location",
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                                style: GoogleFonts.raleway(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: constants.blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: SizeConfig.safeBlockVertical * 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Center(
                      child: mapData.itinerary == null
                          ? Text(
                              " - ",
                              style: GoogleFonts.raleway(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: constants.whiteColor,
                              ),
                            )
                          : Text(
                              mapData.itinerary.duration +
                                  " - " +
                                  mapData.itinerary.distance,
                              style: GoogleFonts.raleway(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: constants.whiteColor,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
