import 'dart:collection';
import 'package:collection/collection.dart';
import '../models/node.dart';
import 'package:meta/meta.dart' show visibleForTesting;

/// Class for finding the shortest path between nodes.
class Dijkstra {
  static Dijkstra shortest;

  Map<String, Node> _nodes;
  PriorityQueue<Node> _pq;

  @visibleForTesting
  Map<String, Node> get nodes => _nodes;

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
                      if (edge['name'] != null) {
                        graph[classroom['name']]
                            .setEdge(graph[edge['name']], edge['distance']);
                      }
                    });
                  }
                });
                floor['poi']?.forEach((poi) {
                  if (poi['edges'] != null) {
                    poi['edges'].forEach((edge) {
                      if (edge['name'] != null) {
                        graph[poi['name']]
                            .setEdge(graph[edge['name']], edge['distance']);
                      }
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

  List<Node> pathTo(String start, String end, {bool accessible = false}) {
    // distance from start to start is 0
    Map<String, Node> _temp = Map.from(_nodes);

    _temp[start].distance = 0;

    // distance for each node
    _temp.forEach((key, node) {
      if (key != start) {
        node.distance = 9999;
      }

      _pq.add(node);
    });

    // if (accessible) {
    //   disable('escalator');
    // } else {
    //   disable('accessible');
    // }

    if (accessible) {
      _temp.forEach((key, og) {
        if (!og.accessible) {
          og.edges.forEach((key2, val) {
            og.edges[key2] = 99999;
          });
          _temp.forEach((key, node) {
            node.edges.forEach((thing, otherThing) {
              if (thing == og) {
                thing.edges[thing] = 99999;
              }
            });
          });
        }
      });
    } else {
      _temp.forEach((key, badNode) {
        if (badNode.name.contains('accessibility') ||
            badNode.name.contains('elevator')) {
          badNode.edges.forEach((checkNode, val) {
            badNode.edges[checkNode] = 99999;
          });
          _temp.forEach((goodNodeName, goodNode) {
            goodNode.edges.forEach((maybeBadNode, maybeBadDistance) {
              if (maybeBadNode == badNode) {
                goodNode.edges[maybeBadNode] = 99999;
              }
            });
          });
        }
      });
    }

    while (_pq.isNotEmpty) {
      Node u = _pq.removeFirst();
      u.edges.forEach((v, distance) {
        int newDistance = _temp[u.name].distance + u.edges[v];
        if (newDistance < v.distance) {
          v.distance = newDistance;
          v.previous = u;
          _temp[v.name] = v;
          _pq.add(v);
        }
      });
    }

    Queue<Node> inOrder = Queue<Node>();
    inOrder.addFirst(_temp[end]);
    bool stop = false;
    while (!stop) {
      if (_temp[end].previous == null) {
        stop = true;
      } else {
        inOrder.addFirst(_temp[end].previous);
        end = _temp[end].previous?.name;
        stop = end == start;
      }
    }

    return inOrder.toList();
  }
}
