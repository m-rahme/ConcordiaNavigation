import 'dart:async';

import 'package:concordia_navigation/services/building_list.dart';
import 'package:concordia_navigation/services/itinerary.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/services/directions_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import '../app_widget.dart';

class MockMapData extends Mock implements MapData {
  String controllerStarting = "";
  String controllerDestination = "";
  Itinerary itinerary;

}

class MockDirectionsService extends Mock implements DirectionsService {}

void main() {

  setUp(() async {
    BuildingList.buildingInfo = await BuildingList.loadJson();
  });
  group('DirectionsDrawer', () {
    testWidgets('creates drawer', (WidgetTester tester) async {
      String rawData =
          r'''{"geocoded_waypoints":[{"geocoder_status":"OK","place_id":"ChIJpZSbXmwayUwRE0iVoyTk9Es","types":["street_address"]},{"geocoder_status":"OK","place_id":"ChIJny06l0obyUwRxFH8k_YfSQA","types":["establishment","point_of_interest"]}],"routes":[{"bounds":{"northeast":{"lat":45.5019462,"lng":-73.5701854},"southwest":{"lat":45.50161,"lng":-73.57091079999999}},"copyrights":"Mapdata©2020Google","legs":[{"distance":{"text":"68m","value":68},"duration":{"text":"1min","value":47},"end_address":"730RueCathcart,Montréal,QCH3B5G9,Canada","end_location":{"lat":45.50161,"lng":-73.5701854},"start_address":"770RueSainte-CatherineO,Montréal,QCH3H1M6,Canada","start_location":{"lat":45.5019462,"lng":-73.57091079999999},"steps":[{"distance":{"text":"68m","value":68},"duration":{"text":"1min","value":47},"end_location":{"lat":45.50161,"lng":-73.5701854},"html_instructions":"Head\u003cb\u003esoutheast\u003c/b\u003eon\u003cb\u003eAvenueMcGillCollege\u003c/b\u003etoward\u003cb\u003eRueCathcart\u003c/b\u003e\u003cdivstyle=\"font-size:0.9em\"\u003eDestinationwillbeontheleft\u003c/div\u003e","polyline":{"points":"ebvtGdi``M`@gAVq@HU"},"start_location":{"lat":45.5019462,"lng":-73.57091079999999},"travel_mode":"WALKING"}],"traffic_speed_entry":[],"via_waypoint":[]}],"overview_polyline":{"points":"ebvtGdi``MbAoC"},"summary":"AvenueMcGillCollege","warnings":["Walkingdirectionsareinbeta.Usecaution–Thisroutemaybemissingpavementsorpedestrianpaths."],"waypoint_order":[]}],"status":"OK"}''';

      MockDirectionsService directionsService = new MockDirectionsService();
      when(directionsService.getDirections(any, any, mode: anyNamed("mode")))
          .thenAnswer((_) => Future.value(rawData));
      when(directionsService.getDirections(any, any))
          .thenAnswer((_) => Future.value(rawData));

      Itinerary itinerary = await Itinerary.create(
          LatLng(90, 90), LatLng(90, 90), "walking", directionsService);
      MockMapData mockMapData = new MockMapData();
      mockMapData.itinerary = itinerary;
      when(mockMapData.setItinerary()).thenAnswer((_) {
        mockMapData.itinerary = itinerary;
        mockMapData.notifyListeners();
      });

      await tester.pumpWidget(appWidget(mapData: mockMapData));
      await tester.pumpAndSettle();

      final search = find.byKey(Key("LocationSearch"));
      expect(search, findsWidgets);
      await tester.tap(search);
      await tester.pumpAndSettle();

      final cityIcon = find.byIcon(Icons.location_city);
      expect(cityIcon, findsWidgets);
    });
  });
}

