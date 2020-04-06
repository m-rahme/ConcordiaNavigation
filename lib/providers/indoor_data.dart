import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/services/dijkstra.dart';
import 'package:flutter/material.dart';

class IndoorData extends ChangeNotifier {
  static Dijkstra shortest;

  static Map<String, IndoorLocation> indoors = {};
}
