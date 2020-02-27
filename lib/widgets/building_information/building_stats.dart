import 'package:flutter/foundation.dart';

class BuildingStatistics {

  String building_initial;
  String building_name;
  String campus_name;
  String building_address;
  double lat;
  double long;
  String op_hrs;

  BuildingStatistics({
    @required this.building_initial,
    @required this.building_name,
    @required this.campus_name,
    @required this.lat,
    @required this.long,
    @required this.building_address,
    this.op_hrs
});



}