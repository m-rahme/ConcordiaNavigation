import 'dart:async';
import 'package:concordia_navigation/models/itinerary.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

///Observer Pattern
///Handles all the data related to the map, listens to changes and notifies listeners.
class MapData extends ChangeNotifier {
  Completer<GoogleMapController> _completer = Completer();
  Itinerary itinerary;

  Completer<GoogleMapController> get getCompleter {
    return _completer;
  }

  final double _expandedBottomSheetBottomPosition =
      SizeConfig.blockSizeVertical * 0;
  final double _collapsedBottomSheetBottomPosition =
      SizeConfig.blockSizeVertical * -80;
  double bottomSheetBottomPosition = SizeConfig.blockSizeVertical * -80;
  bool directionsCollapsed = false;
  LatLng _currentLocation;
  String _campus;
  LatLng _start;
  LatLng _end;
  String _mode;

  MapData() {
    _mode = "driving";
  }

  void toggleDrawer() {
    if (bottomSheetBottomPosition == SizeConfig.blockSizeVertical * 0) {
      bottomSheetBottomPosition = SizeConfig.blockSizeVertical * -60;
    } else {
      bottomSheetBottomPosition = SizeConfig.blockSizeVertical * 0;
    }
    notifyListeners();
  }

  void setDrawer(bool value) {
    if (value) {
      bottomSheetBottomPosition = _expandedBottomSheetBottomPosition;
    } else {
      bottomSheetBottomPosition = _collapsedBottomSheetBottomPosition;
    }
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
    print(itinerary.itinerary);
    notifyListeners();
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
