import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:concordia_navigation/models/building.dart';

class BuildingList {
  final Set<Building> buildingList = Set<Building>();
  static Map<String, dynamic> buildingInfo;

  BuildingList() {_readBuildingFile();}

  static Future<Map<String, dynamic>> loadAsset() async {
    return json.decode(await rootBundle.loadString('assets/campus_buildings_info.json'));
  }

  void _readBuildingFile() async {
    for(int campus = 0; campus< buildingInfo.keys.length; campus++){
      for(int attribute = 0; attribute< buildingInfo[buildingInfo.keys.elementAt(campus)].keys.length; attribute++){
        this.buildingList.add(
            Building(
                campusName: buildingInfo.keys.elementAt(campus),
                buildingName: buildingInfo[buildingInfo.keys.elementAt(campus)][buildingInfo[buildingInfo.keys.elementAt(campus)].keys.elementAt(attribute)]['buildingName'],
                buildingInitial: buildingInfo[buildingInfo.keys.elementAt(campus)][buildingInfo[buildingInfo.keys.elementAt(campus)].keys.elementAt(attribute)]['buildingInitial'],
                buildingAddress: buildingInfo[buildingInfo.keys.elementAt(campus)][buildingInfo[buildingInfo.keys.elementAt(campus)].keys.elementAt(attribute)]['buildingAddress'],
                latitude: double.parse(buildingInfo[buildingInfo.keys.elementAt(campus)][buildingInfo[buildingInfo.keys.elementAt(campus)].keys.elementAt(attribute)]['latitude']),
                longitude: double.parse(buildingInfo[buildingInfo.keys.elementAt(campus)][buildingInfo[buildingInfo.keys.elementAt(campus)].keys.elementAt(attribute)]['longitude']),
                filename: buildingInfo[buildingInfo.keys.elementAt(campus)][buildingInfo[buildingInfo.keys.elementAt(campus)].keys.elementAt(attribute)]['Logo'],
            )
        );
      }
    }
  }

  Set<Building> getListOfBuildings() {
    return buildingList;
  }
}
