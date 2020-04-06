import 'package:concordia_navigation/models/node.dart';
import 'package:concordia_navigation/models/outdoor/campus.dart';
import 'package:concordia_navigation/services/dijkstra.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Dijkstra', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    List<dynamic> campusData;
    Map<String, Node> graph;
    Dijkstra dijkstra;
    List<Node> solution;

    setUp(() async {
      campusData = await Campus.loadJson();
      dijkstra= Dijkstra.fromJson(campusData);
      graph = dijkstra.nodes;


      solution = [
        graph['H1entrance'],
        graph['H1checkMM'],
        graph['H1escalatorUp'],
        graph['H1exitMR']
      ];
    });

    test('constructor creates a list of edges', () {
      List<Node> result = dijkstra.pathTo("H1entrance", "H1exitMR");
      expect(solution, result);
    });
  });
}
