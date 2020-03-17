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
    var _controllerStarting =
        Provider.of<MapData>(context, listen: false).controllerStarting;
    var _controllerDestination =
        Provider.of<MapData>(context, listen: false).controllerDestination;

    Future<Map<String, Map<String, String>>> _fetchMoreData() async {
      Map<String, Map<String, String>> test =
          Provider.of<MapData>(context, listen: false)?.itinerary?.itinerary;
      await Future.delayed(Duration(seconds: 1));
      return Future.value(test);
    }

    SlidingUpPanel sp = SlidingUpPanel(
        controller: Provider.of<MapData>(context).panelController,
        maxHeight: 685.0,
        defaultPanelState: PanelState.OPEN,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        panel: Consumer<MapData>(
            builder: (BuildContext context, mapData, Widget child) => Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: constants.greenColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      height: SizeConfig.blockSizeVertical * 8,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 15.0,
                            child: IconButton(
                              icon: Icon(Icons.maximize),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                              _swapBike = constants.whiteColor;
                                            }
                                          },
                                        ),
                                        IconButton(
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
                                              _swapBike = constants.whiteColor;
                                            }
                                          },
                                        ),
                                        IconButton(
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
                                              _swapBike = constants.whiteColor;
                                            }
                                          },
                                        ),
                                        IconButton(
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
                                            .removeItinerary();
                                        if (_swapCar == constants.whiteColor) {
                                          _swapCar = constants.blueColor;
                                          _swapTransit = constants.whiteColor;
                                          _swapWalking = constants.whiteColor;
                                          _swapBike = constants.whiteColor;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), // top row for transportation mode selection
                    Container(
                      height: SizeConfig.safeBlockVertical * 14,
                      width: SizeConfig.safeBlockHorizontal * 100,
                      color: constants.greenColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: SizeConfig.safeBlockVertical * 5,
                                    width: SizeConfig.safeBlockHorizontal * 75,
                                    decoration: BoxDecoration(
                                      color: constants.whiteColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Icon(Icons.search),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 2.0),
                                            child: TextField(
                                              style: GoogleFonts.raleway(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                                color: constants.blackColor,
                                              ),
                                              controller: _controllerStarting,
                                              cursorColor: Colors.blue,
                                              keyboardType: TextInputType.text,
                                              keyboardAppearance:
                                                  Brightness.light,
                                              textInputAction:
                                                  TextInputAction.go,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 12),
                                                hintText:
                                                    "Choose Starting Point",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: SizeConfig.safeBlockVertical * 2,
                                  ),
                                  Container(
                                    height: SizeConfig.safeBlockVertical * 5,
                                    width: SizeConfig.safeBlockHorizontal * 75,
                                    decoration: BoxDecoration(
                                      color: constants.whiteColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Icon(Icons.search),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 2.0),
                                            child: TextField(
                                              style: GoogleFonts.raleway(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                                color: constants.blackColor,
                                              ),
                                              controller:
                                                  _controllerDestination,
                                              cursorColor: constants.blueColor,
                                              keyboardType: TextInputType.text,
                                              keyboardAppearance:
                                                  Brightness.light,
                                              textInputAction:
                                                  TextInputAction.go,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                          vertical: 12),
                                                  hintText:
                                                      "Choose Destination"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.only(top: 38, right: 10),
                            iconSize: 35,
                            icon: Icon(Icons.swap_vert),
                            color: constants.whiteColor,
                            onPressed: () {
                              var start = mapData.getStart;
                              mapData.changeStart(mapData.getEnd);
                              mapData.changeEnd(start);
                              var temp = _controllerStarting.text;
                              _controllerStarting.text =
                                  _controllerDestination.text;
                              _controllerDestination.text = temp;
                              mapData.setItinerary();
                            },
                          ),
                        ],
                      ),
                    ), // search bars
                    Container(
                      height: SizeConfig.safeBlockVertical * 45,
                      color: constants.whiteColor,
                      child: FutureBuilder(
                          future: _fetchMoreData(),
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
                    ShuttleWidget(),
                  ],
                )));

    if (Provider.of<MapData>(context).itinerary == null) {
      return Container();
    } else {
      return sp;
    }
  }
}
