import 'package:concordia_navigation/main.dart';
import 'package:concordia_navigation/models/outdoor/user_location.dart';
import 'package:concordia_navigation/providers/buildings_data.dart';
import 'package:concordia_navigation/providers/calendar_data.dart';
import 'package:concordia_navigation/providers/indoor_data.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/services/localization.dart';
import 'package:concordia_navigation/services/outdoor/location_service.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

/// Widget used to test whole App
Widget appWidget({MapData mockMapData, CalendarData mockCalendarData, Widget testWidget}) {
  TestWidgetsFlutterBinding.ensureInitialized();
// Providers
  Widget userLocationProvider = StreamProvider<UserLocation>(
    create: (_) => LocationService.getInstance().stream,
    initialData: UserLocation(45.495944, -73.578075),
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

  Widget indoorData = ChangeNotifierProvider<IndoorData>(
    create: (_) => IndoorData(),
  );
  

// Mock Providers
  if(mockMapData != null) 
    mapDataProvider = ChangeNotifierProvider<MapData>.value( value: mockMapData,);
  if(mockCalendarData != null)
    calendarData = ChangeNotifierProvider<CalendarData>.value( value: mockCalendarData,);
  

// Testing App
  return MultiProvider(
      providers: [
        userLocationProvider,
        mapDataProvider,
        buildingsDataProvider,
        calendarData,
        indoorData
      ],
      child: testWidget != null ? TestApp(testWidget) : App(initialRoute: '/home',),
  );
}



/// Used to test individual widgets
class TestApp extends StatelessWidget {
  final Widget widget; 

  TestApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Concordia Navigation',
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        const ConcordiaLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('fr', ''),
      ],
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      home: TestWidget(widget),
    );
  }
}

class TestWidget extends StatelessWidget {
  final Widget widget; 

  TestWidget(this.widget);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return widget;
  }
}