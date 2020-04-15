import '../models/outdoor/campus.dart';
import '../models/outdoor/outdoor_poi.dart';
import '../services/search.dart';
import '../storage/app_constants.dart';
import '../widgets/outdoor/outdoor_interest_widget.dart';
import 'package:flutter/material.dart';
import '../services/localization.dart';

//Outdoor Interests Page
// ignore: must_be_immutable
class OutdoorInterest extends StatelessWidget {
  List<OutdoorPOI> sgwList;
  List<OutdoorPOI> loyList;

  @override
  Widget build(BuildContext context) {
    sgwList = Search.supported
        .where((object) =>
            object is OutdoorPOI && (object.parent as Campus).initials == "SGW")
        .toList()
        .cast<OutdoorPOI>();

    loyList = Search.supported
        .where((object) =>
            object is OutdoorPOI && (object.parent as Campus).initials == "LOY")
        .toList()
        .cast<OutdoorPOI>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            tooltip: "Back",
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(ConcordiaLocalizations.of(context).interest),
          backgroundColor: appColor,
          bottom: TabBar(
            tabs: [
              Tab(key: Key("SGWTab"), text: "Sir George Williams"),
              Tab(key: Key("LoyolaTab"), text: "Loyola"),
            ],
          ),
        ),
        body: TabBarView(children: [
          OutdoorInterestWidget(sgwList),
          OutdoorInterestWidget(loyList)
        ]),
      ),
    );
  }
}
