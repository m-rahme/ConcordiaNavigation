import 'package:concordia_navigation/services/outdoor/indoor_itinerary.dart';
import 'package:flutter/material.dart';

class IndoorData extends ChangeNotifier {
  IndoorItinerary _indoorItinerary;

  IndoorData();

  IndoorItinerary get indoorItinerary => _indoorItinerary;

  void setItinerary(String start, String end) {
    _indoorItinerary = IndoorItinerary(start, end);
    notifyListeners();
  }

  void removeItinerary() {
    _indoorItinerary = null;
    notifyListeners();
  }
}
