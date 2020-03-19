import 'package:flutter/foundation.dart';

class OutdoorPOI{

  OutdoorPOI({
    @required this.campus,
    @required this.title,
    @required this.name,
    @required this.latitude,
    @required this.longitude,
    this.description,
    this.open,
    this.close
});
  final String campus;
  final String title;
  final String name;
  final double latitude;
  final double longitude;
  final String description;
  final String open;
  final String close;

  String getCampus(){return campus;}
  String getTitle(){return title;}
  String getName(){return name;}
  double getLat(){return latitude;}
  double getLong(){return longitude;}
  String getDescription(){return description;}
  String getOpen(){return open;}
  String getClose(){return close;}
}