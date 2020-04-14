import 'package:concordia_navigation/models/indoor/node.dart';
import 'package:concordia_navigation/services/indoor/dijkstra.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Dijkstra', () {
    Map<String, Node> nodes;
    Dijkstra dijkstra;
    List<Node> solution;
    Node n1;
    Node n2;
    Node n3;
    Node n4;
    Node n5;
    Node n6;

    setUp(() {
      // Mock data
      n1 = Node("n1");
      n2 = Node("n2");
      n3 = Node("n3");
      n4 = Node("n4");
      n5 = Node("n5");
      n6 = Node("n6");

      n1.setEdge(n2, 50);
      n1.setEdge(n3, 10);
      n1.setEdge(n5, 2);
      n2.setEdge(n1, 50);
      n2.setEdge(n3, 5);
      n2.setEdge(n4, 500);
      n3.setEdge(n1, 10);
      n3.setEdge(n2, 5);
      n3.setEdge(n4, 1);
      n3.setEdge(n5, 1);
      n4.setEdge(n2, 500);
      n4.setEdge(n3, 1);
      n4.setEdge(n6, 5);
      n5.setEdge(n1, 2);
      n5.setEdge(n3, 1);
      n5.setEdge(n6, 1);
      n6.setEdge(n4, 5);
      n6.setEdge(n5, 1);

      nodes = {
        "n1": n1,
        "n2": n2,
        "n3": n3,
        "n4": n4,
        "n5": n5,
        "n6": n6,
      };

      dijkstra = Dijkstra.fromGraph(nodes);
    });

    test('find shortest path between n1 and n6', () {
      solution = [n1, n5, n6];
      List<Node> result = dijkstra.pathTo("n1", "n6");
      expect(solution, result);
    });

    test('find shortest path between n1 and n4', () {
      solution = [n1, n5, n3, n4];
      List<Node> result = dijkstra.pathTo("n1", "n4");
      expect(solution, result);
    });

    test('find shortest path between n1 and n2', () {
      solution = [n1, n5, n3, n2];
      List<Node> result = dijkstra.pathTo("n1", "n2");
      expect(solution, result);
    });

    test('find shortest path between n2 and n6', () {
      solution = [n2, n3, n5, n6];
      List<Node> result = dijkstra.pathTo("n2", "n6");
      expect(solution, result);
    });

    test('find shortest path between n2 and n4', () {
      solution = [n2, n3, n4];
      List<Node> result = dijkstra.pathTo("n2", "n4");
      expect(solution, result);
    });

    test('find shortest path between n6 and n4', () {
      solution = [n6, n5, n3, n4];
      List<Node> result = dijkstra.pathTo("n6", "n4");
      expect(solution, result);
    });

  });
}
