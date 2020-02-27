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
  Set<Direction> directions;
  CustomLocation _start;
  CustomLocation _end;
  PolylinePoints polylinePoints = PolylinePoints();

  Itinerary (SupportedDestination dest, TransportationMode mode) {
    assert(dest == SupportedDestination.SGW || dest == SupportedDestination.LOYOLA);
    assert(mode == TransportationMode.DRIVING || mode == TransportationMode.TRANSIT || mode == TransportationMode.WALKING);
    LatLng _end;
    if (dest == SupportedDestination.SGW) {
      _end = LatLng(45.500090, -73.575620); // SGW
    } else {
      _end = LatLng(45.465950, -73.624720); // LOYOLA
    }
    CustomLocation.getCurrentLocation()
    .then((currentLocation) => 
      DirectionsService.getDirections(currentLocation, _end, mode: mode)
      .then((jsonString) =>
        Itinerary.fromJson(json.decode(jsonString))
      )
    );
  }

  Itinerary.fromJson(dynamic json) { // if somehow we got raw json direction data
    double sLat = json['routes'][0]['legs']['start_location']['lat'];
    double sLong = json['routes'][0]['legs']['start_location']['long'];
    double eLat = json['routes'][0]['legs']['end_location']['lat'];
    double eLong = json['routes'][0]['legs']['end_location']['long'];

    String sDesc = json['routes'][0]['legs']['start_address'];
    String eDesc = json['routes'][0]['legs']['end_address'];

    _start = CustomLocation(sLat, sLong, sDesc);
    _end = CustomLocation(eLat, eLong, eDesc);

    var steps = json['route'][0]['legs']['steps'];

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