import 'package:concordia_navigation/services/building_list.dart';
import 'package:flutter/services.dart' show AssetBundle, rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBuildingList extends Mock implements BuildingList {}

class MockAssetBundle extends Mock implements AssetBundle {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('BuildingList', () {
    test(
        'readBuildingFile() creates list of BuildingInformation with the same length as the asset file.',
        () async {
      BuildingList.buildingInfo = await BuildingList.loadJson();
      BuildingList buildingList = new BuildingList();

      int dynSum = 0;
      BuildingList.buildingInfo.forEach((element) {
        dynSum += element['buildings'].length;
      });
      int numOfBuildings = buildingList.getListOfBuildings().length;
      expect(dynSum, numOfBuildings);

      expect(dynSum, numOfBuildings);
    });
  });
}
