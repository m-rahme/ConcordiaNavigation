//import 'package:concordia_navigation/models/floor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Building {
  final String campusName;
  final String buildingName;
  final String buildingInitial;
  final String buildingAddress;
  final double latitude;
  final double longitude;
  final String filename;
  final List<LatLng> buildingEdges;
  //final Set<Floor> floors;
  Building({
    this.campusName,
    this.buildingName,
    this.buildingInitial,
    this.buildingAddress,
    this.latitude,
    this.longitude,
    this.filename,
    this.buildingEdges,
    //this.floors,
  });
}
