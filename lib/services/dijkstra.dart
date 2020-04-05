import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:concordia_navigation/models/node.dart';

/// Class for finding the shortest path between nodes.
class Dijkstra {
  Map<String, Node> _nodes;
  PriorityQueue<Node> _pq;

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

  Map<String, Node> _compute(String start) {
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

    return _nodes;
  }
}
