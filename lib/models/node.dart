class Node implements Comparable<Node> {
  String name;
  int distance;
  Map<Node, int> edges;
  Node previous;

  Node(this.name, this.edges, [this.distance = 9999]) {
    this.edges?.forEach((key, value) => key.edges[this] = value);
  }

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
