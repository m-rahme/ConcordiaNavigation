import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:concordia_navigation/services/size_config.dart';
import 'package:concordia_navigation/widgets/shuttle_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class DirectionsDrawer extends StatelessWidget {
  static Color _swapCar = constants.blueColor;
  static Color _swapTransit = constants.whiteColor;
  static Color _swapWalking = constants.whiteColor;
  static Color _swapBike = constants.whiteColor;

  @override
  Widget build(BuildContext context) {
    Future<Map<String, Map<String, String>>> fetchItinerary() async {
      Map<String, Map<String, String>> test =
          Provider.of<MapData>(context, listen: false)?.itinerary?.itinerary;
      return Future.value(test);
    }

    SlidingUpPanel sp = SlidingUpPanel(
        onPanelClosed: () {
          Provider.of<MapData>(context, listen: false)
              .changeSwapTop(SizeConfig.safeBlockVertical * 57);
          Provider.of<MapData>(context, listen: false)
              .changeLocationTop(SizeConfig.safeBlockVertical * 66);
        },
        onPanelOpened: () {
          Provider.of<MapData>(context, listen: false)
              .changeSwapTop(SizeConfig.safeBlockVertical * 66);
          Provider.of<MapData>(context, listen: false)
              .changeLocationTop(SizeConfig.safeBlockVertical * 75);
        },
        controller: Provider.of<MapData>(context).panelController,
        maxHeight: SizeConfig.safeBlockVertical * 85,
        defaultPanelState: PanelState.CLOSED,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        panel: Consumer<MapData>(
            builder: (BuildContext context, mapData, Widget child) => Column(
                  children: <Widget>[
                    Container(
                      height: SizeConfig.safeBlockVertical * 9,
                      decoration: BoxDecoration(
                        color: constants.appColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: SizeConfig.blockSizeVertical * 6,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        padding: EdgeInsets.only(left: 30.0),
                                        icon: Icon(Icons.accessibility),
                                        color: Colors.transparent,
                                        onPressed: () {},
                                      ),
                                      Row(
                                        children: <Widget>[
                                          IconButton(
                                            key: Key("Driving"),
                                            icon: Icon(Icons.directions_car),
                                            color: _swapCar,
                                            onPressed: () {
                                              mapData.changeMode("driving");
                                              mapData.setItinerary();
                                              if (_swapCar ==
                                                  constants.whiteColor) {
                                                _swapCar = constants.blueColor;
                                                _swapTransit =
                                                    constants.whiteColor;
                                                _swapWalking =
                                                    constants.whiteColor;
                                                _swapBike =
                                                    constants.whiteColor;
                                              }
                                            },
                                          ),
                                          IconButton(
                                            key: Key("Transit"),
                                            icon: Icon(Icons.train),
                                            color: _swapTransit,
                                            onPressed: () {
                                              mapData.changeMode("transit");
                                              mapData.setItinerary();
                                              if (_swapTransit ==
                                                  constants.whiteColor) {
                                                _swapTransit =
                                                    constants.blueColor;
                                                _swapCar = constants.whiteColor;
                                                _swapWalking =
                                                    constants.whiteColor;
                                                _swapBike =
                                                    constants.whiteColor;
                                              }
                                            },
                                          ),
                                          IconButton(
                                            key: Key("Walking"),
                                            icon: Icon(Icons.directions_walk),
                                            color: _swapWalking,
                                            onPressed: () {
                                              mapData.changeMode("walking");
                                              mapData.setItinerary();
                                              if (_swapWalking ==
                                                  constants.whiteColor) {
                                                _swapWalking =
                                                    constants.blueColor;
                                                _swapCar = constants.whiteColor;
                                                _swapTransit =
                                                    constants.whiteColor;
                                                _swapBike =
                                                    constants.whiteColor;
                                              }
                                            },
                                          ),
                                          IconButton(
                                            key: Key("Bicycling"),
                                            icon: Icon(Icons.directions_bike),
                                            color: _swapBike,
                                            onPressed: () {
                                              mapData.changeMode("bicycling");
                                              mapData.setItinerary();
                                              if (_swapBike ==
                                                  constants.whiteColor) {
                                                _swapBike = constants.blueColor;
                                                _swapCar = constants.whiteColor;
                                                _swapTransit =
                                                    constants.whiteColor;
                                                _swapWalking =
                                                    constants.whiteColor;
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.only(right: 30.0),
                                        icon: Icon(Icons.close),
                                        color: constants.whiteColor,
                                        onPressed: () {
                                          Provider.of<MapData>(context,
                                                  listen: false)
                                              .changeSwapTop(
                                                  SizeConfig.safeBlockVertical *
                                                      66);
                                          Provider.of<MapData>(context,
                                                  listen: false)
                                              .changeLocationTop(
                                                  SizeConfig.safeBlockVertical *
                                                      75);
                                          Provider.of<MapData>(context,
                                                  listen: false)
                                              .removeItinerary();
                                          if (_swapCar ==
                                              constants.whiteColor) {
                                            _swapCar = constants.blueColor;
                                            _swapTransit = constants.whiteColor;
                                            _swapWalking = constants.whiteColor;
                                            _swapBike = constants.whiteColor;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), // top row for transportation mode selection
                    Container(
                      color: constants.appColor,
                      height: SizeConfig.safeBlockVertical * 16,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: SizeConfig.safeBlockVertical * 12,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: SizeConfig.safeBlockVertical * 5,
                                      width:
                                          SizeConfig.safeBlockHorizontal * 75,
                                      decoration: BoxDecoration(
                                        color: constants.whiteColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Icon(Icons.search),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                Provider.of<MapData>(context,
                                                        listen: false)
                                                    .controllerStarting,
                                                style: GoogleFonts.raleway(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: constants.blackColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: SizeConfig.safeBlockVertical * 1,
                                    ),
                                    Container(
                                      height: SizeConfig.safeBlockVertical * 5,
                                      width:
                                          SizeConfig.safeBlockHorizontal * 75,
                                      decoration: BoxDecoration(
                                        color: constants.whiteColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
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
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Icon(Icons.search),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                Provider.of<MapData>(context,
                                                        listen: false)
                                                    .controllerDestination,
                                                style: GoogleFonts.raleway(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: constants.blackColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.only(top: 25, right: 10),
                                iconSize: 35,
                                icon: Icon(Icons.swap_vert),
                                color: constants.whiteColor,
                                onPressed: () {
                                  var start = mapData.getStart;
                                  mapData.changeStart(mapData.getEnd);
                                  mapData.changeEnd(start);
                                  String temp = Provider.of<MapData>(context,
                                          listen: false)
                                      .controllerStarting;
                                  Provider.of<MapData>(context, listen: false)
                                          .controllerStarting =
                                      Provider.of<MapData>(context,
                                              listen: false)
                                          .controllerDestination;
                                  Provider.of<MapData>(context, listen: false)
                                      .controllerDestination = temp;
                                  mapData.setItinerary();
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: SizeConfig.safeBlockVertical * 3.5,
                                  width: SizeConfig.safeBlockHorizontal * 55,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 55.0, top: 3.0),
                                    child: Text(
                                      "Duration: " + mapData.itinerary.duration,
                                      style: GoogleFonts.raleway(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color: constants.offWhiteColor,
                                      ),
                                    ),
                                  )),
                              Container(
                                height: SizeConfig.safeBlockVertical * 3.5,
                                width: SizeConfig.safeBlockHorizontal * 35,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, top: 3.0),
                                  child: Text(
                                    "Distance: " + mapData.itinerary.distance,
                                    style: GoogleFonts.raleway(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: constants.offWhiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: SizeConfig.safeBlockVertical * 43,
                      color: constants.whiteColor,
                      child: FutureBuilder(
                          future: fetchItinerary(),
                          builder: (context, AsyncSnapshot itinerary) {
                            switch (itinerary.connectionState) {
                              case ConnectionState.none:
                                return new Text('Error');
                              case ConnectionState.waiting:
                                return Center(
                                    child: CircularProgressIndicator());
                                break;
                              default:
                                // Completed with error
                                if (itinerary.hasError) {
                                  return Container(
                                    child: Text("Error Occured"),
                                  );
                                }
                                return Visibility(
                                  visible: itinerary.data != null,
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(
                                        right:
                                            SizeConfig.safeBlockHorizontal * 0),
                                    itemCount: itinerary.data.length,
                                    itemBuilder: (BuildContext context, index) {
                                      String key =
                                          itinerary.data.keys.elementAt(index);
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: constants.offWhiteColor,
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.0,
                                                color:
                                                    constants.lightGreyColor),
                                          ),
                                        ),
                                        child: ListTile(
                                          key: Key("Direction"+index.toString()),
                                          contentPadding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5.0,
                                              right: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5.0),
                                          leading: Icon(
                                              Icons.subdirectory_arrow_right),
                                          title: Text(
                                            "$key",
                                            style: GoogleFonts.raleway(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w600,
                                              color: constants.blackColor,
                                            ),
                                          ),
                                          subtitle: Text(
                                            "Time: " +
                                                "${itinerary.data[key].keys.toString().replaceAll(RegExp(r"\(|\)"), "")}" +
                                                "  " +
                                                "Distance: " +
                                                "${itinerary.data[key].values.toString().replaceAll(RegExp(r"\(|\)"), "")}",
                                            style: GoogleFonts.raleway(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400,
                                              color: constants.blackColor,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                            }
                          }),
                    ), // list of directions
                    Container(
                      height: SizeConfig.safeBlockVertical * 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        color: constants.appColor,
                      ),
                      child: ShuttleWidget(),
                    ),
                  ],
                )));

    if (Provider.of<MapData>(context).itinerary == null) {
      return Container(); // return an empty Container() if the itinerary object is null
    } else {
      return sp; // else return the SlidingUpPanel containing directions
    }
  }
}
