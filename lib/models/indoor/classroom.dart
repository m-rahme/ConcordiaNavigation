import 'package:concordia_navigation/models/indoor/floor.dart';
import 'package:concordia_navigation/models/indoor/indoor_location.dart';
/// Model for an indoor classroom
class Classroom extends IndoorLocation {
  // classroom floor information
  Classroom.fromJson(json, Floor parent) : super.fromJson(json, parent: parent);
}
