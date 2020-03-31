import 'package:concordia_navigation/models/building.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BuildingInformation', () {
    test('constructor creates BuildingInformation', () {
      Building buildingInformation = new Building(
        campusName: "campusName",
        buildingName: "buildingName",
        buildingInitial: "buildingInitial",
        buildingAddress: "buildingAddress",
        latitude: 90.0,
        longitude: 180.0,
        filename: "filename",
      );
     
      expect(buildingInformation.campusName, "campusName");
      expect(buildingInformation.buildingName, "buildingName");
      expect(buildingInformation.buildingInitial, "buildingInitial");
      expect(buildingInformation.buildingAddress, "buildingAddress");
      expect(buildingInformation.latitude, 90.0);
      expect(buildingInformation.longitude, 180.0);
      expect(buildingInformation.filename, "filename");
    });
  });
}
