import 'package:concordia_navigation/models/node.dart';
import 'package:concordia_navigation/services/dijkstra.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Dijkstra', () {
    Map<String, Node> nodes;
    Dijkstra dijkstra;
    List<Node> result;

    setUp(() {
      // Mock data
      Node n1 = Node("n1", {});
      Node n2 = Node("n2", {n1: 50});
      Node n3 = Node("n3", {n1: 10, n2: 5});
      Node n4 = Node("n4", {n2: 500, n3: 1});
      Node n5 = Node("n5", {n1: 2, n3: 1});
      Node n6 = Node("n6", {n5: 1, n4: 5});

      nodes = {
        "n1": n1,
        "n2": n2,
        "n3": n3,
        "n4": n4,
        "n5": n5,
        "n6": n6,
      };

      dijkstra = Dijkstra.fromGraph(nodes);

      result = [n1, n5, n6];
    });

    test('constructor creates a list of edges', () {
      List<Node> other = dijkstra.getPath("n1", "n6");
      expect(result, other);
    });
  });
}
