import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class MapData extends ChangeNotifier {
  Completer<GoogleMapController> _completer = Completer();

  Completer<GoogleMapController> get getCompleter {
    return _completer;
  }

  LatLng _currentLocation;
  String _campus;
  LatLng _start;
  LatLng _end;
  String _mode;

  MapData() {
    _mode = "driving";
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

  LatLng get getStart {
    return _start;
  }

  LatLng get getEnd {
    return _end;
  }

  String get getCampus {
    return _campus;
  }

  final controllerStarting = TextEditingController();
  final controllerDestination = TextEditingController();

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
