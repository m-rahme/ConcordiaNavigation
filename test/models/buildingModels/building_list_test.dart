import 'package:concordia_navigation/models/buildingModels/building_list.dart';
import 'package:flutter/services.dart' show AssetBundle, rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBuildingList extends Mock implements BuildingList{}
class MockAssetBundle extends Mock implements AssetBundle{}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('BuildingList', () {
    test('readBuildingFile() creates list of BuildingInformation with the same length as the asset file.', () async {
      
      // Build list
      BuildingList buildingList = new BuildingList();
      await buildingList.readBuildingFile();

      // Get number of lines from source
      String file = await rootBundle.loadString('assets/campus_buildings_info.txt');
      String linebreak = '\n';
      int numLines = linebreak.allMatches(file).length;

      // Compare lengths
      expect(buildingList.getListOfBuildings().length, numLines);
    });
  });
}