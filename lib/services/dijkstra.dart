import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/node.dart';

/// Class for finding the shortest path between nodes.
class Dijkstra {
  Map<String, Node> _nodes;
  PriorityQueue<Node> _pq;

  static Dijkstra fromJson(List json) {
    Map<String, Node> graph = {};

    json.forEach((campus) => campus['buildings']
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

    json.forEach((campus) => campus['buildings']
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

    Dijkstra dijkstra = Dijkstra.fromGraph(graph);

    return dijkstra;
  }

  Dijkstra.fromGraph(Map<String, Node> nodes)
      : _nodes = nodes,
        _pq = PriorityQueue<Node>();

  List<Node> getPath(String start, String end) {
    if (_nodes[end].previous == null) {
      _compute(start);
    }

    Queue<Node> inOrder = Queue<Node>();
    inOrder.addFirst(_nodes[end]);
    while (_nodes[end].previous != null) {
      inOrder.addFirst(_nodes[end].previous);
      end = _nodes[end].previous.name;
    }

    return inOrder.toList();
  }

  void _compute(String start) {
    // distance from start to start is 0
    _nodes[start].distance = 0;

    // distance for each node
    _nodes.forEach((key, node) {
      // redundant
      if (key != start) {
        node.distance = 9999;
        node.previous = null;
      }

      _pq.add(node);
    });

    while (_pq.isNotEmpty) {
      Node u = _pq.removeFirst();
      u.edges.forEach((v, distance) {
        int newDistance = _nodes[u.name].distance + u.edges[v];
        if (newDistance < v.distance) {
          v.distance = newDistance;
          v.previous = u;
          _nodes[v.name] = v;
          _pq.add(v);
        }
      });
    }
  }
}
