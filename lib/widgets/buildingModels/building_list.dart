import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:concordia_navigation/widgets/buildingModels/building_information.dart';

class BuildingList {
//-------class members----------------------
  final List<BuildingInformation> buildingList = [];

  BuildingList();
//-------class methods----------------------
  ///For reading the file
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/campus_buildings_info.txt');
  }

  ///Send String value to be organized
  void readBuildingFile() async {
    Future<String> future = loadAsset();
    future.then((value) => organizeStringToList(value));
  }

  ///Parse String into elements and add to list
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

  ///Create a BuildingInformation for each consecutive 6 elements
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

  ///Add building to list
  void addToBuildingList(BuildingInformation building) {
    buildingList.add(building);
  }

  ///Return list
  List<BuildingInformation> getListOfBuildings() {
    return buildingList;
  }
}
