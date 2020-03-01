import 'package:concordia_navigation/models/building.dart';
import 'package:concordia_navigation/storage/campus_buildings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/widgets.dart';

class BuildingsData extends ChangeNotifier {
  final Set<Building> buildings = new Set();
  final Set<Polygon> _polygons = new Set();
  final Set<Polygon> _clear = new Set();
  bool visible = true;

  Set<Polygon> get polygons {
    if (visible) {
      return _polygons;
    }
    return _clear;
  }

  BuildingsData() {
    loadBuildings();
    drawOutlines();
    showOutlines();
  }

  void loadBuildings() {
    // todo: parse data from simple json file not dart class
    CampusBuildings.buildings.forEach((key, value) {
      buildings.add(new Building(key, value));
    });
  }

  void drawOutlines() {
    buildings.forEach((building) {
      _polygons.add(building.outline);
    });
  }

  void showOutlines() {
    visible = true;
    notifyListeners();
  }

  void clearOutlines() {
    visible = false;
    notifyListeners();
  }
}
