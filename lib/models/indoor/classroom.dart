import 'package:concordia_navigation/models/indoor/floor.dart';
import 'package:concordia_navigation/models/indoor/indoor_location.dart';

class Classroom extends IndoorLocation {
  Classroom.fromJson(json, Floor parent) : super.fromJson(json, parent: parent);
}
