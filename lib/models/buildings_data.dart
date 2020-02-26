import 'package:concordia_navigation/models/building.dart';
import 'package:concordia_navigation/storage/campus_polygons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BuildingsData extends ChangeNotifier {
  final Set<Building> buildings = new Set();
  final Set<Polygon> polygons = new Set();

  BuildingsData() {
    loadBuildings();
    drawOutlines();
  }

  void loadBuildings() {
    // todo: parse data from simple json file not dart class
    CampusPolygons.buildings.forEach((key, value) {
      buildings.add(new Building(key, value));
    });
  }

  void drawOutlines() {
    buildings.forEach((building) {
      polygons.add(building.outline);
    });
  }
}