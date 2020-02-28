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

  static Future<LatLng> getCurrentLocation() async {
    final LocationData locationData = await Location().getLocation();
    LatLng currentLocation =
        LatLng(locationData.latitude, locationData.longitude);
    return currentLocation;
  }

  Future<Itinerary> pathTo(SupportedDestination dest, String mode) {
    return Itinerary.create(dest, mode: mode);
  }
}
