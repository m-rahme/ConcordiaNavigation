import 'package:concordia_navigation/models/outdoor/outdoor_poi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("OutdoorPOI", () {
    test("fromJson() constructor of OutdoorPOI fed good data", () {
      OutdoorPOI good = OutdoorPOI.fromJson({
        "Name": "Loyola Park",
        "Address": "4877 Avenue Doherty",
        "LAT": "45.4608841",
        "LNG": "-73.6458944",
        "Description": "",
        "Open": "8:00",
        "Close": "23:00",
        "Logo": "assets/poi_images/park.png"
      });

      expect(good, isA<OutdoorPOI>());
    });

    test("fromJson() constructor of OutdoorPOI fed a bad longitude value", () {
      Map<String, dynamic> badLat = {
        "Name": "Loyola Park",
        "Address": "4877 Avenue Doherty",
        "LAT": "BAD_VALUE",
        "LNG": "-73.6458944",
        "Description": "",
        "Open": "8:00",
        "Close": "23:00",
        "Logo": "assets/poi_images/park.png"
      };

      expect(OutdoorPOI.fromJson(badLat), isA<FormatException>());
    });

    test("fromJson() missing an optional parameter", () {
      Map<String, dynamic> noDesc = {
        "Name": "Loyola Park",
        "Address": "4877 Avenue Doherty",
        "LAT": "45.4608841",
        "LNG": "-73.6458944",
        "Open": "8:00",
        "Close": "23:00",
        "Logo": "assets/poi_images/park.png"
      };

      expect(OutdoorPOI.fromJson(noDesc), isA<OutdoorPOI>());
    });
  });
}
