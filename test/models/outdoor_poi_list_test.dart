import 'package:concordia_navigation/services/outdoor_poi_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  OutdoorPOIList loyolaList;
  OutdoorPOIList sgwList;

  group("OutdoorPOIList", () {
    TestWidgetsFlutterBinding.ensureInitialized();

    setUp(() async {
      OutdoorPOIList.poi = await OutdoorPOIList.loadJson();
      sgwList = OutdoorPOIList.fromJson(OutdoorPOIList.poi[0]);
      loyolaList = OutdoorPOIList.fromJson(OutdoorPOIList.poi[1]);
    });

    test('fromJson() on SGW data has correct number of POI', () {
      expect(sgwList.pointOfInterests.length, OutdoorPOIList.poi[0]["interests"].length);
    });

    test('fromJson() on Loyola data has correct number of POI',
        () {
      expect(loyolaList.pointOfInterests.length, OutdoorPOIList.poi[1]["interests"].length);
    });
  });
}
