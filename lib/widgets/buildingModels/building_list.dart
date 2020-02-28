import 'dart:io';
import 'building_information.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class BuildingList {


  final List <BuildingInformation> buildingList = [

    BuildingInformation(
        campusName: "Loyola",
        buildingName: "Adminitration Building",
        buildingInitial: "AD",
        buildingAddress:  "7141 Sherbrooke W.",
        latitude: 45.45827,
        longitude: -73.63945,
    ),

    BuildingInformation(
        campusName: "SGW Campus",
        buildingName: "J.W. McConnell Building",
        buildingInitial: "lb",
        buildingAddress:  "1400 De Maisonneuve Blvd. W.",
        latitude: 45.497111,
        longitude: -73.578028,
    ),

  ];


  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/loyola_campus_buildings_info.txt');
  }

  void readBuildingFile(){
    Future<String> future = loadAsset();
    future.then((value) => organizeStringToList(value));
  }

  void organizeStringToList(String value){
    List<String> valueHolder = [];
    String holder='';
    for(int i = 0; i< value.length; i++){
      if(value[i]=='\n' || value[i] == ',') {
        valueHolder.add(holder);
        holder = '';
      }
      else{
        holder+=value[i];
      }
    }
    print(valueHolder.length);
    for(int i=0; i<valueHolder.length; i++){
      print(valueHolder.elementAt(i));
    }
    createBuilding(valueHolder);
  }

  void createBuilding(List<String> info){
    BuildingInformation buildingInformation = BuildingInformation(
      campusName: "Loyola",
      buildingInitial: info.elementAt(5),
      latitude: double.parse(info.elementAt(6)),
      longitude: double.parse(info.elementAt(7)),
      buildingName: info.elementAt(8),
      buildingAddress:  info.elementAt(9),
    );

    addToBuildingList(buildingInformation);
  }

  void addToBuildingList(BuildingInformation building){
    buildingList.add(building);
    print('building added');
  }

  List<BuildingInformation> getListOfBuildings(){
    return buildingList;
  }


}