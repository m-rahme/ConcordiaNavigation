import 'package:concordia_navigation/models/shuttle_data.dart';
import 'package:concordia_navigation/screens/directions_page.dart';
import 'package:concordia_navigation/models/user_location.dart';
import 'package:concordia_navigation/providers/buildings_data.dart';
import 'package:concordia_navigation/screens/outdoor_interest.dart';
import 'package:concordia_navigation/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'services/localization.dart';
import 'screens/home_page.dart';
import 'package:provider/provider.dart';
import 'providers/map_data.dart';
import 'package:concordia_navigation/screens/settings.dart';
import 'package:concordia_navigation/screens/profile.dart';
import 'package:concordia_navigation/screens/schedule.dart';
import 'package:concordia_navigation/screens/shuttle_schedule.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      StreamProvider<UserLocation>(
        create: (context) => LocationService().stream,
        initialData: UserLocation.SGW(),
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
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
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
      routes: {
        '/schedule': (context) => Schedule(),
        '/profile': (context) => Profile(),
        '/o_interest': (context) => OutdoorInterest(),
        '/settings': (context) => Settings(),
        '/directions': (context) => DirectionsPage(),
        '/shuttle': (context) => ShuttleSchedule(),
      },
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
