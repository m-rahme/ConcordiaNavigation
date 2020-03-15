import 'dart:convert';
import 'package:concordia_navigation/services/directions_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//This class is used to generate an an Itinerary from the direction's JSON.
class Itinerary {
  ///Safety making sure the itinerary is generated only once.
  LatLng _startDestination;
  LatLng _endDestination;
  String _mode;
  Map<String, Map<String, String>> _itinerary;
  List<Polyline> _polylines;

  Itinerary._create();

  List<Polyline> get polylines => _polylines;

  Map<String, Map<String, String>> get itinerary => _itinerary;

  static Future<Itinerary> create(
      LatLng startDestination, LatLng endDestination, String mode) async {
    Itinerary itinerary = Itinerary._create();

    String rawData = await DirectionsService.getDirections(
        startDestination, endDestination,
        mode: mode);
    Map<String, dynamic> rawJson = json.decode(rawData);
    itinerary._polylines = getPolylinePoints(rawJson);
    itinerary._itinerary = getDirectionList(rawJson);

    return itinerary;
  }

  ///Parses the JSON returned by the Google API so we can build our route on screen, then returns the recommended routes
  static Map<String, Map<String, String>> getDirectionList(
      Map<String, dynamic> rawJson) {
    // Requests the directions from Google API, in directions_service
    //JSON contains all recommended routes, any transportation mode changes, and how many steps in the directions.
    Map<String, Map<String, String>> temp = Map<String, Map<String, String>>();
    var steps = rawJson["routes"][0]["legs"][0]["steps"].length;
    for (int i = 0; i < steps; i++) {
      String s1 = rawJson["routes"][0]["legs"][0]["steps"][i]
              ["html_instructions"]
          .replaceAll(
              //Regex to replace certain special characters in HTML with whitespace
              RegExp(r'(<\/?\w+\/?>?| \w+=\"\w+-\w+:\d.\d\w+\">)'),
              ' ');
      String s2 =
          rawJson["routes"][0]["legs"][0]["steps"][i]["duration"]["text"];
      String s3 =
          rawJson["routes"][0]["legs"][0]["steps"][i]["distance"]["text"];
      temp.addAll({
        s1: {s2: s3}
      });
    }
    return temp;
  }

  static List<Polyline> getPolylinePoints(Map<String, dynamic> rawJson) {
    PolylinePoints tPolylinePoints = PolylinePoints();
    List<PointLatLng> tPointLatLng = [];
    List<Polyline> tPolyline = [];

    double sLat = rawJson['routes'][0]['legs'][0]['start_location']['lat'];
    double sLong = rawJson['routes'][0]['legs'][0]['start_location']['long'];
    double eLat = rawJson['routes'][0]['legs'][0]['end_location']['lat'];
    double eLong = rawJson['routes'][0]['legs'][0]['end_location']['long'];

    String sDesc = rawJson['routes'][0]['legs'][0]['start_address'];
    String eDesc = rawJson['routes'][0]['legs'][0]['end_address'];

    var steps = rawJson['routes'][0]['legs'][0]['steps'];

    for (int i = 0; i < steps.length; i++) {
      dynamic directions = steps[i]["polyline"]["points"];
      List<PointLatLng> temp = tPolylinePoints.decodePolyline(directions);
      tPointLatLng = new List.from(tPointLatLng)..addAll(temp);
    }
    List<LatLng> po = [];
    tPointLatLng.forEach((f) {
      po.add(LatLng(f.latitude, f.longitude));
    });

    Polyline route = new Polyline(
      polylineId: PolylineId("route"),
      geodesic: true,
      points: po,
      width: 5,
      color: Colors.blue,
    );

    tPolyline.add(route);
    return tPolyline;
  }
}
