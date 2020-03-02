import 'package:concordia_navigation/providers/buildings_data.dart';
import 'package:concordia_navigation/storage/campus_buildings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BuildingsData', () {
    BuildingsData buildingsData;

    setUpAll(() async {
      buildingsData = new BuildingsData();
    });

    test(
        'BuildingsData creates set of Buildings with same size as buildings in CampusPolygons.',
        () {
      expect(buildingsData.buildings.length, CampusBuildings.buildings.length);
    });

    test(
        'BuildingsData creates set of Polygons with same size as its set of Buildings.',
        () {
      expect(buildingsData.polygons.length, buildingsData.buildings.length);
    });

    test('BuildingsData set to false returns empty set', () {
      buildingsData.clearOutlines();
      expect(buildingsData.polygons.length, 0);
    });

    test('BuildingsData set to true returns empty set', () {
      buildingsData.showOutlines();
      expect(buildingsData.polygons.length, isNonZero);
    });
  });
}
