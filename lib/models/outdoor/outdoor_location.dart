import 'package:concordia_navigation/models/reachable.dart';
import 'package:concordia_navigation/models/uni_location.dart';
import 'package:concordia_navigation/services/search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// all outdoor locations are reachable
abstract class OutdoorLocation extends UniLocation implements Reachable {
  // an outdoor location could either an indoor or another outdoor location, hence, a unilocation
  final double _latitude;
  final double _longitude;

  String address;

  OutdoorLocation(String name,
      {UniLocation parent,
      List<UniLocation> children,
      double latitude,
      double longitude,
      String address})
      : address = address,
        _latitude = latitude,
        _longitude = longitude,
        super(name, parent: parent, children: children) {
    // skip universities and campuses as they're not specific points on a map
    // we could support this by simply removing this line and adding latitudes + longitudes in the .json file
    if (address != null) Search.supported.add(this);
  }

  @override
  double get lat => _latitude;

  @override
  double get long => _longitude;

  @override
  LatLng toLatLng() => lat == null || long == null ? null : LatLng(lat, long);
}
