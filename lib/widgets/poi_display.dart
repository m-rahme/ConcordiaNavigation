import 'package:concordia_navigation/models/outdoor_poi/outdoor_poi.dart';
import "package:flutter/material.dart";

class POI_Display extends StatelessWidget {

  POI_Display({this.campus, this.snapshot});

  final String campus;
  final AsyncSnapshot<List<OutdoorPOI>> snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if(snapshot.data[index].getCampus()== campus)
          return Card(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
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
                    RaisedButton(
                      child: Text("Get Directions"),
                    )
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

                        )
                    ),
                  ],
                ),
              ],
            ),
          );
        else
          return Container();
      },
      itemCount: snapshot.data.length,
    );
  }
}
