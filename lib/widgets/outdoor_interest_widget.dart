import 'package:concordia_navigation/models/outdoor_poi.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class OutdoorInterestWidget extends StatelessWidget {
  OutdoorInterestWidget({this.campus, this.snapshot});

  final String campus;
  final AsyncSnapshot<List<OutdoorPOI>> snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (snapshot.data[index].getCampus() == campus)
          return Card(
            child: Container(
              height: SizeConfig.safeBlockVertical * 14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          height: SizeConfig.safeBlockHorizontal * 18,
                          width: SizeConfig.safeBlockHorizontal * 18,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(75.0),
                            child: new Image.asset(
                              snapshot.data[index].getLogo(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 48,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          snapshot.data[index].getName(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: constants.blackColor,
                          ),
                        ),
                        Text(
                          snapshot.data[index].getAddress(),
                          style: TextStyle(
                            fontSize: 14,
                            color: constants.blueColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Open: " +
                                snapshot.data[index].getOpen() +
                                " Close: " +
                                snapshot.data[index].getClose(),
                            style: TextStyle(
                              fontSize: 14,
                              color: constants.greyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: SizeConfig.safeBlockHorizontal * 24,
                        height: SizeConfig.safeBlockVertical * 5,
                        child: Consumer<MapData>(
                            builder: (context, mapData, child) {
                          return RaisedButton(
                            color: constants.greenColor,
                            child: Text(
                              "Directions",
                              style: TextStyle(
                                  fontSize: 12.0, color: constants.whiteColor),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              mapData.controllerDestination.text =
                                  snapshot.data[index].getName();
                              mapData.controllerStarting.text =
                                  "Current Location";
                              mapData.changeStart(mapData.getCurrentLocation);
                              mapData.changeEnd(LatLng(
                                  snapshot.data[index].getLat(),
                                  snapshot.data[index].getLat()));
                              mapData.changeMode("driving");
                              mapData.setItinerary();
                            },
                          );
                        }),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        else
          return Container();
      },
      itemCount: snapshot.data.length,
    );
  }
}
