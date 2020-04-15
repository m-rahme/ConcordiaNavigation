import '../../providers/indoor_data.dart';
import '../../providers/map_data.dart';
import 'package:flutter/material.dart';
import '../../storage/app_constants.dart' as constants;
import '../../services/size_config.dart';
import 'package:provider/provider.dart';

/// Widget displaying the different mode of transportation
class TransportationModeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapData>(
      builder: (BuildContext context, mapData, Widget child) => Container(
        decoration: BoxDecoration(
          color: constants.appColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0), topRight: Radius.circular(14.0)),
        ),
        height: SizeConfig.safeBlockVertical * 8,
        child: Column(
          children: <Widget>[
            Container(
              height: SizeConfig.safeBlockVertical * 2,
              child: IconButton(
                icon: Icon(Icons.maximize),
                iconSize: 30.0,
                color: constants.whiteColor,
                onPressed: () {},
              ),
            ),
            Expanded(
              child: Container(
                height: SizeConfig.blockSizeVertical * 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      key: Key("Wheelchair"),
                      icon: Icon(Icons.accessible_forward),
                      color: Provider.of<IndoorData>(context).wheelchair
                          ? constants.blueColor
                          : constants.whiteColor,
                      onPressed: () {
                        Provider.of<IndoorData>(context, listen: false).toggleWheelchair();
                      },
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          key: Key("Driving"),
                          icon: Icon(Icons.directions_car),
                          color: mapData.mode == "driving"
                              ? constants.blueColor
                              : constants.whiteColor,
                          onPressed: () {
                            if (mapData.mode != "driving" &&
                                mapData.itinerary != null) {
                              mapData.mode = "driving";
                              mapData.setItinerary();
                            }
                          },
                        ),
                        IconButton(
                          key: Key("Transit"),
                          icon: Icon(Icons.train),
                          color: mapData.mode == "transit"
                              ? constants.blueColor
                              : constants.whiteColor,
                          onPressed: () {
                            if (mapData.mode != "transit" &&
                                mapData.itinerary != null) {
                              mapData.mode = "transit";
                              mapData.setItinerary();
                            }
                          },
                        ),
                        IconButton(
                          key: Key("Walking"),
                          icon: Icon(Icons.directions_walk),
                          color: mapData.mode == "walking"
                              ? constants.blueColor
                              : constants.whiteColor,
                          onPressed: () {
                            if (mapData.mode != "walking" &&
                                mapData.itinerary != null) {
                              mapData.mode = "walking";
                              mapData.setItinerary();
                            }
                          },
                        ),
                        IconButton(
                          key: Key("Bicycling"),
                          icon: Icon(Icons.directions_bike),
                          color: mapData.mode == "bicycling"
                              ? constants.blueColor
                              : constants.whiteColor,
                          onPressed: () {
                            if (mapData.mode != "bicycling" &&
                                mapData.itinerary != null) {
                              mapData.mode = "bicycling";
                              mapData.setItinerary();
                            }
                          },
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      color: constants.whiteColor,
                      onPressed: () {
                        mapData.panelController.close();
                        mapData.removeItinerary();
                        Provider.of<IndoorData>(context, listen: false)
                            .removeItinerary();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
