import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:concordia_navigation/models/buildingModels/building_information.dart';

class BuildingList {
//-------class members----------------------
  final Set<BuildingInformation> buildingList = Set<BuildingInformation>();

  BuildingList(){
    _readBuildingFile();
  }
//-------class methods----------------------
  ///For reading the file
  Future<String> _loadAsset() async {
    return await rootBundle.loadString('assets/campus_buildings_info.txt');
  }

  ///Send String value to be organized
  void _readBuildingFile() async {
    Future<String> future = _loadAsset();
    future.then((value) => _organizeStringToList(value));
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
      BuildingInformation buildingInformation = BuildingInformation(
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
  void _addToBuildingList(BuildingInformation building) {
    buildingList.add(building);
  }

  ///Return list
  Set<BuildingInformation> getListOfBuildings() {
    return buildingList;
  }
}
