import 'reachable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

///User location model with user's latitude and longitude.
class UserLocation implements Reachable {
  final double _latitude;
  final double _longitude;

  UserLocation(this._latitude, this._longitude);

  factory UserLocation.fromLocationData(LocationData loc) {
    return UserLocation(loc.latitude, loc.longitude);
  }

  factory UserLocation.fromLatLng(LatLng latLng) {
    return UserLocation(latLng.latitude, latLng.longitude);
  }

  @override
  LatLng toLatLng() => lat == null || long == null ? null : LatLng(lat, long);

  @override
  double get lat => _latitude;

  @override
  double get long => _longitude;
}
