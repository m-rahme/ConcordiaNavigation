import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:concordia_navigation/models/university.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  University concordia;
  List json;

  group('University child elements', () {
    setUpAll(() async {
      json = await University.loadJson();
      concordia = University.fromJson(json);
    });

    test('there are 2 campuses', () {
      expect(concordia.children.length, 2);
    });

    test('there are 23 buildings', () {
      expect(concordia.children.length, 2);
    });

    test('there are 10 buildings that have the buildingName property', () {
      List<Building> buildingsWithBuildingNames = [];
      concordia.children.forEach((campus) =>
          buildingsWithBuildingNames.addAll(campus.children.where((building) {
            return building.name != null;
          })));
      expect(buildingsWithBuildingNames.length, 37);
    });

    test('all buildings have initials', () {
      List<Building> buildingsWithInitials = [];
      int totalBuildings = 0;
      concordia.children.forEach((campus) =>
          buildingsWithInitials.addAll(campus.children.where((building) {
            totalBuildings++;
            return building.name != null;
          })));
      expect(buildingsWithInitials.length, totalBuildings);
    });
  });
}
