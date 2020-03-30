import 'package:concordia_navigation/models/course.dart';
import 'package:concordia_navigation/providers/calendar_data.dart';
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

    //TODO: make it clear that the first item is from the users calendar
    CalendarData calendar = Provider.of<CalendarData>(context, listen: false);
    List<Course> nextClasses = calendar.schedule?.nextClasses(days: 7);
    if (nextClasses != null && nextClasses.isNotEmpty && nextClasses.first.filteredLocation() != "N/A") {
      var next = nextClasses.first.filteredLocation() + " [CAL]";
      // Avoid duplicates on widget rebuild
      if (!suggestionList.contains(next)) {
        suggestionList.insert(0, next);
      }
    }

    return Consumer<MapData>(builder: (context, mapData, child) {
      return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () async {
            mapData.controllerDestination = "SGW Campus, Montreal";
            mapData.controllerStarting = "Current Location";
            Navigator.of(context).pop();
            mapData.controllerStarting = "Current Location";
            mapData.changeStart(mapData.getCurrentLocation);
            switch (suggestionList[index][0].toString()) {
              case "H":
                {
                  if (suggestionList[index][1].toString() == "A") {
                    mapData.changeCampus('sgw');
                    mapData.controllerDestination = "Hall Building, Montreal";
                    mapData.changeEnd(constants.hBuilding);
                  } else {
                    mapData.changeCampus('sgw');
                    mapData.controllerDestination =
                        suggestionList[index].toString();
                    mapData.changeEnd(constants.hBuilding);
                  }
                }
                break;

              case "M":
                {
                  mapData.changeCampus('sgw');
                  mapData.controllerDestination =
                      suggestionList[index].toString();
                  mapData.changeEnd(constants.jmsbBuilding);
                }
                break;

              case "L":
                {
                  mapData.changeCampus('loyola');
                  mapData.controllerDestination = "Loyola Campus, Montreal";
                  mapData.changeEnd(constants.loyola);
                }
                break;

              case "J":
                {
                  mapData.changeCampus('sgw');
                  mapData.controllerDestination =
                      "John Molson Business, Montreal";
                  mapData.changeEnd(constants.jmsbBuilding);
                }
                break;
              case "F":
                {
                  mapData.changeCampus('sgw');
                  mapData.controllerDestination = "FG Building, Montreal";
                  mapData.changeEnd(constants.fgBuilding);
                }
                break;

              default:
                {
                  mapData.changeCampus('sgw');
                  mapData.controllerDestination = "SGW Campus, Montreal";
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
