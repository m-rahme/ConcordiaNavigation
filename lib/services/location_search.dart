import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

/*This class extends Search Delegate class implemented by flutter.
It will be called when the user clicks on the search button in the Appbar.
*/
class LocationSearch extends SearchDelegate {
  List<dynamic> classrooms;
  final recentRooms = [
    'HALL BUILDING',
    'H837',
    'MB1.437'
  ]; // for demonstration purposes

  void getClassrooms() async {
    classrooms =
        json.decode(await rootBundle.loadString('assets/destinations.json'));
  }

  ///This method returns suggested locations to the user, in this case Loyola and SGW campus.
  @override
  Widget buildSuggestions(BuildContext context) {
    getClassrooms();

    final suggestionList = query.isEmpty
        ? recentRooms
        : classrooms.where((p) => p.contains(query.toUpperCase())).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () async {
          Provider.of<MapData>(context, listen: false)
              .controllerDestination
              .text = "SGW Campus, Montreal";
          Provider.of<MapData>(context, listen: false).controllerStarting.text =
              "Current Location";
          Navigator.of(context).pop();
          Provider.of<MapData>(context, listen: false)
              .controllerDestination
              .text = "SGW, Montreal";
          Provider.of<MapData>(context, listen: false).controllerStarting.text =
              "Current Location";
          Provider.of<MapData>(context, listen: false).changeStart(
              Provider.of<MapData>(context, listen: false).getCurrentLocation);
          switch (suggestionList[index][0].toString()) {
            case "H":
              {
                Provider.of<MapData>(context, listen: false)
                    .changeCampus('sgw');
                Provider.of<MapData>(context, listen: false)
                    .changeEnd(constants.hBuilding);
              }
              break;

            case "M":
              {
                Provider.of<MapData>(context, listen: false)
                    .changeCampus('sgw');
                Provider.of<MapData>(context, listen: false)
                    .changeEnd(constants.jmsbBuilding);
              }
              break;

            case "L":
              {
                Provider.of<MapData>(context, listen: false)
                    .changeCampus('loyola');
                Provider.of<MapData>(context, listen: false)
                    .changeEnd(constants.loyola);
              }
              break;

            case "J":
              {
                Provider.of<MapData>(context, listen: false)
                    .changeCampus('sgw');
                Provider.of<MapData>(context, listen: false)
                    .changeEnd(constants.jmsbBuilding);
              }
              break;

            default:
              {
                Provider.of<MapData>(context, listen: false)
                    .changeCampus('sgw');
                Provider.of<MapData>(context, listen: false)
                    .changeEnd(constants.sgw);
              }
              break;
          }
          Provider.of<MapData>(context, listen: false).changeMode("driving");
          Provider.of<MapData>(context, listen: false).setItinerary();
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
