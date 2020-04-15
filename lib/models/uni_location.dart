/// Abstract class representing locations relevant to a university
/// Could take the form of a campus, building, classroom, etc.
abstract class UniLocation {
  final String name;
  List<UniLocation> children;
  UniLocation parent;

  UniLocation(this.name, {this.parent, this.children}) : assert(name != null);
}
