import 'package:flutter/foundation.dart';

class BuildingInformation {

  String campusName;
  String buildingName;
  String buildingInitial;
  String buildingAddress;
  double latitude;
  double longitude;

  BuildingInformation({
    @required this.campusName,
    @required this.buildingName,
    @required this.buildingInitial,
    @required this.buildingAddress,
    @required this.latitude,
    @required this.longitude,
  } );

  String getCampusName(){
    return campusName;
  }

  String getBuildingName(){
    return buildingName;
  }

  String getBuildingInitial(){
    return buildingInitial;
  }

  String getBuildingAddress(){
    return buildingAddress;
  }

  double getLatitude(){
    return latitude;
  }

  double getLongitude(){
    return longitude;
  }

}