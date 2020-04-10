import 'package:concordia_navigation/models/indoor/floor.dart';
import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/reachable.dart';
import 'package:concordia_navigation/models/uni_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum query_result { unsupported, invalid, supported }

class Search {
  // for getting latlng's
  static List<dynamic> supported = [];
  // in case anybody needs it
  static List<UniLocation> everything = [];
  // for searching
  static List<String> names = [];

  /// Search for everything but floors
  static dynamic query(String text) => Search.supported.firstWhere(
      (object) => object is! Floor && object.name.toUpperCase().contains(text.toUpperCase()),
      orElse: () => null);

  /// Granular search
  static LatLng indoor(Reachable location) {
    if (location is IndoorLocation && !supported.contains(location))
      throw Exception("sorry location not found or unsupported");
    else {
      return location.toLatLng();
    }
  }
}
