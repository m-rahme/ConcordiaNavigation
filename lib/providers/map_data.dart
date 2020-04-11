import 'dart:async';
import 'package:concordia_navigation/models/reachable.dart';
import 'package:concordia_navigation/models/uni_location.dart';
import 'package:concordia_navigation/services/outdoor/outdoor_itinerary.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

///Observer Pattern
///Handles all the data related to the map, listens to changes and notifies listeners.
class MapData extends ChangeNotifier {
  Completer<GoogleMapController> _completer = Completer();
  PanelController panelController = new PanelController();
  Reachable _start, _end;
  bool wheelchair = false;
  bool panelVisible = false;

  String controllerStarting, controllerEnding;

  OutdoorItinerary itinerary;

  Completer<GoogleMapController> get getCompleter {
    return _completer;
  }

  LatLng _currentLocation;

  String mode;

  MapData() : mode = "driving";

  Reachable get start => _start;
  Reachable get end => _end;

  // set the end Reachable object and use its name
  set end(Reachable obj) {
    _end = obj;
    controllerEnding = (obj as UniLocation).name;
  }

  // set the start Reachable object and use its name
  set start(Reachable obj) {
    _start = obj;
    controllerStarting = (obj as UniLocation).name;
  }

  void changeCurrentLocation(current) {
    _currentLocation = current;
  }

  void togglePanel() {
    panelVisible = !panelVisible;
    notifyListeners();
  }

  void toggleWheelchair() {
    wheelchair = !wheelchair;
    notifyListeners();
  }

  LatLng get getCurrentLocation {
    return _currentLocation;
  }

  void setItinerary({Reachable start, Reachable end}) async {
    // try to use parameters, but if they're not supplied use attributes
    itinerary = await OutdoorItinerary.fromReachable(
        start ?? _start, end ?? _end, mode);
    notifyListeners();
  }

  /// Sets the shared itinerary object to null, causing a re-render of the DirectionsDrawer widget
  /// given it builds only with an empty Container() if it is indeed null
  void removeItinerary() {
    itinerary = null;
    notifyListeners();
  }

  Future<void> animateTo(double lat, double lng) async {
    final c = await _completer.future;
    final p = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 16.5,
      tilt: 30.440717697143555,
      bearing: 30.8334901395799,
    );
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  }
}
