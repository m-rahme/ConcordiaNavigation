import 'package:concordia_navigation/models/classroom.dart';
import 'package:concordia_navigation/models/indoor_interest.dart';

class Floor {
  int floorNumber;

  // TODO: one set of IndoorLocation and use polymorphism
  Set<Classroom> classrooms = {};
  Set<IndoorInterest> indoorInterests = {};

  Floor.fromJson(Map json) {
    this.floorNumber = int.parse(json['number']);

    for (int i = 0; i < json['classrooms'].length; i++)
      classrooms.add(Classroom.fromJson(json['classrooms'][i]));

    for (int i = 0; i < json['classrooms'].length; i++)
      indoorInterests.add(IndoorInterest.fromJson(json['classrooms'][i]));
  }
}
