

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'buildings_data.dart';
import 'map_data.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<MapData>(
    create: (_) => MapData(),
  ),
  ChangeNotifierProvider<BuildingsData>(
    create: (_) => BuildingsData(),
  ),
];