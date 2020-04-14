import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Represents a location that has a latitude and longitude
/// That is, it is reachable to the user.
/// 
/// Classes implementing it must define a getter for lat, long
/// and a function toLatLng returning a LatLng.
/// 
/// Results of these operations are used when computing an itinerary.
abstract class Reachable {
  double get lat => null;
  double get long => null;

  LatLng toLatLng();
}