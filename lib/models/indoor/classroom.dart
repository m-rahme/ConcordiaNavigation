import 'floor.dart';
import 'indoor_location.dart';
/// Model for an indoor classroom
class Classroom extends IndoorLocation {
  // classroom floor information
  Classroom.fromJson(json, Floor parent) : super.fromJson(json, parent: parent);
}
