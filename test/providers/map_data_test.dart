import 'dart:async';
import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/services/outdoor/location_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';

class MockLocation extends Mock implements Location {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('MapData', () {
    MapData mapData;
    Location mockLocation;
    LocationData locationData;
    LocationService locationService;
    
    setUpAll(() {
      const MethodChannel channel = MethodChannel('lyokone/location');
      channel.setMockMethodCallHandler((MethodCall methodCall) async {});
      

      // Mock data
      Map<String, double> dataMap = new Map();
      dataMap['latitude'] = 1.0;
      dataMap['longitude'] = 2.0;
      dataMap['accuracy'] = 3.0;
      dataMap['altitude'] = 4.0;
      dataMap['speed'] = 5.0;
      dataMap['speed_accuracy'] = 6.0;
      dataMap['heading'] = 7.0;
      dataMap['time'] = 8.0;
      locationData = LocationData.fromMap(dataMap);

      // Mock Location that LocationService will use
      mockLocation = MockLocation();
      when(mockLocation.onLocationChanged()).thenAnswer((_) => Stream.empty());
      when(mockLocation.requestPermission())
          .thenAnswer((_) => Future.value(null)); // Ignore this function call
      when(mockLocation.getLocation())
          .thenAnswer((_) => Future.value(locationData));

      // Create first instance of singleton LocationService
      locationService = LocationService.getTestInstance(mockLocation);

      mapData = new MapData(locationService);
    });

    test('constructor initializes mode to driving', () {
      expect(mapData.mode, "driving");
    });

    test('constructor creates a Completer<GoogleMapController>', () {
      expect(mapData.getCompleter, isA<Completer<GoogleMapController>>());
    });

    test('changes end', () {
      double latitude = -90.0;
      double longitude = -160.0;
      mapData.end = Building.forTesting("test", "address", latitude, longitude);
      expect(mapData.end, isA<Building>());
      expect(mapData.end.lat, latitude);
      expect(mapData.end.long, longitude);
    });

    test('changes start', () {
      double latitude = -90.0;
      double longitude = -160.0;
      mapData.start = Building.forTesting("test", "address", latitude, longitude);
      expect(mapData.start, isA<Building>());
      expect(mapData.end.lat, latitude);
      expect(mapData.end.long, longitude);
    });

    test('removeItinerary() sets intinerary to null', () {
      mapData.removeItinerary();
      expect(mapData.itinerary, null);
    });

  });
}
