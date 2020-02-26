import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'campus_polygons.dart';

class MapData extends ChangeNotifier {
  Completer<GoogleMapController> _completer = Completer();
  CampusPolygons _poly = new CampusPolygons();

  CampusPolygons get getPolygon {
    return _poly;
  }

  Completer<GoogleMapController> get getCompleter {
    return _completer;
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
