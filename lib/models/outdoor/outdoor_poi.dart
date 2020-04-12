import 'package:concordia_navigation/models/outdoor/outdoor_location.dart';

class OutdoorPOI extends OutdoorLocation {
  String logo;
  String description;
  String open;
  String close;

  OutdoorPOI(String name, String address, this.logo,
      {OutdoorLocation parent, this.description, this.open, this.close})
      : super(name, address: address, parent: parent);

  OutdoorPOI._fromJson(Map<String, dynamic> json, {OutdoorLocation parent})
      : logo = json['Logo'],
        description = json['Description'],
        open = json['Open'],
        close = json['Close'],
        super(json['Name'],
            address: json['Address'],
            latitude: json['LAT'],
            longitude: json['LNG'], parent: parent);

  factory OutdoorPOI.fromJson(
      Map<String, dynamic> json, {OutdoorLocation parent}) {
    if (parent == null ||
        json['Name'] == null ||
        json['Address'] == null ||
        json['Logo'] == null)
      return null;
    else
      return OutdoorPOI._fromJson(json, parent: parent);
  }
}
