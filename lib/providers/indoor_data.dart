import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/university.dart';
import 'package:concordia_navigation/services/dijkstra.dart';
import 'package:concordia_navigation/services/outdoor/indoor_itinerary.dart';
import 'package:flutter/material.dart';

class IndoorData extends ChangeNotifier {
  IndoorItinerary _indoorItinerary;

  IndoorData();

  bool wheelchair = false;

  void toggleWheelchair() {
    wheelchair = !wheelchair;
    if (_indoorItinerary != null) {
      University.loadJson().then((data) {
        Dijkstra.shortest = Dijkstra.fromJson(data);
        setItinerary(
            start: _indoorItinerary.path.first.name,
            end: _indoorItinerary.path.last.name,
            accessible: wheelchair);
      });
    }
    notifyListeners();
  }

  IndoorItinerary get indoorItinerary => _indoorItinerary;

  void setItinerary({String start, String end, bool accessible}) {
    _indoorItinerary = IndoorItinerary(start, end, accessible: wheelchair);
    notifyListeners();
  }

  void removeItinerary() {
    _indoorItinerary = null;
    notifyListeners();
  }
}
