
import '../models/outdoor/university.dart';
import '../services/indoor/dijkstra.dart';
import '../services/outdoor/indoor_itinerary.dart';
import 'package:flutter/material.dart';

/// Class part of the provider model which uses indoor data
class IndoorData extends ChangeNotifier {
  IndoorItinerary _indoorItinerary;

  IndoorData();

  bool wheelchair = false;

  Future<void> toggleWheelchair() async {
    wheelchair = !wheelchair;
    if (_indoorItinerary != null) {
      List<dynamic> data = await University.loadJson();
      Dijkstra.shortest = Dijkstra.fromJson(data);
      setItinerary(
            start: _indoorItinerary.path.first.name,
            end: _indoorItinerary.path.last.name,
            accessible: wheelchair);
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
