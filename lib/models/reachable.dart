import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Abstract model class of a reachable coordinate
abstract class Reachable {
  double get lat => null;
  double get long => null;

  LatLng toLatLng();
}