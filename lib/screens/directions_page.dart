import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/widgets/custom_drawer.dart';
import 'package:concordia_navigation/widgets/listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/models/size_config.dart';
import 'package:provider/provider.dart';
import 'package:concordia_navigation/widgets/shuttle_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class DirectionsPage extends StatefulWidget {
  static Color _white = Color(0xFFFFFFFF);
  static Color _blue = Color(0xFF017BFF);
  static Color _swapCar;
  static Color _swapTransit;
  static Color _swapWalking;
  static Color _swapBike;

  @override
  _DirectionsPageState createState() => _DirectionsPageState();
}

class _DirectionsPageState extends State<DirectionsPage> {
  var _controllerStarting;
  var _controllerDestination;

  @override
  void initState() {
    super.initState();
    DirectionsPage._swapCar = DirectionsPage._blue;
    DirectionsPage._swapTransit = DirectionsPage._white;
    DirectionsPage._swapWalking = DirectionsPage._white;
    DirectionsPage._swapBike = DirectionsPage._white;
  }

  @override
  Widget build(BuildContext context) {
    _controllerStarting = Provider.of<MapData>(context).controllerStaring;
    _controllerDestination =
        Provider.of<MapData>(context).controllerDestination;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        drawer: CustomDrawer(),
        body: Builder(
          builder: (context) => Column(
            children: <Widget>[
              Consumer<MapData>(
                builder: (BuildContext context, mapData, Widget child) =>
                    Container(
                  color: Color(0xFF73C700),
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
                              color: Colors.white,
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.directions_car),
                                  color: DirectionsPage._swapCar,
                                  onPressed: () {
                                    mapData.changeMode("driving");
                                    setState(() {
                                      if (DirectionsPage._swapCar ==
                                          DirectionsPage._white) {
                                        DirectionsPage._swapCar =
                                            DirectionsPage._blue;
                                        DirectionsPage._swapTransit =
                                            DirectionsPage._white;
                                        DirectionsPage._swapWalking =
                                            DirectionsPage._white;
                                        DirectionsPage._swapBike =
                                            DirectionsPage._white;
                                      }
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.train),
                                  color: DirectionsPage._swapTransit,
                                  onPressed: () {
                                    mapData.changeMode("transit");
                                    setState(() {
                                      if (DirectionsPage._swapTransit ==
                                          DirectionsPage._white) {
                                        DirectionsPage._swapTransit =
                                            DirectionsPage._blue;
                                        DirectionsPage._swapCar =
                                            DirectionsPage._white;
                                        DirectionsPage._swapWalking =
                                            DirectionsPage._white;
                                        DirectionsPage._swapBike =
                                            DirectionsPage._white;
                                      }
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.directions_walk),
                                  color: DirectionsPage._swapWalking,
                                  onPressed: () {
                                    mapData.changeMode("walking");
                                    setState(() {
                                      if (DirectionsPage._swapWalking ==
                                          DirectionsPage._white) {
                                        DirectionsPage._swapWalking =
                                            DirectionsPage._blue;
                                        DirectionsPage._swapCar =
                                            DirectionsPage._white;
                                        DirectionsPage._swapTransit =
                                            DirectionsPage._white;
                                        DirectionsPage._swapBike =
                                            DirectionsPage._white;
                                      }
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.directions_bike),
                                  color: DirectionsPage._swapBike,
                                  onPressed: () {
                                    mapData.changeMode("bicycling");
                                    setState(() {
                                      if (DirectionsPage._swapBike ==
                                          DirectionsPage._white) {
                                        DirectionsPage._swapBike =
                                            DirectionsPage._blue;
                                        DirectionsPage._swapCar =
                                            DirectionsPage._white;
                                        DirectionsPage._swapTransit =
                                            DirectionsPage._white;
                                        DirectionsPage._swapWalking =
                                            DirectionsPage._white;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              color: Colors.white,
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
                            color: DirectionsPage._white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                                    color: Color(0xFF000000),
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
                                  color: Colors.white,
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
                            color: DirectionsPage._white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                                    color: Color(0xFF000000),
                                  ),
                                  controller: _controllerDestination,
                                  cursorColor: Colors.blue,
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
              ),
              ListViewWidget(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  color: Color(0xFF73C700),
                ),
                height: SizeConfig.safeBlockVertical * 4,
                width: SizeConfig.screenWidth,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Concordia Shuttle Bus",
                        style: GoogleFonts.raleway(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/shuttle');
                        },
                        child: Text(
                          "SCHEDULE",
                          style: GoogleFonts.raleway(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Container(
                  color: Color(0xFFFFFFF8),
                  height: SizeConfig.safeBlockVertical * 12,
                  width: SizeConfig.screenWidth,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: ShuttleTile(),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(right: 30.0, top: 12.0),
                            height: SizeConfig.safeBlockVertical * 8,
                            width: SizeConfig.safeBlockHorizontal * 20,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "20mins",
                                  style: GoogleFonts.raleway(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF76C807),
                                  ),
                                ),
                                Text(
                                  "8.6km",
                                  style: GoogleFonts.raleway(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
