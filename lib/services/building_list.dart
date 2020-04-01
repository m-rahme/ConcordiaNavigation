import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:concordia_navigation/models/building.dart';
class BuildingList {
  final Set<Building> buildingList = Set<Building>();
  static List<dynamic> buildingInfo;
  BuildingList() {
    _readBuildingFile();
  }
  static Future<List<dynamic>> loadAsset() async {
    return json.decode(
        await rootBundle.loadString('assets/campus_buildings_info.json'));
  }
  void _readBuildingFile() async {
    for (int campusIndex = 0;
    campusIndex < BuildingList.buildingInfo.length;
    campusIndex++) {

      for (int buildingIndex = 0;
      buildingIndex <
          BuildingList.buildingInfo[campusIndex]['buildings'].length;
      buildingIndex++) {
        Map<String, dynamic> building =
        BuildingList.buildingInfo[campusIndex]['buildings'][buildingIndex];
        this.buildingList.add(Building(
          campusName: buildingInfo[campusIndex]['campusIndexName'],
          buildingName: building['buildingName'],
          buildingInitial: building['buildingInitial'],
          buildingAddress: building['buildingAddress'],
          latitude: double.parse(building['latitude']),
          longitude: double.parse(building['longitude']),
          filename: building['filename'],
        ));
      }
    }
  }
  Set<Building> getListOfBuildings() {
    return buildingList;
  }
}