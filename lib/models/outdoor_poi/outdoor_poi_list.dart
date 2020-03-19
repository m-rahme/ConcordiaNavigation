import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:concordia_navigation/models/outdoor_poi/outdoor_poi.dart';

class OutdoorPOIList{

  OutdoorPOIList({
    @required this.filename
});

  final String filename;
  List<OutdoorPOI> outdoorList = List<OutdoorPOI>();

  Future<String> loadAsset() async {
    return await rootBundle.loadString(filename);
  }

  void readPOIFile() async {
    Future<String> future = loadAsset();
    future.then((value) => organizeElements(value));
  }

  ///Parse String into elements and add to list
  void organizeElements(String value) {

  }

  List<OutdoorPOI> getOutdoorList(){
    return outdoorList;
  }


}