import 'package:flutter/foundation.dart';

class BuildingInformation {

  BuildingInformation({
    @required this.campusName,
    @required this.buildingName,
    @required this.buildingInitial,
    @required this.buildingAddress,
    @required this.latitude,
    @required this.longitude,
    @required this.filename,
  } );

  final String campusName;
  final String buildingName;
  final String buildingInitial;
  final String buildingAddress;
  final double latitude;
  final double longitude;
  final String filename;

  String getCampusName(){return campusName;}
  String getBuildingName(){return buildingName;}
  String getBuildingInitial(){return buildingInitial;}
  String getBuildingAddress(){return buildingAddress;}
  double getLatitude(){return latitude;}
  double getLongitude(){return longitude;}
  String getFilename(){return filename;}

}