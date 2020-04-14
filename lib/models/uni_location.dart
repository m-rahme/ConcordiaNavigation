/// Abstract class of an outdoor location that could either an indoor or another outdoor location
abstract class UniLocation {
  final String name;
  List<UniLocation> children;
  UniLocation parent;

  UniLocation(this.name, {this.parent, this.children}) : assert(name != null);
}
