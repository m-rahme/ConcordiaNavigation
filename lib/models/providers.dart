

import 'package:concordia_navigation/models/user_location.dart';
import 'package:concordia_navigation/services/location_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:concordia_navigation/models/shuttle_data.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/providers/buildings_data.dart';

List<SingleChildWidget> providers = [
      StreamProvider<UserLocation>(
        create: (context) => LocationService.getInstance().stream,
        initialData: UserLocation.sgw(),
      ),
      ChangeNotifierProvider<MapData>(
        create: (context) => MapData(),
      ),
      ChangeNotifierProvider<BuildingsData>(
        create: (context) => BuildingsData(),
      ),
      ChangeNotifierProvider<ShuttleData>(
        create: (_) => ShuttleData(),
      ),
    ];