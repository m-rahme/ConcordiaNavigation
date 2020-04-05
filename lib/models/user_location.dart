import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

///User location model with user's latitude and longitude.
class UserLocation {
  double latitude;
  double longitude;

  UserLocation(this.latitude, this.longitude);

  UserLocation.fromLocationData(LocationData locationData) {
    this.latitude = locationData.latitude;
    this.longitude = locationData.longitude;
  }

  factory UserLocation.sgw() {
    return UserLocation(45.495944, -73.578075);
  }

  factory UserLocation.loyola() {
    return UserLocation(45.4582, -73.6405);
  }

  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}
