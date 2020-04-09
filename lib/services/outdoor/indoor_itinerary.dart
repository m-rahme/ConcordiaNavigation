import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/node.dart';
import 'package:concordia_navigation/services/dijkstra.dart';
import 'package:concordia_navigation/services/search.dart';

class IndoorItinerary {
  List<IndoorLocation> path = [];
  List<Node> nodePath = [];

  IndoorItinerary(String start, String end) {
    nodePath = Dijkstra.shortest.pathTo(start, end);
    nodePath.forEach((node) {
      IndoorLocation temp = Search.query(node.name);
      path.add(temp);
    });
  }
}
