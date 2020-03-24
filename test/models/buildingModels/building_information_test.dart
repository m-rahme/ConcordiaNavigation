import 'package:concordia_navigation/models/buildingModels/building_information.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BuildingInformation', () {
    test('constructor creates BuildingInformation', () {
      BuildingInformation buildingInformation = new BuildingInformation(
        campusName: "campusName",
        buildingName: "buildingName",
        buildingInitial: "buildingInitial",
        buildingAddress: "buildingAddress",
        latitude: 90.0,
        longitude: 180.0,
        filename: 'filename',
      );
     
      expect(buildingInformation.getCampusName(), "campusName");
      expect(buildingInformation.getBuildingName(), "buildingName");
      expect(buildingInformation.getBuildingInitial(), "buildingInitial");
      expect(buildingInformation.getBuildingAddress(), "buildingAddress");
      expect(buildingInformation.getLatitude(), 90.0);
      expect(buildingInformation.getLongitude(), 180.0);
    });
  });
}
