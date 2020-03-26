import 'package:flutter/services.dart';
import 'package:concordia_navigation/models/outdoor_poi/outdoor_poi.dart';
import 'dart:convert';

class OutdoorPOIList{

  final String filename = 'assets/pointsofinterest.json';

  OutdoorPOIList();

  List<OutdoorPOI> pointOfInterests = List<OutdoorPOI>();


  Future<List<OutdoorPOI>> readPOIFile() async {
    /**
     * Examples to access elements the pointsofinterest.json file
     *
     * poi['loyola']['loyolapark']['Name'];
     * returns loyola park
     *
     * poi.keys.elementAt(0);
     * returns loyola
     *
     * poi.keys.length;
     * returns number of campuses
     *
     * poi['loyola'].keys;
     * returns loyolapark, souvlakigeorge, ndghotdog, comptoirkoyajo
     *
     * poi['loyola'].keys.length;
     * returns number of POIs of the campus
     *
     * poi['loyola'].keys.elementAt(2);
     * returns ndghotdog
     *
     * poi['loyola']['loyolapark'].keys.length;
     * returns number of attributes
     *
     * poi['loyola']['loyolapark'].keys.elementAt(0);
     *  returns {Name: Loyola Park}
     *
     * poi['loyola']['loyolapark'].keys.elementAt(1);
     * returns {LAT: 45.4608841}
     *
     */
    Map<String, dynamic> poi =  json.decode(await rootBundle.loadString(filename));

    for(int campus = 0; campus< poi.keys.length; campus++){
      for(int location = 0; location< poi[poi.keys.elementAt(campus)].keys.length; location++){
          this.pointOfInterests.add(
              OutdoorPOI(
                  campus: poi.keys.elementAt(campus).toString(),
                  title: poi[poi.keys.elementAt(campus)].keys.elementAt(location).toString(),
                  name: poi[poi.keys.elementAt(campus)][poi[poi.keys.elementAt(campus)].keys.elementAt(location)]['Name'],
                  address: poi[poi.keys.elementAt(campus)][poi[poi.keys.elementAt(campus)].keys.elementAt(location)]['Address'],
                  latitude: double.parse(poi[poi.keys.elementAt(campus)][poi[poi.keys.elementAt(campus)].keys.elementAt(location)]['LAT']),
                  longitude: double.parse(poi[poi.keys.elementAt(campus)][poi[poi.keys.elementAt(campus)].keys.elementAt(location)]['LNG']),
                  logo: poi[poi.keys.elementAt(campus)][poi[poi.keys.elementAt(campus)].keys.elementAt(location)]['Logo'],
                  description: poi[poi.keys.elementAt(campus)][poi[poi.keys.elementAt(campus)].keys.elementAt(location)]['Description'],
                  open: poi[poi.keys.elementAt(campus)][poi[poi.keys.elementAt(campus)].keys.elementAt(location)]['Open'],
                  close: poi[poi.keys.elementAt(campus)][poi[poi.keys.elementAt(campus)].keys.elementAt(location)]['Close']
                  )
          );
      }
    }
    return pointOfInterests;

  }

}