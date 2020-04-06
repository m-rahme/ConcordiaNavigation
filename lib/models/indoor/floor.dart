import 'package:concordia_navigation/models/indoor/classroom.dart';
import 'package:concordia_navigation/models/indoor/indoor_poi.dart';
import 'package:concordia_navigation/providers/indoor_data.dart';

class Floor {
  int floorNumber;

  // TODO: one set of IndoorLocation and use polymorphism
  Set<Classroom> classrooms = {};
  Set<IndoorPOI> indoorPois = {};

  Floor.fromJson(Map json) : assert(json['number'] != null) {
    this.floorNumber = int.parse(json['number']);

    for (int i = 0; i < json['classrooms'].length; i++) {
      // fromJson() will ALWAYS turn an instance of Classroom (even when null parameters)
      // consider using a factory constructor instead
      Classroom tempC = Classroom.fromJson(json['classrooms'][i]);
      if (tempC.name != null) {
        classrooms.add(tempC);
        IndoorData.indoors[tempC.name] = tempC;
      }
    }

    for (int i = 0; i < json['poi'].length; i++) {
      IndoorPOI tempI = IndoorPOI.fromJson(json['poi'][i]);
      if (tempI.name != null) {
        indoorPois.add(tempI);
        IndoorData.indoors[tempI.name] = tempI;
      }
    }
  }
}
