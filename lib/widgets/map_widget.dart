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

import 'building_widgets/building_marker.dart';
import 'buildingModels/building_list.dart';

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

  BuildingList buildingList = BuildingList();

  @override
  Widget build(BuildContext context) {
//    print(1);
    SizeConfig().init(context);
    _completer = Provider.of<MapData>(context).getCompleter;
    _buildings = Provider.of<MapData>(context).buildings;

    while (_initialCameraLocation == null) {
      return Center(child: Text("Loading Map"));
    }


    Set<Marker> setOfMarkers = {};
    buildingList.readBuildingFile();
    for(int i = 0; i<3; i++){
      print(buildingList.getListOfBuildings().length);
      BuildingMarker buildingMarker = BuildingMarker(
          building: buildingList.getListOfBuildings().elementAt(i),
          bContext: context);
      setOfMarkers.add(buildingMarker.getMarker());


    }

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

            markers:
            Set.of(setOfMarkers),

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
