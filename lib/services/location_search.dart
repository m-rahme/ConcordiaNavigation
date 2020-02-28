import 'dart:async';

import 'package:concordia_navigation/models/itinerary.dart';
import 'package:concordia_navigation/models/supported_destination.dart';
import 'package:concordia_navigation/models/transportation_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:concordia_navigation/models/map_data.dart';

class LocationSearch extends SearchDelegate {
  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: <Widget>[
        Consumer<MapData>(
          builder: (context, mapData, child) {
            return ListTile(
              leading: Icon(Icons.location_city),
              title: Text("SGW Campus, Montreal"),
              subtitle: Text("Quebec, Canada"),
              onTap: () async {
                // mapData.animateTo(45.496676, -73.578760);
                Provider.of<MapData>(context, listen: false)
                    .controllerDestination
                    .text = "SGW Campus, Montreal";
                Provider.of<MapData>(context, listen: false)
                    .controllerStaring
                    .text = "Current Location";
                print("Setting itinerary to LOYOLA!!");
                Provider.of<MapData>(context, listen: false)
                    .setItinerary(SupportedDestination.SGW);
                Navigator.of(context).pop();
              },
            );
          },
        ),
        Consumer<MapData>(
          builder: (context, mapData, child) {
            print(1);
            return ListTile(
              leading: Icon(Icons.location_city),
              title: Text("Loyola Campus, Montreal"),
              subtitle: Text("Quebec, Canada"),
              onTap: () async {
                Provider.of<MapData>(context, listen: false)
                    .controllerDestination
                    .text = "Loyola Campus, Montreal";
                Provider.of<MapData>(context, listen: false)
                    .controllerStaring
                    .text = "Current Location";
//                mapData.animateTo(45.4582, -73.6405);
                Provider.of<MapData>(context, listen: false)
                    .setItinerary(SupportedDestination.LOYOLA);
                print("Setting itinerary to LOYOLA!!");
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ],
    );
  }

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

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }
}
