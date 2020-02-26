import 'package:concordia_navigation/models/buildings_data.dart';
import 'package:concordia_navigation/models/map_data.dart';
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
const LatLng DEST_LOCATION = LatLng(45.495944, -73.578075);

//*****UNCOMMENT BELLOW FOR DARK MAP*****
//String _mapStyle;

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _completer;
  LatLng _currentLocation;
  CameraPosition _initialCameraLocation;
  StreamSubscription _locationSubscription;

  Location _location = new Location();
  String error;

  @override
  void initState() {
    super.initState();
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
    BuildingsData buildings = new BuildingsData();
    _completer = Provider.of<MapData>(context).getCompleter;

    while (_initialCameraLocation == null) {
      return Center(child: Text("Loading Map"));
    }

    return GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        compassEnabled: false,
        tiltGesturesEnabled: true,
        buildingsEnabled: false,
        mapType: MapType.normal,
        polygons: buildings.polygons,
        indoorViewEnabled: true,
        trafficEnabled: false,
        onTap: (latLng) {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        initialCameraPosition: _initialCameraLocation,
        onMapCreated: (controller) async {
          _completer.complete(controller);
//          controller.setMapStyle(_mapStyle);
        });
  }

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
