import '../../models/outdoor/outdoor_poi.dart';
import '../../providers/map_data.dart';
import '../../services/size_config.dart';
import '../../storage/app_constants.dart' as constants;
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

/// Widget displaying the outdoor point of interests
class OutdoorInterestWidget extends StatelessWidget {
  final List<OutdoorPOI> interests;

  OutdoorInterestWidget(this.interests);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: interests.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              height: SizeConfig.safeBlockVertical * 14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: Padding(
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
                            interests[index].logo,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 48,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          interests[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: constants.blackColor,
                          ),
                        ),
                        Text(
                          interests[index].address,
                          style: TextStyle(
                            fontSize: 14,
                            color: constants.blueColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Open: " +
                                interests[index].open +
                                " Close: " +
                                interests[index].close,
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
                            color: constants.appColor,
                            child: Text(
                              "Directions",
                              style: TextStyle(
                                  fontSize: 12.0, color: constants.whiteColor),
                            ),
                            onPressed: () {
                              mapData.controllerStarting = "Current Location";
                              mapData.start = null;
                              mapData.end = interests[index];
                              mapData.setItinerary();
                              mapData.panelController.open();
                              Navigator.of(context).pop();
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
        });
  }
}
