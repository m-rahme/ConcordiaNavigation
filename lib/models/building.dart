import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Building {
  String name;

  List<LatLng> edges;

  bool updated = false;

  Polygon _outline;

  Building(String name, List<LatLng> edges) {
    this.name = name;
    this.edges = edges;
  }

  Polygon get outline {
    if (_outline == null || updated == false) {
      _outline = new Polygon(
        polygonId: PolygonId(name),
        fillColor: Color(0xFF73C700).withOpacity(0.3),
        consumeTapEvents: false,
        geodesic: false,
        points: edges,
        strokeWidth: 0,
        strokeColor: Colors.transparent,
      );
    }
    return _outline;
  }
}
