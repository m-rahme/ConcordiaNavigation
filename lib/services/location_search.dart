import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/outdoor/outdoor_location.dart';
import 'package:concordia_navigation/models/uni_location.dart';
import 'package:concordia_navigation/providers/indoor_data.dart';
import 'package:concordia_navigation/screens/indoor_page.dart';
import 'package:concordia_navigation/services/search.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:concordia_navigation/providers/map_data.dart';

/// Shows the user a list of possible locations, parses inputs and submits them to
/// MapData + IndoorData providers for itinerary generation
class LocationSearch extends SearchDelegate {
  final bool isFirst;

  LocationSearch(this.isFirst);

  ///This method returns suggested locations to the user, in this case Loyola and SGW campus.
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> emptyList = [];

    // is selecting start location
    if (isFirst) {
      // only start location can have current location as a choice
      emptyList.add('Current Location');
    }

    // add all available classrooms/buildings in both cases
    emptyList.addAll(Search.names.take(10).toList());

    // list containing all available suggestions to the user
    final suggestionList = query.isEmpty
        ? emptyList
        : Search.names.where((p) => p.contains(query.toUpperCase())).toList();

    return Consumer<MapData>(builder: (context, mapData, child) {
      return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          key: Key("Location" + index.toString()),
          onTap: () async {
            // search for element they tapped
            dynamic result = Search.query(suggestionList[index]);

            // reset any previous itinerary as user is searching for something else
            mapData.itinerary = null;

            if (isFirst) {
              // choosing start
              // start and end are the same
              if (result == mapData.end) {
                // reset end and set start
                mapData.end = null;
                Provider.of<IndoorData>(context, listen: false)
                    .removeItinerary();
              }
              mapData.start = result;
            } else {
              // choosing end
              // start and end are the same
              if (result == mapData.start) {
                // reset start and set end
                mapData.start = null;
                Provider.of<IndoorData>(context, listen: false)
                    .removeItinerary();
              }
              mapData.end = result;
            }

            if (suggestionList[index] == 'Current Location') {
              if (isFirst) {
                mapData.controllerStarting = 'Current Location';
              }
            }

            // go back to map
            Navigator.of(context).pop();

            // current location + some destination
            if (mapData.controllerStarting == 'Current Location' &&
                mapData.end != null) {
              if (mapData.end is IndoorLocation) {
                // letter representing the building
                String letter =
                    (mapData.end as IndoorLocation).parent.parent.name[0];
                String indoor = letter == 'H' ? 'H1entrance' : 'MBentrance';
                Provider.of<IndoorData>(context, listen: false).setItinerary(
                    start: indoor, end: (mapData.end as IndoorLocation).name);
              }
              mapData.setItinerary();
            }

            // start is not current location and end is not null
            if (mapData.start != null && mapData.end != null) {
              if (mapData.start is OutdoorLocation &&
                  mapData.end is OutdoorLocation) {
                mapData.setItinerary();
              } else if (mapData.start
                      is IndoorLocation && // start and end are both indoor locations
                  mapData.end is IndoorLocation) {
                // This will check if buildings are the same, no need to worry
                mapData.setItinerary();
                Provider.of<IndoorData>(context, listen: false).setItinerary(
                    start: (mapData.start as IndoorLocation).name,
                    end: (mapData.end as IndoorLocation).name);

                // go to indoor page
                Navigator.pushNamed(context, '/indoor',
                    arguments: Arguments(true));
              } else {
                OutdoorLocation selected = mapData.start is IndoorLocation
                    ? mapData.end
                    : mapData.start;

                // letter of building
                String letter =
                    (selected.parent as OutdoorLocation).parent.name[0];
                String indoor = letter == 'H' ? 'H1entrance' : 'MBentrance';
                Provider.of<IndoorData>(context, listen: false).setItinerary(
                    start: selected == mapData.start
                        ? indoor
                        : (mapData.start as UniLocation).name,
                    end: selected == mapData.end
                        ? indoor
                        : (mapData.end as UniLocation).name);
                mapData.setItinerary();
              }
            }
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
