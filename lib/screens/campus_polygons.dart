import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CampusPolygons {
  final Set<Polygon> allPolygons = {};

  final List<LatLng> Hbuilding = [
    LatLng(45.49738, -73.57833),
    LatLng(45.49755, -73.57869),
    LatLng(45.49772, -73.57903),
    LatLng(45.49744, -73.57929),
    LatLng(45.497171, -73.57954),
    LatLng(45.49702, -73.57923),
    LatLng(45.496837, -73.578848),
    LatLng(45.49715, -73.57855),
  ];

  final List<LatLng> LBbuilding = [
    LatLng(45.497289, -73.578050),
    LatLng(45.497032, -73.578303),
    LatLng(45.497014, -73.578264),
    LatLng(45.496974, -73.578305),
    LatLng(45.496949, -73.578254),
    LatLng(45.496903, -73.578295),
    LatLng(45.496920, -73.578334),
    LatLng(45.496871, -73.578375),
    LatLng(45.496896, -73.578426),
    LatLng(45.496711, -73.578615),
    LatLng(45.496690, -73.578553),
    LatLng(45.496646, -73.578594),
    LatLng(45.496239, -73.577696),
    LatLng(45.496491, -73.577444),
    LatLng(45.496583, -73.577639),
    LatLng(45.496645, -73.577580),
    LatLng(45.496621, -73.577529),
    LatLng(45.496912, -73.577258),
    LatLng(45.497022, -73.577516),
    LatLng(45.496986, -73.577549),
    LatLng(45.497004, -73.577624),
    LatLng(45.497060, -73.577574),
    LatLng(45.497108, -73.577715),
    LatLng(45.497056, -73.577767),
    LatLng(45.497064, -73.577785),
    LatLng(45.497073, -73.577775),
    LatLng(45.497100, -73.577832),
    LatLng(45.497138, -73.577796),
    LatLng(45.497288, -73.578050)
  ];

  CampusPolygons() {
    allPolygons.add(
      Polygon(
        polygonId: PolygonId('Hbuilding'),
        fillColor: Color(0x7A73C700),
        consumeTapEvents: false,
        geodesic: false,
        points: Hbuilding,
        strokeWidth: 0,
        strokeColor: Colors.transparent,
      ),
    );
    allPolygons.add(
      Polygon(
        polygonId: PolygonId('LBbuilding'),
        fillColor: Color(0x7A73C700),
        consumeTapEvents: false,
        geodesic: false,
        points: LBbuilding,
        strokeWidth: 0,
        strokeColor: Colors.transparent,
      ),
    );
  }
}
