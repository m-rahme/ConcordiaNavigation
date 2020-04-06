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
      graph = {};

      campusData.forEach((campus) => campus['buildings']
          ?.forEach((building) => building['floors']?.forEach((floor) {
                if (floor['classrooms'] != null && floor['poi'] != null) {
                  floor['classrooms'].forEach((classroom) {
                    if (classroom['name'] != null) {
                      graph[classroom['name']] = Node(classroom['name']);
                    }
                  });
                  floor['poi'].forEach((poi) {
                    if (poi['name'] != null) {
                      graph[poi['name']] = Node(poi['name']);
                    }
                  });
                }
              })));

      campusData.forEach((campus) => campus['buildings']
          ?.forEach((building) => building['floors']?.forEach((floor) {
                if (floor['classrooms'] != null) {
                  floor['classrooms']?.forEach((classroom) {
                    if (classroom['edges'] != null) {
                      classroom['edges'].forEach((edge) {
                        if (edge['name'] != null)
                          graph[classroom['name']]
                              .setEdge(graph[edge['name']], edge['distance']);
                      });
                    }
                  });
                  floor['poi']?.forEach((poi) {
                    if (poi['edges'] != null) {
                      poi['edges'].forEach((edge) {
                        if (edge['name'] != null)
                          graph[poi['name']]
                              .setEdge(graph[edge['name']], edge['distance']);
                      });
                    }
                  });
                }
              })));

      solution = [
        graph['entrance'],
        graph['checkMM'],
        graph['escalatorUp'],
        graph['exitMR']
      ];
      dijkstra = Dijkstra.fromGraph(graph);
    });

    test('constructor creates a list of edges', () {
      List<Node> result = dijkstra.pathTo("entrance", "exitMR");
      expect(solution, result);
    });
  });
}
