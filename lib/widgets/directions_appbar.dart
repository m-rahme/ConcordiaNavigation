import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:google_fonts/google_fonts.dart';

//Custom Appbar shown only in Directions Page
class DirectionsAppBar extends StatefulWidget {
  static Color _swapCar;
  static Color _swapTransit;
  static Color _swapWalking;
  static Color _swapBike;
  @override
  _DirectionsAppBarState createState() => _DirectionsAppBarState();
}

class _DirectionsAppBarState extends State<DirectionsAppBar> {
  var _controllerStarting;
  var _controllerDestination;

  @override
  void initState() {
    super.initState();
    DirectionsAppBar._swapCar = constants.blueColor;
    DirectionsAppBar._swapTransit = constants.whiteColor;
    DirectionsAppBar._swapWalking = constants.whiteColor;
    DirectionsAppBar._swapBike = constants.whiteColor;
  }

  @override
  Widget build(BuildContext context) {
    _controllerStarting =
        Provider.of<MapData>(context, listen: false).controllerStarting;
    _controllerDestination =
        Provider.of<MapData>(context, listen: false).controllerDestination;
    return Consumer<MapData>(
      builder: (BuildContext context, mapData, Widget child) => Container(
        color: constants.greenColor,
        height: SizeConfig.safeBlockVertical * 25,
        width: SizeConfig.screenWidth,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.dehaze),
                    color: constants.whiteColor,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.directions_car),
                        color: DirectionsAppBar._swapCar,
                        onPressed: () {
                          mapData.changeMode("driving");
                          mapData.setItinerary();
                          setState(() {
                            if (DirectionsAppBar._swapCar ==
                                constants.whiteColor) {
                              DirectionsAppBar._swapCar = constants.blueColor;
                              DirectionsAppBar._swapTransit =
                                  constants.whiteColor;
                              DirectionsAppBar._swapWalking =
                                  constants.whiteColor;
                              DirectionsAppBar._swapBike = constants.whiteColor;
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.train),
                        color: DirectionsAppBar._swapTransit,
                        onPressed: () {
                          mapData.changeMode("transit");
                          mapData.setItinerary();
                          setState(() {
                            if (DirectionsAppBar._swapTransit ==
                                constants.whiteColor) {
                              DirectionsAppBar._swapTransit =
                                  constants.blueColor;
                              DirectionsAppBar._swapCar = constants.whiteColor;
                              DirectionsAppBar._swapWalking =
                                  constants.whiteColor;
                              DirectionsAppBar._swapBike = constants.whiteColor;
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.directions_walk),
                        color: DirectionsAppBar._swapWalking,
                        onPressed: () {
                          mapData.changeMode("walking");
                          mapData.setItinerary();
                          setState(() {
                            if (DirectionsAppBar._swapWalking ==
                                constants.whiteColor) {
                              DirectionsAppBar._swapWalking =
                                  constants.blueColor;
                              DirectionsAppBar._swapCar = constants.whiteColor;
                              DirectionsAppBar._swapTransit =
                                  constants.whiteColor;
                              DirectionsAppBar._swapBike = constants.whiteColor;
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.directions_bike),
                        color: DirectionsAppBar._swapBike,
                        onPressed: () {
                          mapData.changeMode("bicycling");
                          mapData.setItinerary();
                          setState(() {
                            if (DirectionsAppBar._swapBike ==
                                constants.whiteColor) {
                              DirectionsAppBar._swapBike = constants.blueColor;
                              DirectionsAppBar._swapCar = constants.whiteColor;
                              DirectionsAppBar._swapTransit =
                                  constants.whiteColor;
                              DirectionsAppBar._swapWalking =
                                  constants.whiteColor;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    color: constants.whiteColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                height: SizeConfig.safeBlockVertical * 5,
                width: SizeConfig.safeBlockHorizontal * 75,
                decoration: BoxDecoration(
                  color: constants.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[600],
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
                    Icon(Icons.search),
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.raleway(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: constants.blackColor,
                        ),
                        controller: _controllerStarting,
                        cursorColor: Colors.blue,
                        keyboardType: TextInputType.text,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          hintText: "Choose Starting Point",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 13.0,
                      child: IconButton(
                        padding: EdgeInsets.only(bottom: 0.0),
                        icon: Icon(
                          Icons.swap_vert,
                          size: 30.0,
                        ),
                        onPressed: () {
                          var start = mapData.getStart;
                          mapData.changeStart(mapData.getEnd);
                          mapData.changeEnd(start);
                          var temp = _controllerStarting.text;
                          _controllerStarting.text =
                              _controllerDestination.text;
                          _controllerDestination.text = temp;
                        },
                        color: constants.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                height: SizeConfig.safeBlockVertical * 5,
                width: SizeConfig.safeBlockHorizontal * 75,
                decoration: BoxDecoration(
                  color: constants.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[600],
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
                    Icon(Icons.search),
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.raleway(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: constants.blackColor,
                        ),
                        controller: _controllerDestination,
                        cursorColor: constants.blueColor,
                        keyboardType: TextInputType.text,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            hintText: "Choose Destination"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
