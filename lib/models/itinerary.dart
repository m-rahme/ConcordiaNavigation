import 'dart:convert';
import 'package:concordia_navigation/services/directions_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//This class is used to generate an an Itinerary from the direction's JSON.
class Itinerary {
  ///Safety making sure the itinerary is generated only once.
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

  ///Parses the JSON returned by the Google API so we can build our route on screen, then returns the recommended routes
  Future<Map<String, Map<String, String>>> parseJson() async {
    // Requests the directions from Google API, in directions_service
    await DirectionsService.getDirections(_startDestination, _endDestination,
            mode: _mode)
        .then((value) {
      _parsedJson = json.decode(value);
      print(_parsedJson);
      //JSON contains all recommended routes, any transportation mode changes, and how many steps in the directions.
      _length = _parsedJson["routes"][0]["legs"][0]["steps"].length;
      print(_length);
      //safety prevents the JSON from being parsed multiple times unnecessarily
      if (safety) {
        for (int i = 0; i < _length; i++) {
          String s1 = _parsedJson["routes"][0]["legs"][0]["steps"][i]
                  ["html_instructions"]
              .replaceAll(
                  //Regex to replace certain special characters in HTML with whitespace
                  RegExp(r'(<\/?\w+\/?>?| \w+=\"\w+-\w+:\d.\d\w+\">)'),
                  ' ');
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
