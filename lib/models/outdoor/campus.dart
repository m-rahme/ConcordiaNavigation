import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:concordia_navigation/models/outdoor/outdoor_location.dart';
import 'package:concordia_navigation/models/outdoor/outdoor_poi.dart';
import 'package:concordia_navigation/models/university.dart';

/// Model class of concrete outdoor location representing a campus
class Campus extends OutdoorLocation {
  final String initials;
  // Sir George Williams campus
  static Campus sgw;
  // Loyola campus
  static Campus loy;
  // List of outdoor points of interest
  final List<OutdoorPOI> interests = [];

  Campus._create(String name, this.initials, {University parent})
      : super(name, parent: parent);
  /// Factory constructor of a campus outdoor location from reading a json file
  factory Campus.fromJson(Map<String, dynamic> json, {University parent}) {
    if (json['campusName'] == null) return null;
    Campus c = Campus._create(json['campusName'], json['campusInitials'],
        parent: parent);
    List<Building> buildings = [];
    for (int bIndex = 0; bIndex < json['buildings'].length; bIndex++) {
      Building temp = Building.fromJson(c, json['buildings'][bIndex]);
      if (temp != null) buildings.add(temp);
    }
    c.children = buildings;

    for (int iIndex = 0; iIndex < json['interests'].length; iIndex++) {
      OutdoorPOI temp =
          OutdoorPOI.fromJson(json['interests'][iIndex], parent: c);
      if (temp != null) c.interests.add(temp);
    }

    return c;
  }
}
