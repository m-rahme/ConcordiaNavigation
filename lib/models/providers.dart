import 'user_location.dart';
import '../providers/calendar_data.dart';
import '../providers/indoor_data.dart';
import '../services/outdoor/location_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../providers/map_data.dart';
import '../providers/buildings_data.dart';

/// Model class that holds the list of providers used for state management
List<SingleChildWidget> providers = [
  StreamProvider<UserLocation>(
    create: (context) => LocationService.getInstance().stream,
  ),
  ChangeNotifierProvider<MapData>(
    create: (context) => MapData(),
  ),
  ChangeNotifierProvider<BuildingsData>(
    create: (context) => BuildingsData(),
  ),
  ChangeNotifierProvider<CalendarData>(
    create: (_) => CalendarData(),
  ),
  ChangeNotifierProvider<IndoorData>(
    create: (_) => IndoorData(),
  ),
];
