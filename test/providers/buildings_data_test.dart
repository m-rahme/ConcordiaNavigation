import 'package:concordia_navigation/models/outdoor/university.dart';
import 'package:concordia_navigation/providers/buildings_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('BuildingsData', () {
    BuildingsData buildingsData;

    setUpAll(() async {
      List<dynamic> data = await University.loadJson();
      University.concordia = University.fromJson(data);
      buildingsData = new BuildingsData();
    });
    test(
        'constructor creates set of Polygons with same size as its set of Buildings',
        () {
      expect(buildingsData.allPolygons.length, buildingsData.allBuildings.length);
    });

    test('visibility set to false returns non-empty set', () {
      buildingsData.toggleOutline();
      expect(buildingsData.allPolygons.length, 0);
    });

    test('visibility set to true returns empty set', () {
      buildingsData.toggleOutline();
      expect(buildingsData.allPolygons.length, isNonZero);
    });
  });
}
