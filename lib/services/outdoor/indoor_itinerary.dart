import '../../models/indoor/indoor_location.dart';
import '../../models/node.dart';
import '../dijkstra.dart';
import '../search.dart';

class IndoorItinerary {
  List<IndoorLocation> path = [];
  List<Node> _nodePath = [];
  final bool accessible;

  IndoorItinerary(String start, String end, {this.accessible = false}) {
    _nodePath = Dijkstra.shortest.pathTo(start, end, accessible: accessible);
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
