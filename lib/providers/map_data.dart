import 'dart:async';
import 'package:concordia_navigation/models/reachable.dart';
import 'package:concordia_navigation/models/uni_location.dart';
import 'package:concordia_navigation/services/outdoor/location_service.dart';
import 'package:concordia_navigation/services/outdoor/outdoor_itinerary.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;

///Observer Pattern
///Handles all the data related to the map, listens to changes and notifies listeners.
class MapData extends ChangeNotifier {
  Completer<GoogleMapController> _completer = Completer();
  PanelController panelController = new PanelController();
  LocationService locationService;
  Reachable _start, _end;
  bool panelVisible = false;

  String controllerStarting, controllerEnding;

  OutdoorItinerary itinerary;

  Completer<GoogleMapController> get getCompleter {
    return _completer;
  }

  String mode;

  MapData([LocationService location]) {
    locationService = location ?? LocationService.getInstance();
    mode = "driving";
  }

  Reachable get start => _start;
  Reachable get end => _end;

  // set the end Reachable object and use its name
  set end(Reachable obj) {
    _end = obj;
    if (obj != null) controllerEnding = (obj as UniLocation).name;
    else controllerEnding = null;
    notifyListeners();
  }

  // set the start Reachable object and use its name
  set start(Reachable obj) {
    _start = obj;
    if (obj != null) controllerStarting = (obj as UniLocation).name;
    else controllerStarting = null;
    notifyListeners();
  }

  void togglePanel() {
    panelVisible = !panelVisible;
    notifyListeners();
  }

  void setItinerary() async {
    // try to use parameters, but if they're not supplied use attributes
    if (_start == null)
      itinerary = await OutdoorItinerary.fromReachable(_start, _end, mode);
    else if (_start.toLatLng() != _end.toLatLng()) {
      itinerary = await OutdoorItinerary.fromReachable(_start, _end, mode);
    } else {
      print('Same start and end!');
    }
    notifyListeners();
  }

  /// Sets the shared itinerary object to null, causing a re-render of the DirectionsDrawer widget
  /// given it builds only with an empty Container() if it is indeed null
  void removeItinerary() {
    itinerary = null;
    _start = null;
    _end = null;
    controllerStarting = null;
    controllerEnding = null;
    notifyListeners();
  }

  CameraPosition getCameraFor(LatLng location) {
    if (location != null) {
      return CameraPosition(
        target: location,
        zoom: 16.5,
        tilt: 30.440717697143555,
        bearing: 30.8334901395799,
      );
    }
    return CameraPosition(
        target: constants.sgw,
        zoom: 16.5,
        tilt: 30.440717697143555,
        bearing: 30.8334901395799,
      );
  }

  CameraPosition getFixedLocationCamera() {
    return CameraPosition(
        target: constants.sgw,
        zoom: 16.5,
        tilt: 30.440717697143555,
        bearing: 30.8334901395799,
      );
  }

  Future<void> animateTo(double lat, double lng) async {
    animateToLatLng(LatLng(lat, lng));
  }

  Future<void> animateToReachable(Reachable loc) async {
    animateToLatLng(loc.toLatLng());
  }

  Future<void> animateToLatLng(LatLng location) async {
    final c = await _completer.future;
    final p = getCameraFor(location);
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  }
}
