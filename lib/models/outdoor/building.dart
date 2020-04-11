import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:concordia_navigation/models/indoor/floor.dart';
import 'package:concordia_navigation/models/outdoor/campus.dart';
import 'package:concordia_navigation/models/outdoor/outdoor_location.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart' show visibleForTesting;

class Building extends OutdoorLocation {
  // generated
  Polygon _outline;
  BitmapDescriptor icon;

  // required
  String buildingInitials;
  List edges;

  // optional
  String logo;

  @visibleForTesting
  Building.forTesting(String name, double latitude, double longitude)
      : super(name, latitude: latitude, longitude: longitude);

  Building(this.buildingInitials, String name, double latitude, double longitude,
      String buildingAddress, this.edges,  this.logo, {Campus parent})
      : super(name,
              address: buildingAddress,
              latitude: latitude,
              longitude: longitude,
              parent: parent)
  {
    if(logo != null) {
      _getBytesFromAsset(logo, 350).then((uint8list) {
        icon = BitmapDescriptor.fromBytes(uint8list);
      });
    }
  }

  /// Confirm the building can have a marker
  bool hasMarker() {
    return (logo != null && icon != null);
  }

  Polygon get outline {
    if (_outline == null) {
      _outline = Polygon(
        polygonId: PolygonId(buildingInitials ?? name),
        fillColor: constants.highlightColor.withOpacity(0.7),
        consumeTapEvents: false,
        geodesic: false,
        points: edges,
        strokeWidth: 0,
      );
    }
    return _outline;
  }

  /// Load bitmap for location marker
  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  /// All buildings have edges.
  /// Not every building has markers.
  ///
  /// Therefore, some of the parameters are optional.
  /// This is an example of converse error. thanks u
  factory Building.fromJson(Campus parent, Map json) {
    if (json['buildingInitials'] == null || json['edges'] == null) return null;
    List<Floor> floors = [];
    List<LatLng> edges = [];

    for (int i = 0; i < json['edges'].length; i++) {
      double lat = json['edges'][i]['latitude'];
      double long = json['edges'][i]['longitude'];

      LatLng temp = LatLng(lat, long);
      edges.add(temp);
    }

    Building b = Building(
        json['buildingInitials'],
        json['buildingName'] ?? json['buildingInitials'], // if buildingName is set, use it
        json['latitude'],
        json['longitude'],
        json['buildingAddress'],
        edges,
        json['logo'],
        parent: parent);

    if (json['floors'] != null) {
      for (int k = 0; k < json['floors'].length; k++) {
        Floor floor = Floor.fromJson(b, json['floors'][k]);
        if (floor != null) floors.add(floor);
      }
    }

    b.children = floors;

    return b;
  }
}
