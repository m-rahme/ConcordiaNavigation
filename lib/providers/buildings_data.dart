import '../models/outdoor/building.dart';
import '../models/university.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///Observer Pattern
///Handles data related to campus buildings, listens to changes and notifies listeners.
class BuildingsData extends ChangeNotifier {
  List<Building> allBuildings = [];
  List<Polygon> _allPolygons = [];
  List<Polygon> _clear = [];

  bool _visible = true;

  List<Polygon> get allPolygons {
    if (_visible) {
      return _allPolygons;
    }
    return _clear;
  }

  BuildingsData() {
    // Make one big set of buildings that has sgw + loy buildings
    University.concordia.children.forEach((campus) {
      allBuildings.addAll(campus.children.whereType<Building>());
    });

    // Add the outline of every buildings to one big set of Polygons
    allBuildings.forEach((building) {
      _allPolygons.add(building.outline);
    });

    _visible = true;
  }
  /// Toggle on and off the outlines of the building
  void toggleOutline() {
    _visible = !_visible;
    notifyListeners();
  }
}
