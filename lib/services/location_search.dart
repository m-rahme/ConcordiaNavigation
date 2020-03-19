import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:concordia_navigation/providers/map_data.dart';

/*This class extends Search Delegate class implemented by flutter.
It will be called when the user clicks on the search button in the Appbar.
*/
class LocationSearch extends SearchDelegate {
  final classRooms = ['H101', 'H102', 'H103', 'JMSB300', 'H903'];
  final recentRooms = ['H102', 'H103', 'H101'];

  ///This method returns suggested locations to the user, in this case Loyola and SGW campus.
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentRooms
        : classRooms.where((p) => p.startsWith(query.toUpperCase())).toList();
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
          Provider.of<MapData>(context, listen: false).changeCampus('sgw');
          Provider.of<MapData>(context, listen: false).changeEnd(constants.sgw);
          Provider.of<MapData>(context, listen: false).changeMode("driving");
          Provider.of<MapData>(context, listen: false).setItinerary();
          Provider.of<MapData>(context, listen: false).setDrawer(true);
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
//    return ListView(
//      children: <Widget>[
//        Consumer<MapData>(
//          ///Wrapped in Consumer, listening to Provider **ConcreteObserver**
//          builder: (context, mapData, child) {
//            return ListTile(
//              leading: Icon(Icons.location_city),
//              title: Text("SGW Campus, Montreal"),
//              subtitle: Text("Quebec, Canada"),
//              onTap: () async {
//                Provider.of<MapData>(context, listen: false)
//                    .controllerDestination
//                    .text = "SGW Campus, Montreal";
//                Provider.of<MapData>(context, listen: false)
//                    .controllerStarting
//                    .text = "Current Location";
//                Navigator.of(context).pop();
//                mapData.controllerDestination.text = "SGW, Montreal";
//                mapData.controllerStarting.text = "Current Location";
//                mapData.changeStart(mapData.getCurrentLocation);
//                mapData.changeCampus('sgw');
//                mapData.changeEnd(sgw);
//                mapData.changeMode("driving");
//                mapData.setItinerary();
//                Provider.of<MapData>(context, listen: false).setDrawer(true);
//              },
//            );
//          },
//        ),
//        Consumer<MapData>(
//          ///Wrapped in Consumer, listening to Provider **ConcreteObserver**
//          builder: (context, mapData, child) {
//            return ListTile(
//              leading: Icon(Icons.location_city),
//              title: Text("Loyola Campus, Montreal"),
//              subtitle: Text("Quebec, Canada"),
//              onTap: () {
//                Navigator.of(context).pop();
//                mapData.controllerDestination.text = "Loyola Campus, Montreal";
//                mapData.controllerStarting.text = "Current Location";
//                mapData.changeStart(mapData.getCurrentLocation);
//                mapData.changeCampus('loyola');
//                mapData.changeEnd(loyola);
//                mapData.changeMode("driving");
//                mapData.setItinerary();
//                Navigator.pushNamed(context, '/directions');
//              },
//            );
//          },
//        ),
//      ],
//    );
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
