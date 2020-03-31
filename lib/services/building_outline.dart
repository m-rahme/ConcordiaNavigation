import 'package:concordia_navigation/models/building.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BuildingOutline {
  Building building;
  bool updated = false;
  Polygon _outline;
  BuildingOutline(String name, List<LatLng> edges) {
    building = Building(buildingName: name, buildingEdges: edges);
  }
  Polygon get outline {
    if (_outline == null || updated == false) {
      _outline = new Polygon(
        polygonId: PolygonId(building.buildingName),
        fillColor: constants.maroonColor.withOpacity(0.7),
        consumeTapEvents: false,
        geodesic: false,
        points: building.buildingEdges,
        strokeWidth: 0,
      );
    }
    return _outline;
  }
}
