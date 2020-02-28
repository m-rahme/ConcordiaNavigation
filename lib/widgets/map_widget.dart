import 'package:concordia_navigation/models/buildings_data.dart';
import 'package:concordia_navigation/models/map_data.dart';
import 'package:concordia_navigation/models/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
//*****UNCOMMENT BELLOW FOR DARK MAP*****
//import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 50;
const double CAMERA_BEARING = 30;
const LatLng SGW = LatLng(45.495944, -73.578075);
const LatLng LOYOLA = LatLng(45.4582, -73.6405);
bool _campus = true;

//*****UNCOMMENT BELLOW FOR DARK MAP*****
//String _mapStyle;

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _completer;
  BuildingsData _buildings;
  LatLng _currentLocation;
  CameraPosition _initialCameraLocation;
  StreamSubscription _locationSubscription;

  Location _location = new Location();
  String error;

  @override
  void initState() {
    super.initState();
    SizeConfig();
    //*****UNCOMMENT BELLOW FOR DARK MAP*****
    //*****MIGHT IMPLEMENT AUTOMATIC DARK MODE*****
//    rootBundle.loadString('assets/map_style.txt').then((string) {
//      _mapStyle = string;
//    });
    initPlatformState();
    _locationSubscription =
        _location.onLocationChanged().listen((newLocalData) {
      setState(() {
        _currentLocation =
            LatLng(newLocalData.latitude, newLocalData.longitude);
        _initialCameraLocation = CameraPosition(
          target: _currentLocation,
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING,
        );
      });
    });
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(1);
    SizeConfig().init(context);
    _completer = Provider.of<MapData>(context).getCompleter;
    _buildings = Provider.of<MapData>(context).buildings;

    while (_initialCameraLocation == null) {
      return Center(child: Text("Loading Map"));
    }

    Marker hBuildingMarker = Marker(
      markerId: MarkerId('h'),
      position: LatLng(45.497548, -73.579040),
      infoWindow: InfoWindow(title: 'Henry F. Hall Building'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 40,
              );
            });
      },
    );

    Marker lbBuildingMarker = Marker(
      markerId: MarkerId('lb'),
      position: LatLng(45.497111, -73.578028),
      infoWindow: InfoWindow(title: 'J.W. McConnell Building'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "J.W. McConnell Building",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "1400 De Maisonneuve Blvd. W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

//LOYOLA CAMPUS BUILDINGS
    Marker adBuildingMarker = Marker(
      markerId: MarkerId('ad'),
      position: LatLng(45.45827, -73.63945),
      infoWindow: InfoWindow(title: 'Administration Building'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Administration Building",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker bbBuildingMarker = Marker(
      markerId: MarkerId('bb'),
      position: LatLng(45.45979, -73.63909),
      infoWindow: InfoWindow(title: 'BB Annex'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "BB Annex",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "3502 Belmore",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker bhBuildingMarker = Marker(
      markerId: MarkerId('bh'),
      position: LatLng(45.45976, -73.63901),
      infoWindow: InfoWindow(title: 'BH Annex'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "BH Annex",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "3500 Belmore",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker ccBuildingMarker = Marker(
      markerId: MarkerId('cc'),
      position: LatLng(45.45823, -73.6399),
      infoWindow: InfoWindow(title: 'Central Building'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Central Building",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker cjBuildingMarker = Marker(
      markerId: MarkerId('cj'),
      position: LatLng(45.45748, -73.63981),
      infoWindow: InfoWindow(title: 'Communication Studies and Journalism Building'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Communication Studies and Journalism Building",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker doBuildingMarker = Marker(
      markerId: MarkerId('do'),
      position: LatLng(45.45793, -73.63523),
      infoWindow: InfoWindow(title: 'Stinger Dome (seasonal)'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Stinger Dome (Seasonal)",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker fcBuildingMarker = Marker(
      markerId: MarkerId('fc'),
      position: LatLng(45.45876, -73.63957),
      infoWindow: InfoWindow(title: 'F.C. Smith Building'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "F.C. Smith Building",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker geBuildingMarker = Marker(
      markerId: MarkerId('ge'),
      position: LatLng(45.45704, -73.64016),
      infoWindow: InfoWindow(title: 'Centre for Structural and Functional Genomics'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Centre for Structural and Functional Genomics",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker haBuildingMarker = Marker(
      markerId: MarkerId('ha'),
      position: LatLng(45.45949, -73.64088),
      infoWindow: InfoWindow(title: 'Hingston Hall (HA Wing)'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Hingston Hall (HA Wing)",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker hbBuildingMarker = Marker(
      markerId: MarkerId('hb'),
      position: LatLng(45.45921, -73.64168),
      infoWindow: InfoWindow(title: 'Hingston Hall (HB Wing)'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Hingston Hall (HB Wing)",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker hcBuildingMarker = Marker(
      markerId: MarkerId('hc'),
      position: LatLng(45.45983, -73.64183),
      infoWindow: InfoWindow(title: 'Hingston Hall (HC Wing)'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Hingston Hall (HC Wing)",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker huBuildingMarker = Marker(
      markerId: MarkerId('hu'),
      position: LatLng(45.45864, -73.64141),
      infoWindow: InfoWindow(title: 'Applied Science Hub'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Applied Science Hub",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker jrBuildingMarker = Marker(
      markerId: MarkerId('jr'),
      position: LatLng(45.45854, -73.64305),
      infoWindow: InfoWindow(title: 'Jesuit Residence'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Jesuit Residence",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker pcBuildingMarker = Marker(
      markerId: MarkerId('pc'),
      position: LatLng(45.45696, -73.63676),
      infoWindow: InfoWindow(title: 'PERFORM Centre'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "PERFORM Centre",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7200 Sherbrooke St. W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker psBuildingMarker = Marker(
      markerId: MarkerId('ps'),
      position: LatLng(45.45958, -73.63922),
      infoWindow: InfoWindow(title: 'Physical Services Building'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Physical Services Building",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker ptBuildingMarker = Marker(
      markerId: MarkerId('pt'),
      position: LatLng(45.45931, -73.63867),
      infoWindow: InfoWindow(title: 'Oscar Peterson Concert Hall'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Oscar Peterson Concert Hall",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker pyBuildingMarker = Marker(
      markerId: MarkerId('py'),
      position: LatLng(45.45909, -73.64015),
      infoWindow: InfoWindow(title: 'Psychology Building'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Psychology Building",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker raBuildingMarker = Marker(
      markerId: MarkerId('ra'),
      position: LatLng(45.45691, -73.63756),
      infoWindow: InfoWindow(title: 'Recreational and Athletics Complex'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Recreational and Athletics Complex",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7200 Sherbrooke St. W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker rfBuildingMarker = Marker(
      markerId: MarkerId('rf'),
      position: LatLng(45.45869, -73.6408),
      infoWindow: InfoWindow(title: 'Loyola Jesuit Hall and Conference Centre'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Loyola Jesuit Hall and Conference Centre",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker shBuildingMarker = Marker(
      markerId: MarkerId('sh'),
      position: LatLng(45.45933, -73.64237),
      infoWindow: InfoWindow(title: 'Solar House'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Solar House",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker siBuildingMarker = Marker(
      markerId: MarkerId('si'),
      position: LatLng(45.4581, -73.64241),
      infoWindow: InfoWindow(title: 'St. Ignatius of Loyola Church'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "St. Ignatius of Loyola Church",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "4455 Broadway",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker spBuildingMarker = Marker(
      markerId: MarkerId('sp'),
      position: LatLng(45.4572, -73.64065),
      infoWindow: InfoWindow(title: 'Richard J. Renaud Science Complex'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Richard J. Renaud Science Complex",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7141 Sherbrooke W.",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );

    Marker taBuildingMarker = Marker(
      markerId: MarkerId('ta'),
      position: LatLng(45.46005, -73.64079),
      infoWindow: InfoWindow(title: 'Terrebone Building'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "Terrebone Building",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "7079 Terrebone",
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Saturday - Sunday  08:00 - 21:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );


    return Stack(
      children: <Widget>[
        GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            compassEnabled: false,
            tiltGesturesEnabled: true,
            buildingsEnabled: false,
            mapType: MapType.normal,
            polygons: _buildings.polygons,
            markers: {hBuildingMarker, lbBuildingMarker, adBuildingMarker, bbBuildingMarker, bhBuildingMarker,
              ccBuildingMarker,cjBuildingMarker,doBuildingMarker,fcBuildingMarker,geBuildingMarker, haBuildingMarker,
              hbBuildingMarker, hcBuildingMarker, huBuildingMarker, jrBuildingMarker, pcBuildingMarker, psBuildingMarker,
              ptBuildingMarker, pyBuildingMarker, raBuildingMarker, rfBuildingMarker, shBuildingMarker, siBuildingMarker,
              spBuildingMarker, taBuildingMarker},
            indoorViewEnabled: false,
            trafficEnabled: false,
            initialCameraPosition: _initialCameraLocation,
            onMapCreated: (controller) async {
              _completer.complete(controller);
//          controller.setMapStyle(_mapStyle);
            }),
        Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.safeBlockVertical * 66,
            left: SizeConfig.safeBlockHorizontal * 83,
          ),
          child: FloatingActionButton(
            onPressed: () {
              _campus
                  ? () {
                      Provider.of<MapData>(context, listen: false)
                          .animateTo(SGW.latitude, SGW.longitude);
                      _campus = false;
                    }()
                  : () {
                      Provider.of<MapData>(context, listen: false)
                          .animateTo(LOYOLA.latitude, LOYOLA.longitude);
                      _campus = true;
                    }();
            },
            child: Icon(Icons.swap_calls),
            backgroundColor: Color(0xFFFFFFF8),
            foregroundColor: Color(0xFF656363),
            elevation: 5.0,
            heroTag: null,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.safeBlockVertical * 75,
            left: SizeConfig.safeBlockHorizontal * 83,
          ),
          child: FloatingActionButton(
            onPressed: () {
              Provider.of<MapData>(context, listen: false).animateTo(
                  _currentLocation.latitude, _currentLocation.longitude);
            },
            child: Icon(Icons.gps_fixed),
            backgroundColor: Color(0xFFFFFFF8),
            foregroundColor: Color(0xFF656363),
            elevation: 5.0,
            heroTag: null,
          ),
        ),
      ],
    );
  } // widget

  initPlatformState() async {
    LocationData myLocation;
    try {
      myLocation = await _location.getLocation();
      error = "";
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
        myLocation = null;
      }
    }
    setState(() {
      _currentLocation = LatLng(myLocation.latitude, myLocation.longitude);
      _initialCameraLocation = CameraPosition(
        target: _currentLocation,
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
      );
    });
  }
}
