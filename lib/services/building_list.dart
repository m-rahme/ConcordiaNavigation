import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:concordia_navigation/models/building.dart';

class BuildingList {
//-------class members----------------------
  final Set<Building> buildingList = Set<Building>();
  static String buildingInfo;

  BuildingList() {
    _readBuildingFile();
  }
//-------class methods----------------------
  ///For reading the file
  static Future<String> loadJson() async =>
      await rootBundle.loadString('assets/campus_buildings_info.txt');

  ///Send String value to be organized
  void _readBuildingFile() async {
    _organizeStringToList(buildingInfo);
  }

  ///Parse String into elements and add to list
  void _organizeStringToList(String value) {
    List<String> valueHolder = [];
    String holder = '';
    for (int i = 0; i < value.length; i++) {
      if (value[i] == '\n' || value[i] == ':') {
        valueHolder.add(holder);
        holder = '';
      } else {
        holder += value[i];
      }
    }
    _createBuilding(valueHolder);
  }

  ///Create a BuildingInformation for each consecutive 6 elements
  void _createBuilding(List<String> info) {
    for (int i = 0; i < info.length; i += 7) {
      Building buildingInformation = Building(
        campusName: info.elementAt(i),
        buildingInitial: info.elementAt(i + 1),
        latitude: double.parse(info.elementAt(i + 2)),
        longitude: double.parse(info.elementAt(i + 3)),
        buildingName: info.elementAt(i + 4),
        buildingAddress: info.elementAt(i + 5),
        filename: info.elementAt(i + 6),
      );
      _addToBuildingList(buildingInformation);
    }
  }

  ///Add building to list
  void _addToBuildingList(Building building) {
    buildingList.add(building);
  }

  ///Return list
  Set<Building> getListOfBuildings() {
    return buildingList;
  }
}
