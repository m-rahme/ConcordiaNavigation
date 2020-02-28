import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class MapData extends ChangeNotifier {
  Completer<GoogleMapController> _completer = Completer();

  Completer<GoogleMapController> get getCompleter {
    return _completer;
  }

  LatLng start;
  LatLng end;
  String mode;

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
