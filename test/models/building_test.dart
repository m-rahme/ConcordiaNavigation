import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  group('Building', () {
    List<LatLng> buildingEdges;
    Building building;

    setUp(() {
      // Mock data
      buildingEdges = [
        LatLng(45.49738, -73.57833),
        LatLng(45.49755, -73.57869),
        LatLng(45.49772, -73.57903),
      ];
      building = Building('TEST', 'Mock building', 1.0, 2.0, "123 mock address",
          buildingEdges, "assets/mock_logo.png");
    });

    test('building name is set', () {
      expect(building.name, 'Mock building');
    });
  });
}
