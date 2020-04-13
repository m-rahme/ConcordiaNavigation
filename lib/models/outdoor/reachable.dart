import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class Reachable {
  double get lat => null;
  double get long => null;

  LatLng toLatLng();
}