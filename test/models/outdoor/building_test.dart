import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:concordia_navigation/models/outdoor/campus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
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
    });

    test('constructor set building name', () {
      building = Building('TEST', 'Mock building', 1.0, 2.0, "123 mock address",
          buildingEdges, null);
      expect(building.name, 'Mock building');
      expect(building.hasMarker(), false);
    });

    test('constructor fromJson() create a Building instance', () async {
      // Initialize
      Campus campus = Campus.forTesting("campusName", "campusInitials");
      Map json = {
        "buildingName": "Henry F. Hall Building",
        "buildingInitials": "H",
        "buildingAddress": "1455 De Maisonneuve Blvd. W.",
        "latitude": 45.497261,
        "longitude": -73.578943,
        "logo": "assets/markers/h.png",
        "edges": [
          {"latitude": 45.49738, "longitude": -73.57833},
          {"latitude": 45.49755, "longitude": -73.57869},
          {"latitude": 45.49715, "longitude": -73.57855}
        ],
      };

      // Create
      Building building = Building.fromJson(campus, json);

      // Verify
      expect(building.name, json["buildingName"]);
      expect(building.buildingInitials, json["buildingInitials"]);
      expect(building.address, json["buildingAddress"]);
      expect(building.lat, json["latitude"]);
      expect(building.long, json["longitude"]);
      expect(building.edges.length, json["edges"].length);

      await building.testGetBytesFromAsset(building.logo, 350);
      expect(building.hasMarker(), true);
    });
  });
}
