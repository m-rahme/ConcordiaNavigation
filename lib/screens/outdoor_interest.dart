import 'package:concordia_navigation/models/outdoor_poi.dart';
import 'package:concordia_navigation/services/outdoor_poi_list.dart';
import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:concordia_navigation/widgets/outdoor_interest_widget.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';

//Outdoor Interests Page
class OutdoorInterest extends StatelessWidget {
  List<OutdoorPOI> sgwList;
  List<OutdoorPOI> loyolaList;

  @override
  Widget build(BuildContext context) {
    sgwList = OutdoorPOIList.fromJson(OutdoorPOIList.poi[0]).pointOfInterests;
    loyolaList =
        OutdoorPOIList.fromJson(OutdoorPOIList.poi[1]).pointOfInterests;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(ConcordiaLocalizations.of(context).interest),
          backgroundColor: appColor,
          bottom: TabBar(
            tabs: [
              Tab(text: "Sir George Williams"),
              Tab(text: "Loyola"),
            ],
          ),
        ),
        body: TabBarView(children: [
          OutdoorInterestWidget(sgwList),
          OutdoorInterestWidget(loyolaList)
        ]),
      ),
    );
  }
}
