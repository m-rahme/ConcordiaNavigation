import 'package:concordia_navigation/models/outdoor_poi/outdoor_poi.dart';
import 'package:concordia_navigation/models/outdoor_poi/outdoor_poi_list.dart';
import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';

//Outdoor Interests Page
class OutdoorInterest extends StatelessWidget {
  static const routeName = '/o_interest';

  final OutdoorPOIList x = OutdoorPOIList();

  Future<List<OutdoorPOI>> callAsyncFetch() {
    return Future.delayed(Duration(seconds: 2), () => x.readPOIFile());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(ConcordiaLocalizations.of(context).interest),
        backgroundColor: greenColor),
      body: FutureBuilder(
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot<List<OutdoorPOI>> snapshot){
          if(snapshot.hasData){
            return Text(snapshot.data.elementAt(0).getName());
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
