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

  /// Create the Itinerary object and populate its fields from json data.
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

  /// Returns a Map of instructions obtained by parsing a json object from Google's Directions API.
  /// 
  /// The format is the following:
  /// ```
  /// {
  ///   Summary of instruction 1 : {duration, distance},
  ///   Summary of instruction 2 : {duration, distance},
  ///   ...
  /// }
  /// ```
  /// 
  /// Sample output:
  /// ```
  /// {
  ///   Head west on Rue Sainte-Catherine O. toward Avenue Atwater : {5 mins: 0.2 km},
  ///   Turn left onto Avenue Atwater : {3 mins: 1.4 km},
  ///   Turn left onto Rue Tupper : {1 min: 0.7 km}, 
  ///   ...
  /// }
  /// ```
  /// Currently doesn't support subdirections.
  static Map<String, Map<String, String>> getDirectionList(
      Map<String, dynamic> rawJson) {
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

  /// Returns a list of Polylines obtained by parsing a json object from Google's Directions API.
  /// similar to [getDirectionList(Map<String, dynamic>)] but returns a list of Polyline objects instead of a Map of directions.
  static List<Polyline> getPolylinePoints(Map<String, dynamic> rawJson) {
    PolylinePoints tPolylinePoints = PolylinePoints();
    List<PointLatLng> tPointLatLng = [];
    List<Polyline> tPolyline = [];

    double sLat = rawJson['routes'][0]['legs'][0]['start_location']['lat'];
    double sLong = rawJson['routes'][0]['legs'][0]['start_location']['long'];
    String sDesc = rawJson['routes'][0]['legs'][0]['start_address'];

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
