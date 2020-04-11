import 'dart:async';
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
      expect(mapData.getMode, "driving");
    });

    test('constructor creates a Completer<GoogleMapController>', () {
      expect(mapData.getCompleter, isA<Completer<GoogleMapController>>());
    });

    test('changes mode', () {
      String newMode = "walking";
      mapData.changeMode(newMode);
      expect(mapData.getMode, newMode);
    });

    test('changes campus', () {
      String newCampus = "campus";
      mapData.changeCampus(newCampus);
      expect(mapData.getCampus, newCampus);
    });

    test('changes swapTop', () {
      double newSwampTop = 2486.0;
      mapData.changeSwapTop(newSwampTop);
      expect(mapData.swapButtonTop, newSwampTop);
    });

    test('changes locationTop', () {
      double newLocationTop = 7139.0;
      mapData.changeLocationTop(newLocationTop);
      expect(mapData.locationButtonTop, newLocationTop);
    });

    test('changes currentLocation', () {
      LatLng latLng = new LatLng(90.0, 160.0);
      mapData.changeCurrentLocation(latLng);
      expect(mapData.getCurrentLocation, isA<LatLng>());
      expect(mapData.getCurrentLocation.latitude, latLng.latitude);
      expect(mapData.getCurrentLocation.longitude, latLng.longitude);
    });

    test('changes end', () {
      LatLng latLng = new LatLng(-90.0, -160.0);
      mapData.changeEnd(latLng);
      expect(mapData.getEnd, isA<LatLng>());
      expect(mapData.getEnd.latitude, latLng.latitude);
      expect(mapData.getEnd.longitude, latLng.longitude);
    });

    test('changes start', () {
      LatLng latLng = new LatLng(10, 20);
      mapData.changeStart(latLng);
      expect(mapData.getStart, isA<LatLng>());
      expect(mapData.getStart.latitude, latLng.latitude);
      expect(mapData.getStart.longitude, latLng.longitude);
    });

    test('setItinerary() sets start as current location if start is null', () {
      LatLng currentLocation = new LatLng(-12.0, 34.0);
      mapData.changeCurrentLocation(currentLocation);
      mapData.changeStart(null);
      mapData.setItinerary();
      expect(mapData.getStart, currentLocation);
    });

    test('removeItinerary() sets intinerary to null', () {
      mapData.removeItinerary();
      expect(mapData.itinerary, null);
    });

  });
}
