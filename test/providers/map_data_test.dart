import 'dart:async';
import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  group('MapData', () {
    MapData mapData;

    setUpAll(() {
      mapData = new MapData();
    });

    test('constructor initializes mode to driving', () {
      expect(mapData.mode, "driving");
    });

    test('constructor creates a Completer<GoogleMapController>', () {
      expect(mapData.getCompleter, isA<Completer<GoogleMapController>>());
    });

    test('changes mode', () {
      String newMode = "walking";
      mapData.mode = newMode;
      expect(mapData.mode, newMode);
    });

    test('changes end', () {
      double latitude = -90.0;
      double longitude = -160.0;
      mapData.end = Building.forTesting("test", latitude, longitude);
      expect(mapData.end, isA<Building>());
      expect(mapData.end.lat, mapData.end.long);
    });

    test('changes start', () {
      double latitude = -90.0;
      double longitude = -160.0;
      mapData.start = Building.forTesting("test", latitude, longitude);
      expect(mapData.start, isA<Building>());
      expect(mapData.start.lat, mapData.start.long);
    });
  });
}
