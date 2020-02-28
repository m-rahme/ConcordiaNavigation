import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class UserLocation {
  double latitude;
  double longitude;

  UserLocation(this.latitude, this.longitude);

  UserLocation.fromData(LocationData locationData) {
    this.latitude = locationData.latitude;
    this.longitude = locationData.longitude;
  }

  factory UserLocation.SGW() {
    return UserLocation(45.495944, -73.578075);
  }

  factory UserLocation.LOYOLA() {
    return UserLocation(45.4582, -73.6405);
  }

  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }

}