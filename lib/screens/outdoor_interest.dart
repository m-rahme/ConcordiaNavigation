import 'package:concordia_navigation/models/outdoor_poi/outdoor_poi.dart';
import 'package:concordia_navigation/models/outdoor_poi/outdoor_poi_list.dart';
import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';

//Outdoor Interests Page
class OutdoorInterest extends StatelessWidget {
  static const routeName = '/o_interest';

  final OutdoorPOIList outdoorPOIList = OutdoorPOIList();

  Future<List<OutdoorPOI>> callAsyncFetch() {
    return Future.delayed(Duration(seconds: 2), () => outdoorPOIList.readPOIFile());
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
            return Container(

              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text(
                            snapshot.data[index].getName(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),

                          Text(
                            snapshot.data[index].getAddress(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),

                          Text(
                            "Open: " +snapshot.data[index].getOpen() + " Close: "+snapshot.data[index].getClose(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),

                        ],

                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[

                          Container(
                              decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2),),
                              child: new Image.asset(
                                snapshot.data[index].getLogo(),
                                height: 80.0,
                                fit: BoxFit.cover,

                              )
                          ),

                        ],
                      ),

                    ],
                    ),
                  );
                },
                itemCount: snapshot.data.length,
              ),
            );
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
