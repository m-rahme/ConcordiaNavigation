
import 'package:concordia_navigation/services/location_service.dart';
import 'package:flutter/services.dart' show MethodCall, MethodChannel;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';

class MockLocation extends Mock implements Location{}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('LocationService', () {
    
    Location location;
    LocationData locationData;

    setUpAll(() {
      const MethodChannel channel = MethodChannel('lyokone/location');
      channel.setMockMethodCallHandler((MethodCall methodCall) async {});

      WidgetsFlutterBinding.ensureInitialized();
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

      location = MockLocation();
      when(location.onLocationChanged()).thenAnswer((_) => Stream.empty());
      when(location.requestPermission()).thenAnswer((_) => Future.value(null)); // Do nothing
      when(location.getLocation()).thenAnswer((_) => Future.value(locationData));
    });

    test('getInstance() returns the same instance', () {
      LocationService locationService1 = LocationService.getTestInstance(location);
      verify(location.getLocation()).called(1);

      LocationService locationService2 = LocationService.getTestInstance(location);
      expect(locationService1, isA<LocationService>());
      assert(locationService1 == locationService2);
    });


  });
}
