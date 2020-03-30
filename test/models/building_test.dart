import 'package:concordia_navigation/models/building.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  group('Building', () {
    
    List<LatLng> buildingEdges;
    Building building;

    setUp( () {
      // Mock data
      buildingEdges = [
        LatLng(45.49738, -73.57833),
        LatLng(45.49755, -73.57869),
        LatLng(45.49772, -73.57903),
      ];
      building = new Building('name', buildingEdges);
    });
    

    test('constructor creates a list of edges', () {
      expect(building.edges.length, buildingEdges.length);
    });


    test('creates a Polygon', () {
      expect(building.outline, isA<Polygon>());
    });
  });
}
