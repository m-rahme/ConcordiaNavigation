import 'package:concordia_navigation/models/classroom.dart';
import 'package:concordia_navigation/models/indoor_interest.dart';

class Floor {
  final int floorNumber;
  final Set<Classroom> classrooms;
  final Set<IndoorInterest> indoorInterests;
  Floor({this.floorNumber, this.classrooms, this.indoorInterests});
}
