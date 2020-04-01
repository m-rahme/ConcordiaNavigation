import 'package:concordia_navigation/models/coordinate.dart';

class Classroom {
  final int classroomNumber;
  final Coordinate classroomCoordinates;
  final Coordinate nearestCoordinates;
  Classroom(
      {this.classroomNumber,
      this.classroomCoordinates,
      this.nearestCoordinates});
}
