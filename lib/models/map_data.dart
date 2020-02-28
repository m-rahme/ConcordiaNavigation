import 'package:concordia_navigation/models/buildings_data.dart';
import 'package:concordia_navigation/models/itinerary.dart';
import 'package:concordia_navigation/models/supported_destination.dart';
import 'package:concordia_navigation/models/transportation_mode.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class MapData extends ChangeNotifier {
  Completer<GoogleMapController> _completer = Completer();
  BuildingsData buildings = BuildingsData();
  Completer<Itinerary> _lineCompleter = Completer();

  Completer<GoogleMapController> get getCompleter {
    return _completer;
  }
  Completer<Itinerary> get getLineCompleter {
    return _lineCompleter;
  }

  final controllerStaring = TextEditingController();
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
