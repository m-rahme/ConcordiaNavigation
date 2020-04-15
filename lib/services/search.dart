import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/indoor/floor.dart';
import '../models/indoor/indoor_location.dart';
import '../models/outdoor/reachable.dart';
import '../models/uni_location.dart';

enum query_result { unsupported, invalid, supported }

/// Business logic for searching
/// Manages possible search results in the form of Reachable objects and Strings
/// 
/// A user's input is matched against the contents of the `supported` list.
/// This list contains the objects that themselves contain LatLng objects
/// for itinerary generation.
/// 
/// The `names` list contains the Strings of all the supported locations.
class Search {
  // for getting latlng's
  static List<dynamic> supported = [];
  // in case anybody needs it
  static List<UniLocation> everything = [];
  // for searching
  static List<String> names = [];

  /// Search for everything but floors
  static dynamic query(String text) => Search.supported.firstWhere(
      (object) =>
          object is! Floor &&
          object.name.toUpperCase().contains(text.toUpperCase()),
      orElse: () => null);

  /// Granular search
  static LatLng indoor(Reachable location) {
    if (location is IndoorLocation && !supported.contains(location)) {
      throw Exception("sorry location not found or unsupported");
    } else {
      return location.toLatLng();
    }
  }
}
