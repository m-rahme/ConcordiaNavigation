import 'package:concordia_navigation/models/indoor/floor.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Building {
  // optional
  String buildingName;
  String buildingAddress;
  double latitude;
  double longitude;
  String logo;
  Set<Floor> floors = {};

  // required
  String buildingInitials;
  Polygon outline;

  static Map<Building, BitmapDescriptor> icons = {};

  Building(
      {@required this.buildingInitials,
      @required this.outline,
      this.buildingName,
      this.buildingAddress,
      this.latitude,
      this.longitude,
      this.logo,
      this.floors});

  /// All buildings have edges.
  /// Not every building has markers.
  ///
  /// Therefore, some of the parameters are optional.
  /// This is an example of converse error. thanks u
  Building.fromJson(Map json) : assert(json['buildingInitials'] != null) {
    // Optional parameters - can be null (if no marker, or if indoor unsupported for this floor)
    this.buildingName = json['buildingName'];
    this.buildingAddress = json['buildingAddress'];
    this.latitude = json['latitude'];
    this.longitude = json['longitude'];
    this.logo = json['logo'];

    if (json['floors'] != null) {
      for (int k = 0; k < json['floors'].length; k++) {
        this.floors.add(Floor.fromJson(json['floors'][k]));
      }
    }

    // Required parameters
    this.buildingInitials = json['buildingInitials'];

    List<LatLng> edges = [];

    for (int i = 0; i < json['edges'].length; i++) {
      double lat = json['edges'][i]['latitude'];
      double long = json['edges'][i]['longitude'];

      LatLng temp = LatLng(lat, long);
      edges.add(temp);
    }

    this.outline = Polygon(
      polygonId: PolygonId(this.buildingInitials),
      fillColor: constants.maroonColor.withOpacity(0.7),
      consumeTapEvents: false,
      geodesic: false,
      points: edges,
      strokeWidth: 0,
    );
  }
}
