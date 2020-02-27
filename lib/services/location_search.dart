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
              onTap: () {
                Navigator.of(context).pop();
                mapData.animateTo(45.496676, -73.578760);
              },
            );
          },
        ),
        Consumer<MapData>(
          builder: (context, mapData, child) {
            return ListTile(
              leading: Icon(Icons.location_city),
              title: Text("Loyola Campus, Montreal"),
              subtitle: Text("Quebec, Canada"),
              onTap: () {
                Navigator.of(context).pop();
                Provider.of<MapData>(context, listen: false)
                    .controllerDestination
                    .text = "Loyola Campus, Montreal";
                Provider.of<MapData>(context, listen: false)
                    .controllerStaring
                    .text = "Current Location";
                Navigator.pushNamed(context, '/directions');
//                mapData.animateTo(45.4582, -73.6405);
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
