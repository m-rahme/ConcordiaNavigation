import 'package:concordia_navigation/models/indoor/classroom.dart';
import 'package:concordia_navigation/models/indoor/indoor_poi.dart';

class Floor {
  int floorNumber;

  // TODO: one set of IndoorLocation and use polymorphism
  Set<Classroom> classrooms = {};
  Set<IndoorPOI> indoorPois = {};

  Floor.fromJson(Map json) {
    this.floorNumber = int.parse(json['number']);

    for (int i = 0; i < json['classrooms'].length; i++)
      classrooms.add(Classroom.fromJson(json['classrooms'][i]));

    for (int i = 0; i < json['classrooms'].length; i++)
      indoorPois.add(IndoorPOI.fromJson(json['classrooms'][i]));
  }
}
