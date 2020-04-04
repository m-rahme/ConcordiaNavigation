import 'package:concordia_navigation/services/building_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('BuildingList', () {
    test(
        'readBuildingFile() creates list of Buildings with the same length as the asset file.',
        () async {
      BuildingList.buildingInfo = await BuildingList.loadJson();
      BuildingList buildingList = new BuildingList();

      int dynSum = 0;
      BuildingList.buildingInfo.forEach((element) {
        dynSum += element['buildings'].length;
      });
      int numOfBuildings = buildingList.getListOfBuildings().length;
      expect(dynSum, numOfBuildings);
    });
  });
}
