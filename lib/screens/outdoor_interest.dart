import 'package:concordia_navigation/models/outdoor_poi/outdoor_poi.dart';
import 'package:concordia_navigation/models/outdoor_poi/outdoor_poi_list.dart';
import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';

//Outdoor Interests Page
class OutdoorInterest extends StatelessWidget {
  static const routeName = '/o_interest';

  List<OutdoorPOI> outdoorPOIList = (new OutdoorPOIList()).getOutdoorList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ConcordiaLocalizations.of(context).interest,
        ),
        backgroundColor: greenColor,
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
      return Card(
        child: Row(children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15) ,
            decoration: BoxDecoration(border: Border.all(color: Colors.purple, width: 2),),
            padding: EdgeInsets.all(10),
            child:
            Text(
              '\$${outdoorPOIList[index].name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.purple,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                outdoorPOIList[index].title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Text('placeholder',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],),
        ],
        ),
      );
    },
    itemCount: outdoorPOIList.length,
    ),
    );
  }
}
