import 'outdoor_location.dart';

/// Model class of an outdoor point of interest
/// Concrete OutdoorLocation
/// Represents a point of interest close to, or in, a campus

class OutdoorPOI extends OutdoorLocation {
  String logo;
  String description;
  // Open and closing hours
  String open;
  String close;

  // Public constructor of an outdoor point of interest
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
            longitude: json['LNG'],
            parent: parent);

  /// Factory constructor method for outdoor point of interest from reading a json file
  factory OutdoorPOI.fromJson(Map<String, dynamic> json,
      {OutdoorLocation parent}) {
    if (parent == null ||
        json['Name'] == null ||
        json['Address'] == null ||
        json['Logo'] == null) {
      return null;
    } else {
      return OutdoorPOI._fromJson(json, parent: parent);
    }
  }
}
