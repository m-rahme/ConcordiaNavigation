import 'package:concordia_navigation/services/outdoor/directions_service.dart';
import 'package:concordia_navigation/services/outdoor/outdoor_itinerary.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';

class MockDirectionsService extends Mock implements DirectionsService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Itinerary', () {
    MockDirectionsService mockDirectionsService;

    setUp(() async {
      mockDirectionsService = new MockDirectionsService();

      // Load sample Google directions used to compare results in tests
      String raw = await rootBundle.loadString('assets/testing/sampleGoogleDirections.json');
      String jsonString = raw.replaceAll(RegExp(r'\s'), '');

      // Stub mock methods
      when(mockDirectionsService.getDirections(any, any)).thenAnswer( (_) => Future.value(jsonString));
      when(mockDirectionsService.getDirections(any, any, mode: anyNamed("mode"))).thenAnswer( (_) => Future.value(jsonString));
    });

    test('create() creates Itinerary with polyline, itinerary map, duration, and distance', () async {
      OutdoorItinerary itin = await OutdoorItinerary.create(LatLng(90,90), LatLng(90,90), "walking", mockDirectionsService);

      // Get map itinerary
      Map<String, Map<String, String>> itineraryMap = itin.itinerary;
      String itineraryMapString = itineraryMap.toString().replaceAll(RegExp(r'\s'), '');

      // Verify
      expect(itineraryMapString, r'''{HeadsoutheastonAveMountainSightstowardAvenuePlamondon:{2mins:2mins},TurnrightontoAvenuePlamondon:{2mins:2mins},TurnleftontoBoulevardDécarie="font-size:0.9em">Destinationwillbeontheleft:{9mins:9mins}}''');
      expect(itin.duration, "13mins");
      expect(itin.distance, "1.1km");
    });

  });
}