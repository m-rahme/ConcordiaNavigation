import 'package:concordia_navigation/models/buildingModels/building_list.dart';
import 'package:flutter/services.dart' show AssetBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBuildingList extends Mock implements BuildingList{}
class MockAssetBundle extends Mock implements AssetBundle{}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('BuildingList', () {
    test('readBuildingFile() creates list of BuildingInformation with a specific length', () async {
      BuildingList buildingList = new BuildingList();
      await buildingList.readBuildingFile();
      expect(buildingList.getListOfBuildings().length, 10);
    });
  });
}