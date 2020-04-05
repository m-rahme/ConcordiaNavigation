/*
import 'package:concordia_navigation/providers/buildings_data.dart';
import 'package:concordia_navigation/storage/campus_buildings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BuildingsData', () {
    BuildingsData buildingsData;

    setUpAll(() {
      buildingsData = new BuildingsData();
    });

    test(
        'constructor creates set of Buildings with same size as buildings in CampusPolygons',
        () {
      expect(buildingsData.buildings.length, CampusBuildings.buildings.length);
    });

    test(
        'constructor creates set of Polygons with same size as its set of Buildings',
        () {
      expect(buildingsData.polygons.length, buildingsData.buildings.length);
    });

    test('visibility set to false returns non-empty set', () {
      buildingsData.clearOutlines();
      expect(buildingsData.polygons.length, 0);
    });

    test('visibility set to true returns empty set', () {
      buildingsData.showOutlines();
      expect(buildingsData.polygons.length, isNonZero);
    });
  });
}

*/