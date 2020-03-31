import 'package:flutter/foundation.dart';

class OutdoorPOI {
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
  final String campus;
  final String title;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String logo;
  final String description;
  final String open;
  final String close;
}
