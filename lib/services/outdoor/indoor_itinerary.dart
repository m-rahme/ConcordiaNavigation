import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/node.dart';
import 'package:concordia_navigation/services/dijkstra.dart';
import 'package:concordia_navigation/services/search.dart';

class IndoorItinerary {
  List<IndoorLocation> path = [];
  List<Node> _nodePath = [];

  IndoorItinerary(String start, String end) {
    _nodePath = Dijkstra.shortest.pathTo(start, end);
    _nodePath.forEach((node) {
      IndoorLocation temp = Search.query(node.name);
      path.add(temp);
    });
  }

  @override
  String toString() {
    String container = "";
    this.path.forEach((location) => container += " " + location.name);
    return container;
  }
}
