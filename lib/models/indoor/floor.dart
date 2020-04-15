import '../outdoor/building.dart';
import 'classroom.dart';
import 'indoor_location.dart';
import 'indoor_poi.dart';


/// Model class for indoor floors
class Floor extends IndoorLocation {
  final int page;
  Floor(String name, Building parent, this.page) : super(name, parent: parent);
  /// Factory design pattern to create a floor from json file
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
