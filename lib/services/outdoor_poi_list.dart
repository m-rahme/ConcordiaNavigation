import 'package:concordia_navigation/models/outdoor/outdoor_poi.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class OutdoorPOIList {
  static List<dynamic> poi;

  List<OutdoorPOI> pointOfInterests = List<OutdoorPOI>();

  static Future<List> loadJson() async => json
      .decode(await rootBundle.loadString('assets/json/pointsofinterest.json'));

  // give it a campus, it will parse the interests property of it
  OutdoorPOIList.fromJson(Map json) {
    for (int j = 0; j < json["interests"].length; j++) {
      pointOfInterests.add(OutdoorPOI.fromJson(json["interests"][j]));
    }
  }
}
