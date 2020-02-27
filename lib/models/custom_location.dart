import 'package:concordia_navigation/models/itinerary.dart';
import 'package:concordia_navigation/models/supported_destination.dart';
import 'package:concordia_navigation/models/transportation_mode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'reachable.dart';

class CustomLocation implements Reachable {
  final double lat;
  final double long;
  final String desc;

  CustomLocation(this.lat, this.long, this.desc);

  static Future<LatLng> getCurrentLocation() =>
    Location()
    .getLocation()
    .then((LocationData currentLocation) {
      return LatLng(currentLocation.latitude, currentLocation.longitude);
    });

  Itinerary pathTo(SupportedDestination dest, TransportationMode mode) {
    return Itinerary(dest, mode);
  }
}