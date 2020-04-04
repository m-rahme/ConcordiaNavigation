import 'package:concordia_navigation/models/outdoor_poi.dart';
import 'package:concordia_navigation/services/outdoor_poi_list.dart';
import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:concordia_navigation/widgets/outdoor_interest_widget.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';

//Outdoor Interests Page
class OutdoorInterest extends StatelessWidget {
  final OutdoorPOIList outdoorPOIList = OutdoorPOIList();

  Future<List<OutdoorPOI>> callAsyncFetch() {
    return outdoorPOIList.readPOIFile();
  }

  @override
  Widget build(BuildContext context) {
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
        body: FutureBuilder(
            future: callAsyncFetch(),
            builder: (context, AsyncSnapshot<List<OutdoorPOI>> snapshot) {
              if (snapshot.hasData) {
                return TabBarView(
                  children: [
                    new OutdoorInterestWidget(
                      snapshot: snapshot,
                      campus: "Sir George Williams",
                    ),
                    new OutdoorInterestWidget(
                      snapshot: snapshot,
                      campus: "Loyola",
                    ),
                  ],
                );
              } else
                return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
