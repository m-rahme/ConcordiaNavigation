import 'dart:convert';

import 'package:concordia_navigation/models/outdoor/campus.dart';
import 'package:concordia_navigation/models/outdoor/outdoor_location.dart';
import 'package:flutter/services.dart';

class University extends OutdoorLocation {
  University._create(String name) : super(name);
  static University concordia;

  factory University.fromJson(List json) {
    if (json == null) return null;
    List<Campus> campuses = [];

    University u = University._create("concordia");
    for (Map c in json) {
      Campus campus = Campus.fromJson(c, parent: u);
      campuses.add(campus);
    }

    u.children = campuses;

    return u;
  }

  ///For reading the file
  static Future<List<dynamic>> loadJson() async => json
      .decode(await rootBundle.loadString('assets/json/campus_buildings.json'));
}
