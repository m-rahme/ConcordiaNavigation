import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:google_maps_flutter/google_maps_flutter.dart';

//This class is a building model, with building name, list of edges, and polygon.
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
        fillColor: constants.greenColor.withOpacity(0.3),
        consumeTapEvents: false,
        geodesic: false,
        points: edges,
        strokeWidth: 0,
      );
    }
    return _outline;
  }
}
