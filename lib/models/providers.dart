

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:concordia_navigation/models/shuttle_data.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/providers/buildings_data.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<MapData>(
    create: (_) => MapData(),
  ),
  ChangeNotifierProvider<ShuttleData>(
    create: (_) => ShuttleData(),
  ),
  ChangeNotifierProvider<BuildingsData>(
    create: (_) => BuildingsData(),
  ),
];