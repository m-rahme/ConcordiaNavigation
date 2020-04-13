import 'package:concordia_navigation/services/outdoor/directions_service.dart';
import 'package:concordia_navigation/services/outdoor/network.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';

class MockNetwork extends Mock implements Network {}

void main() {
  group('DirectionsService', () {
    DirectionsService directionsService;
    MockNetwork mockNetwork;

    setUp(() async {
      directionsService = new DirectionsService();
      mockNetwork = new MockNetwork();
      directionsService.network = mockNetwork;

      when(mockNetwork.getData(any)).thenAnswer((_) => Future.value("data"));
    });

    test('getDirections() gets raw JSON data from Google API Directions',
        () async {
      LatLng start = new LatLng(45.495715, -73.579253);
      LatLng end = new LatLng(45.495160, -73.577880);

      String jsonData =
          await directionsService.getDirections(start, end, mode: "walking");
      expect(jsonData, "data");
    });
  });
}
