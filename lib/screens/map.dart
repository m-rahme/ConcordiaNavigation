import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'campus_polygons.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng DEST_LOCATION = LatLng(45.495944, -73.578075);

class MapPage extends StatefulWidget {
  final Completer<GoogleMapController> completer;
  MapPage({Key key, this.completer}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController _controller;
  LatLng _currentLocation;
  CameraPosition _initialCameraLocation;
  StreamSubscription _locationSubscription;

  Location _location = new Location();
  String error;

  @override
  void initState() {
    super.initState();

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
    CampusPolygons poly = new CampusPolygons();
    while (_initialCameraLocation == null) {
      return Center(child: Text("Loading Map"));
    }
    return GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        compassEnabled: false,
        tiltGesturesEnabled: true,
        buildingsEnabled: false,
        mapType: MapType.normal,
        polygons: poly.allPolygons,
        indoorViewEnabled: true,
        trafficEnabled: false,
        onTap: (latLng) {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        initialCameraPosition: _initialCameraLocation,
        onMapCreated: (GoogleMapController controller) async {
          widget.completer.complete(controller);
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
