class Node implements Comparable<Node> {
  String name;
  int distance;
  Map<Node, int> edges = {};
  Node previous;

  Node(this.name, [this.distance = 9999]);

  /// checks if the map is already
  void setEdge(Node node, int distance) => edges[node] = distance;

  @override
  int compareTo(Node other) {
    if (distance > other.distance)
      return 1;
    else if (distance < other.distance)
      return -1;
    else
      return 0;
  }
}
