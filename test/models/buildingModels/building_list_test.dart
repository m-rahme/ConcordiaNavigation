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
      BuildingList.buildingInfo = await BuildingList.loadAsset();

      BuildingList buildingList = new BuildingList();

      // Get number of lines from source

      int loyolaBuidings = BuildingList.buildingInfo['Loyola'].length;
      int sgwBuildings = BuildingList.buildingInfo['Sir George Williams'].length;

      int numOfBuildings = buildingList.getListOfBuildings().length;


      expect(loyolaBuidings + sgwBuildings, numOfBuildings);
    });
  });
}
