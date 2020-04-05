import 'package:concordia_navigation/models/coordinate.dart';

abstract class IndoorLocation {
  String name;
  Coordinate room;
  Coordinate nearest;

  IndoorLocation({this.name, this.room, this.nearest});

  IndoorLocation.fromJson(Map json)
      : room = Coordinate.fromJson(json['coordinates']['room']),
        nearest = Coordinate.fromJson(json['coordinates']['nearest']);
}
