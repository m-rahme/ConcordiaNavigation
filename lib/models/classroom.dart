import 'package:concordia_navigation/models/coordinate.dart';

class Classroom {
  final String classroomNumber;
  final Coordinate classroomCoordinates;
  final Coordinate nearestCoordinates;
  Classroom(
      {this.classroomNumber,
      this.classroomCoordinates,
      this.nearestCoordinates});
}
