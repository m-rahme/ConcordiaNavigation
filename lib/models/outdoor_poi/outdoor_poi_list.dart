import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class OutdoorPOIList{

  OutdoorPOIList({
    @required this.filename
});

  final String filename;

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
}