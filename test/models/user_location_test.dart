import 'package:concordia_navigation/models/user_location.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() {
  group('UserLocation', () {

    LocationData locationData;

    setUpAll(() {
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
    });

    test('constructor creates user location with latitude and longitude', () {
      final userLocation = new UserLocation.fromLocationData(locationData);
      expect(userLocation.lat, 1.0);
      expect(userLocation.long, 2.0);
    });

    test('toLatLng() returns UserLocation as LatLng', () {
      UserLocation userLocation = new UserLocation(45.0, 90.0);
      LatLng userLocationLatLng = userLocation.toLatLng();
      expect(userLocationLatLng, isA<LatLng>());
      expect(userLocationLatLng.latitude, 45.0);
      expect(userLocationLatLng.longitude, 90.0);
    });
  });
}
