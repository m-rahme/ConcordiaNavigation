import 'package:concordia_navigation/services/directions_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

class Itinerary {
  bool safety = true;
  LatLng _startDestination;
  LatLng _endDestination;
  String _mode;
  var _length;
  Map<String, dynamic> _parsedJson;
  Map<String, Map<String, String>> _itinerary =
      Map<String, Map<String, String>>();
  Itinerary(this._startDestination, this._endDestination, this._mode) {
    parseJson();
  }

  Future<Map<String, Map<String, String>>> parseJson() async {
    await DirectionsService.getDirections(_startDestination, _endDestination,
            mode: _mode)
        .then((value) {
      _parsedJson = json.decode(value);
      print(_parsedJson);
      _length = _parsedJson["routes"][0]["legs"][0]["steps"].length;
      print(_length);
      if (safety) {
        for (int i = 0; i < _length; i++) {
          String s1 = _parsedJson["routes"][0]["legs"][0]["steps"][i]
                  ["html_instructions"]
              .replaceAll(RegExp(r"(<\/?\w+\/?>)"), "");
          String s2 = _parsedJson["routes"][0]["legs"][0]["steps"][i]
              ["duration"]["text"];
          String s3 = _parsedJson["routes"][0]["legs"][0]["steps"][i]
              ["distance"]["text"];
          _itinerary.addAll({
            s1: {s2: s3}
          });
        }
        safety = false;
      }
    });
    return _itinerary;
  }
}
