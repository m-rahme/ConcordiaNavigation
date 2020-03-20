import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:concordia_navigation/services/localization.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

/*This class extends Search Delegate class implemented by flutter.
It will be called when the user clicks on the search button in the Appbar.
*/
class LocationSearch extends SearchDelegate {
  List<dynamic> classrooms;

  void getClassrooms() async {
    classrooms =
        json.decode(await rootBundle.loadString('assets/destinations.json'));
  }

  ///This method returns suggested locations to the user, in this case Loyola and SGW campus.
  @override
  Widget buildSuggestions(BuildContext context) {
    getClassrooms();
    final suggestionList = query.isEmpty
        ? [ConcordiaLocalizations.of(context).hallBuilding.toUpperCase(), 'H837', 'MB1.437'] // demo purposes
        : classrooms.where((p) => p.contains(query.toUpperCase())).toList();
    return Consumer<MapData>(builder: (context, mapData, child) {
      return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () async {
            mapData.controllerDestination.text =
                ConcordiaLocalizations.of(context).sgwCampus;
            mapData.controllerStarting.text =
                ConcordiaLocalizations.of(context).currentLocation;
            Navigator.of(context).pop();
            mapData.controllerStarting.text =
                ConcordiaLocalizations.of(context).currentLocation;
            mapData.changeStart(mapData.getCurrentLocation);
            switch (suggestionList[index][0].toString()) {
              case "H":
                {
                  if (suggestionList[index][1].toString() == "A") {
                    mapData.changeCampus('sgw');
                    mapData.controllerDestination.text =
                        ConcordiaLocalizations.of(context).hallBuilding;
                    mapData.changeEnd(constants.hBuilding);
                  } else {
                    mapData.changeCampus('sgw');
                    mapData.controllerDestination.text =
                        suggestionList[index].toString();
                    mapData.changeEnd(constants.hBuilding);
                  }
                }
                break;

              case "M":
                {
                  mapData.changeCampus('sgw');
                  mapData.controllerDestination.text =
                      suggestionList[index].toString();
                  mapData.changeEnd(constants.jmsbBuilding);
                }
                break;

              case "L":
                {
                  mapData.changeCampus('loyola');
                  mapData.controllerDestination.text =
                      ConcordiaLocalizations.of(context).loyolaCampus;
                  mapData.changeEnd(constants.loyola);
                }
                break;

              case "J":
                {
                  mapData.changeCampus('sgw');
                  mapData.controllerDestination.text =
                      ConcordiaLocalizations.of(context).jmsbBuilding;
                  mapData.changeEnd(constants.jmsbBuilding);
                }
                break;

              default:
                {
                  mapData.changeCampus('sgw');
                  mapData.controllerDestination.text =
                      ConcordiaLocalizations.of(context).sgwCampus;
                  mapData.changeEnd(constants.sgw);
                }
                break;
            }
            mapData.changeMode("driving");
            mapData.setItinerary();
          },
          leading: Icon(Icons.location_city),
          title: RichText(
              text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: TextStyle(
                      color: constants.blackColor, fontWeight: FontWeight.bold),
                  children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(
                    color: constants.greyColor,
                  ),
                ),
              ])),
        ),
        itemCount: suggestionList.length,
      );
    });
  }

  ///This method adds a return IconButton to return to the homepage.
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  ///This method add the a clear IconButton to clear user's input.
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  ///This method returns results from user input.
  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }
}
