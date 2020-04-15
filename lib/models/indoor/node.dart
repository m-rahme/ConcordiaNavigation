/// Node class used for Dijkstra shortest path algorithm
class Node implements Comparable<Node> {
  String name;
  int distance;
  Map<Node, int> edges = {};
  Node previous;
  bool accessible;

  /// Sets initial node distance as 9999 to simulate an infinite distance (part of the Dijkstra algorithm)
  Node(this.name, [this.distance = 9999])
      : accessible = !name.contains('escalator');

  void setEdge(Node node, int distance) => edges[node] = distance;

  @override
  int compareTo(Node other) {
    if (distance > other.distance) {
      return 1;
    }
    else if (distance < other.distance) {
      return -1;
    }
    else {
      return 0;
    }
  }
}
