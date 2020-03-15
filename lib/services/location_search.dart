import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:concordia_navigation/providers/map_data.dart';

/*This class extends Search Delegate class implemented by flutter.
It will be called when the user clicks on the search button in the Appbar.
*/
class LocationSearch extends SearchDelegate {
  ///This method returns suggested locations to the user, in this case Loyola and SGW campus.
  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: <Widget>[
        Consumer<MapData>(
          ///Wrapped in Consumer, listening to Provider **ConcreteObserver**
          builder: (context, mapData, child) {
            return ListTile(
              leading: Icon(Icons.location_city),
              title: Text("SGW Campus, Montreal"),
              subtitle: Text("Quebec, Canada"),
              onTap: () async {
                Provider.of<MapData>(context, listen: false)
                    .controllerDestination
                    .text = "SGW Campus, Montreal";
                Provider.of<MapData>(context, listen: false)
                    .controllerStarting
                    .text = "Current Location";
                Navigator.of(context).pop();
                mapData.controllerDestination.text = "SGW, Montreal";
                mapData.controllerStarting.text = "Current Location";
                mapData.changeStart(mapData.getCurrentLocation);
                mapData.changeCampus('sgw');
                mapData.changeEnd(sgw);
                mapData.changeMode("driving");
                mapData.setItinerary();
                Provider.of<MapData>(context, listen: false).setDrawer(true);
              },
            );
          },
        ),
        Consumer<MapData>(
          ///Wrapped in Consumer, listening to Provider **ConcreteObserver**
          builder: (context, mapData, child) {
            print(1);
            return ListTile(
              leading: Icon(Icons.location_city),
              title: Text("Loyola Campus, Montreal"),
              subtitle: Text("Quebec, Canada"),
              onTap: () {
                Navigator.of(context).pop();
                mapData.controllerDestination.text = "Loyola Campus, Montreal";
                mapData.controllerStarting.text = "Current Location";
                mapData.changeStart(mapData.getCurrentLocation);
                mapData.changeCampus('loyola');
                mapData.changeEnd(loyola);
                mapData.changeMode("driving");
                mapData.setItinerary();
                Navigator.pushNamed(context, '/directions');
              },
            );
          },
        ),
      ],
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
  ///To be implemented with Google Places.
  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }
}
