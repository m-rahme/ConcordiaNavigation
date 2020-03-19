import 'dart:async';
import 'package:concordia_navigation/models/itinerary.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

///Observer Pattern
///Handles all the data related to the map, listens to changes and notifies listeners.
class MapData extends ChangeNotifier {
  Completer<GoogleMapController> _completer = Completer();
  PanelController panelController = new PanelController();
  final controllerStarting = TextEditingController();
  final controllerDestination = TextEditingController();

  Itinerary itinerary;

  Completer<GoogleMapController> get getCompleter {
    return _completer;
  }

  LatLng _currentLocation;
  String _campus;
  LatLng _start;
  LatLng _end;
  String _mode;
  String _duration;
  String _distance;

  MapData() {
    _mode = "driving";
  }

  void changeDuration(duration) {
    _duration = duration;
    notifyListeners();
  }

  void changeDistance(distance) {
    _distance = distance;
    notifyListeners();
  }

  void changeCampus(campus) {
    _campus = campus;
    notifyListeners();
  }

  void changeMode(mode) {
    _mode = mode;
    notifyListeners();
  }

  void changeStart(start) {
    _start = start;
    notifyListeners();
  }

  void changeEnd(end) {
    _end = end;
    notifyListeners();
  }

  void changeCurrentLocation(current) {
    _currentLocation = current;
  }

  LatLng get getCurrentLocation {
    return _currentLocation;
  }

  String get getMode {
    return _mode;
  }

  String get getDuration {
    return _duration;
  }

  String get getDistance {
    return _distance;
  }

  LatLng get getStart {
    return _start;
  }

  LatLng get getEnd {
    return _end;
  }

  String get getCampus {
    return _campus;
  }

  void setItinerary() async {
    itinerary = await Itinerary.create(_start, _end, _mode);
    _distance = Itinerary.getDistance();
    _duration = Itinerary.getDuration();
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
