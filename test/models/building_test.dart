import 'package:concordia_navigation/models/building.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  group('Building', () {
    test('constructor creates Polygon', () {
      List<LatLng> buildingEdges = [
        LatLng(45.49738, -73.57833),
        LatLng(45.49755, -73.57869),
        LatLng(45.49772, -73.57903),
      ];
      final building = new Building('name', buildingEdges);
      expect(building.edges.length, 3);
      expect(building.outline, isA<Polygon>());
    });
  });
}
