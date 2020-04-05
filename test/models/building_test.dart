import 'package:concordia_navigation/models/building.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  group('Building', () {
    test('constructor creates a list of edges', () {
      List<LatLng> buildingEdges = [
        LatLng(45.49738, -73.57833),
        LatLng(45.49755, -73.57869),
        LatLng(45.49772, -73.57903),
      ];
      Building building =
          new Building(buildingName: 'name', buildingEdges: buildingEdges);
      expect(building.buildingEdges.length, buildingEdges.length);
    });

    test('constructor creates BuildingInformation', () {
      Building buildingInformation = new Building(
        campusName: "campusName",
        buildingName: "buildingName",
        buildingInitial: "buildingInitial",
        buildingAddress: "buildingAddress",
        latitude: 90.0,
        longitude: 180.0,
        filename: "filename",
      );

      expect(buildingInformation.campusName, "campusName");
      expect(buildingInformation.buildingName, "buildingName");
      expect(buildingInformation.buildingInitial, "buildingInitial");
      expect(buildingInformation.buildingAddress, "buildingAddress");
      expect(buildingInformation.latitude, 90.0);
      expect(buildingInformation.longitude, 180.0);
      expect(buildingInformation.filename, "filename");
    });
  });
}
