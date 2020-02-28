import 'package:concordia_navigation/models/custom_location.dart';
import 'package:concordia_navigation/models/direction.dart';
import 'package:concordia_navigation/models/supported_destination.dart';
import 'package:concordia_navigation/models/transportation_mode.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:concordia_navigation/services/direction_service.dart';
import 'dart:convert';

class Itinerary {
  List<Polyline> polylines = [];
  List<PointLatLng> _result = [];
  CustomLocation _start;
  CustomLocation _end;
  PolylinePoints polylinePoints = PolylinePoints();

  static Future<Itinerary> create(SupportedDestination dest,
      {String mode = "DRIVING"}) async {
    assert(dest == SupportedDestination.SGW ||
        dest == SupportedDestination.LOYOLA);
    //assert(mode == TransportationMode.DRIVING || mode == TransportationMode.TRANSIT || mode == TransportationMode.WALKING);
    LatLng temp;
    Itinerary itinerary;
    if (dest == SupportedDestination.SGW) {
      temp = LatLng(45.500090, -73.575620); // SGW
    } else {
      temp = LatLng(45.465950, -73.624720); // LOYOLA
    }
    LatLng currentLocation = await CustomLocation.getCurrentLocation();
    print(currentLocation.latitude);
    String jsonString = await DirectionsService.getDirections(
        currentLocation, temp,
        mode: "DRIVING");
    itinerary = Itinerary.fromJson(json.decode(jsonString));
    print(itinerary);
    return Future<Itinerary>.value(itinerary);
  }

  Itinerary.fromJson(dynamic json) {
    double sLat = json['routes'][0]['legs'][0]['start_location']['lat'];
    double sLong = json['routes'][0]['legs'][0]['start_location']['long'];
    double eLat = json['routes'][0]['legs'][0]['end_location']['lat'];
    double eLong = json['routes'][0]['legs'][0]['end_location']['long'];

    String sDesc = json['routes'][0]['legs'][0]['start_address'];
    String eDesc = json['routes'][0]['legs'][0]['end_address'];

    _start = CustomLocation(sLat, sLong, sDesc);
    _end = CustomLocation(eLat, eLong, eDesc);

    var steps = json['routes'][0]['legs'][0]['steps'];

    for (int i = 0; i < steps.length; i++) {
      dynamic directions = steps[i]["polyline"]["points"];
      List<PointLatLng> temp = polylinePoints.decodePolyline(directions);
      _result = new List.from(_result)..addAll(temp);
    }
    List<LatLng> po = [];
    _result.forEach((f) {
      po.add(LatLng(f.latitude, f.longitude));
    });

    Polyline route = new Polyline(
      polylineId: PolylineId("route"),
      geodesic: true,
      points: po,
      width: 5,
      color: Colors.blue,
    );

    polylines.add(route);
  }
}
