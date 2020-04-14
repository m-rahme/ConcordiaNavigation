import 'package:concordia_navigation/models/outdoor/user_location.dart';
import 'package:concordia_navigation/services/outdoor/location_service.dart';
import 'package:flutter/services.dart' show MethodCall, MethodChannel;
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';

class MockLocation extends Mock implements Location {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('LocationService', () {
    Location location;
    LocationData locationData;
    LocationService firstLocationService;

    setUp(() {
      // Setup MethodChannel in order to mock Location class
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
      location = MockLocation();
      when(location.onLocationChanged()).thenAnswer((_) => Stream.empty());
      when(location.requestPermission())
          .thenAnswer((_) => Future.value(null)); // Ignore this function call
      when(location.getLocation())
          .thenAnswer((_) => Future.value(locationData));

      // Create first instance of singleton LocationService
      firstLocationService = LocationService.getTestInstance(location);
    });

    test('creates same instance of LocationService + creates UserLocation',
        () async {
      // Try to create again
      LocationService second = LocationService.getTestInstance(location);

      // Verify
      expect(firstLocationService, isA<LocationService>());
      expect(firstLocationService, second);
      expect(await firstLocationService.getLocationData(), locationData);

      /**
       * Test setCurrent()
       * Cannot test this in separate test case because of an issue with Mocks and Singletons
       */
      // New Mock data
      Map<String, double> map = new Map();
      map['latitude'] = 10.0;
      map['longitude'] = 10.0;
      map['accuracy'] = 10.0;
      map['altitude'] = 10.0;
      map['speed'] = 10.0;
      map['speed_accuracy'] = 10.0;
      map['heading'] = 10.0;
      map['time'] = 10.0;
      LocationData data = LocationData.fromMap(map);
      UserLocation userLocation = new UserLocation.fromLocationData(data);

      // Reset MockLocation
      reset(location);
      when(location.getLocation()).thenAnswer((_) => Future.value(data));

      // Call method
      firstLocationService.updateCurrent();

      // Verify
      expect(userLocation.lat, data.latitude);
      expect(userLocation.long, data.longitude);
    });
  });
}
