import 'package:concordia_navigation/models/coordinate.dart';

class IndoorInterest {
  final String name;
  final Coordinate roomCoordinates;
  final Coordinate nearestCoordinates;
  IndoorInterest({this.name, this.roomCoordinates, this.nearestCoordinates});
}
