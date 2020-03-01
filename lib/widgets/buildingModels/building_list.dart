import 'building_information.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class BuildingList {
//-------class members----------------------
  final List<BuildingInformation> buildingList = [];

  BuildingList();
//-------class methods----------------------
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/campus_buildings_info.txt');
  }

  void readBuildingFile() async {
    Future<String> future = loadAsset();
    future.then((value) => organizeStringToList(value));
  }

  void organizeStringToList(String value) {
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
    createBuilding(valueHolder);
  }

  void createBuilding(List<String> info) {
    for (int i = 0; i < info.length; i += 6) {
      BuildingInformation buildingInformation = BuildingInformation(
        campusName: info.elementAt(i),
        buildingInitial: info.elementAt(i + 1),
        latitude: double.parse(info.elementAt(i + 2)),
        longitude: double.parse(info.elementAt(i + 3)),
        buildingName: info.elementAt(i + 4),
        buildingAddress: info.elementAt(i + 5),
      );
      addToBuildingList(buildingInformation);
    }
  }

  void addToBuildingList(BuildingInformation building) {
    buildingList.add(building);
  }

  List<BuildingInformation> getListOfBuildings() {
    return buildingList;
  }
}