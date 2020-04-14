import 'dart:io';

import 'package:concordia_navigation/models/indoor/classroom.dart';
import 'package:concordia_navigation/models/indoor/indoor_poi.dart';
import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:concordia_navigation/models/outdoor/university.dart';
import 'package:concordia_navigation/services/search.dart';
import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<String> getDirections(
    HttpClient client, final LatLng start, final LatLng end,
    {String mode = "driving"}) async {
  Response response = await get(
      'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&mode=$mode&key=AIzaSyBHXKzGZEeBhP_m3QQ6vpI0hRODxeeEWl0');
  return response.body;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  List json;
//  List<Reachable> supportedDestinations;
  // HttpClient client = new HttpClient();
  // String mapsUrl = 'maps.googleapis.com/maps/api/directions/json';
  // Random rnd;

  setUpAll(() async {
    // rnd = Random();
    json = await University.loadJson();
    University.fromJson(json);
    // supportedDestinations =
    //     IndoorLocation.supported + OutdoorLocation.supported;
  });

  test(
      'All supported locations have a .toLatLng() function that does not return null',
      () {
    bool test =
        Search.supported.every((reachable) => reachable.toLatLng() != null);
    expect(test, true);
  });

  // test('random supported locations can generate an outdoor itinerary',
  //     () async {
  //   int rStart = rnd.nextInt(supportedDestinations.length);
  //   int rDest = rnd.nextInt(supportedDestinations.length);
  //   Reachable oStart = supportedDestinations[rStart];
  //   Reachable oDest = supportedDestinations[rDest];
  //   String itinerary = await getDirections(
  //       client, oStart.toLatLng(), oDest.toLatLng(),
  //       mode: "driving");

  //   expect(itinerary, isNotNull);
  // });

  test('getting a building', () {
    dynamic result = Search.query('Henry');
    expect(result, isA<Building>());
  });

  test('getting a classroom', () {
    dynamic result = Search.query('H820');
    expect(result, isA<Classroom>());
  });

  test('getting an indoor poi', () {
    dynamic result = Search.query('H1women');
    expect(result, isA<IndoorPOI>());
  });

  test('try to get an unsupported location', () {
    dynamic result = Search.query('invalid_location');
    expect(result, isNull);
  });
}
