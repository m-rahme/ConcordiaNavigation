import 'package:flutter/foundation.dart';

class OutdoorPOI {
  String campus;
  String title;
  String name;
  String address;
  double latitude;
  double longitude;
  String logo;
  String description;
  String open;
  String close;

  OutdoorPOI(
      {@required this.campus,
      @required this.title,
      @required this.name,
      @required this.address,
      @required this.latitude,
      @required this.longitude,
      @required this.logo,
      this.description,
      this.open,
      this.close});

  OutdoorPOI.fromJson(this.campus, Map<String, dynamic> jsonInterest)
      : title = jsonInterest['Name'],
        name = jsonInterest['Name'],
        address = jsonInterest['Address'],
        logo = jsonInterest['Logo'],
        latitude = double.parse(jsonInterest['LAT']),
        longitude = double.parse(jsonInterest['LNG']),
        description = jsonInterest['Description'],
        open = jsonInterest['Open'],
        close = jsonInterest['Close'];
}
