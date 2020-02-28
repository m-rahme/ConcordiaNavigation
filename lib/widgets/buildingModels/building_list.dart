import 'building_information.dart';

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

  List<BuildingInformation> getListOfBuildings(){
    return buildingList;
  }


}