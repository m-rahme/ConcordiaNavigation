import 'package:concordia_navigation/models/indoor/floor.dart';
import 'package:concordia_navigation/models/outdoor/campus.dart';
import 'package:concordia_navigation/models/outdoor/outdoor_location.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart' show visibleForTesting;

class Building extends OutdoorLocation {
  // optional
  String buildingName;
  String logo;

  // required
  Polygon outline;

  static Map<Building, BitmapDescriptor> icons = {};

  @visibleForTesting
  Building.forTesting(String name, double latitude, double longitude)
      : super(name, latitude: latitude, longitude: longitude);

  Building(String buildingInitials, double latitude, double longitude,
      this.outline, this.buildingName, String buildingAddress, this.logo,
      {Campus parent})
      : super(buildingInitials,
            address: buildingAddress,
            latitude: latitude,
            longitude: longitude,
            parent: parent);

  /// All buildings have edges.
  /// Not every building has markers.
  ///
  /// Therefore, some of the parameters are optional.
  /// This is an example of converse error. thanks u
  factory Building.fromJson(Campus parent, Map json) {
    if (json['buildingInitials'] == null || json['edges'] == null) return null;
    List<Floor> floors = [];
    List<LatLng> edges = [];

    for (int i = 0; i < json['edges'].length; i++) {
      double lat = json['edges'][i]['latitude'];
      double long = json['edges'][i]['longitude'];

      LatLng temp = LatLng(lat, long);
      edges.add(temp);
    }

    Polygon outline = Polygon(
      polygonId: PolygonId(json['buildingInitials']),
      fillColor: constants.highlightColor.withOpacity(0.7),
      consumeTapEvents: false,
      geodesic: false,
      points: edges,
      strokeWidth: 0,
    );

    Building b = Building(
        json['buildingName'] ??
            json['buildingInitials'], // if buildingName is set, use it
        json['latitude'],
        json['longitude'],
        outline,
        json['buildingName'],
        json['buildingAddress'],
        json['logo'],
        parent: parent);

    if (json['floors'] != null) {
      for (int k = 0; k < json['floors'].length; k++) {
        Floor floor = Floor.fromJson(b, json['floors'][k]);
        if (floor != null) floors.add(floor);
      }
    }

    b.children = floors;

    return b;
  }
}
