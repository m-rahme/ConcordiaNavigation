import 'package:concordia_navigation/main.dart';
import 'package:concordia_navigation/models/user_location.dart';
import 'package:concordia_navigation/providers/buildings_data.dart';
import 'package:concordia_navigation/providers/calendar_data.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/screens/course_schedule.dart';
import 'package:concordia_navigation/screens/home_page.dart';
import 'package:concordia_navigation/screens/outdoor_interest.dart';
import 'package:concordia_navigation/screens/profile.dart';
import 'package:concordia_navigation/screens/settings.dart';
import 'package:concordia_navigation/screens/shuttle_schedule.dart';
import 'package:concordia_navigation/services/localization.dart';
import 'package:concordia_navigation/services/location_service.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

/// Widget used to test whole App
Widget appWidget({MapData mockMapData, Widget testWidget}) {
  TestWidgetsFlutterBinding.ensureInitialized();
// Providers
  Widget userLocationProvider = StreamProvider<UserLocation>(
    create: (_) => LocationService.getInstance().stream,
    initialData: UserLocation.sgw(),
  );

  Widget mapDataProvider = ChangeNotifierProvider<MapData>(
    create: (_) => MapData(),
  );

  Widget buildingsDataProvider = ChangeNotifierProvider<BuildingsData>(
    create: (_) => BuildingsData(),
  );

  Widget calendarData = ChangeNotifierProvider<CalendarData>(
    create: (_) => CalendarData(),
  );

// Mock Providers
  if(mockMapData != null) {
    mapDataProvider = ChangeNotifierProvider<MapData>.value( value: mockMapData,);
  }

// Testing App
  return MultiProvider(
      providers: [
        userLocationProvider,
        mapDataProvider,
        buildingsDataProvider,
        calendarData
      ],
      child: testWidget != null ? MaterialApp(home:TestWidget(testWidget)) : App(initialRoute: '/home',),
  );
}


/// Used to test individual widgets
class TestWidget extends StatelessWidget {
  final Widget widget; 

  TestWidget(this.widget);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return widget;
  }
}