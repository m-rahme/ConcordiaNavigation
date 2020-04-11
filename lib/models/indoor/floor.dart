import 'package:concordia_navigation/models/indoor/classroom.dart';
import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/indoor/indoor_poi.dart';
import 'package:concordia_navigation/models/outdoor/building.dart';

class Floor extends IndoorLocation {
  final int page;
  Floor(String name, Building parent, this.page) : super(name, parent: parent);

  factory Floor.fromJson(Building building, Map json) {
    if (json['number'] == null) return null;

    Floor f = Floor(json['number'], building, json['page']);

    List<IndoorLocation> indoors = [];
    for (int i = 0; i < json['classrooms'].length; i++) {
      Classroom tempC = Classroom.fromJson(json['classrooms'][i], f);
      if (tempC.name != null) {
        indoors.add(tempC);
      }
    }

    for (int i = 0; i < json['poi'].length; i++) {
      IndoorPOI tempI = IndoorPOI.fromJson(json['poi'][i], parent: f);
      if (tempI.name != null) {
        indoors.add(tempI);
      }
    }

    f.children = indoors;

    return f;
  }
}
