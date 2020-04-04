import 'package:concordia_navigation/models/providers.dart';
import 'package:concordia_navigation/screens/directions_page.dart';
import 'package:concordia_navigation/screens/indoor_page.dart';
import 'package:concordia_navigation/screens/outdoor_interest.dart';
import 'package:concordia_navigation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'services/localization.dart';
import 'screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:concordia_navigation/screens/settings.dart';
import 'package:concordia_navigation/screens/profile.dart';
import 'package:concordia_navigation/screens/course_schedule.dart';
import 'package:concordia_navigation/screens/shuttle_schedule.dart';

Future<void> main() async {
  runApp(MultiProvider(
    providers: providers,
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
        '/home': (context) => HomePage(),
        '/schedule': (context) => CourseSchedule(),
        '/profile': (context) => Profile(),
        '/o_interest': (context) => OutdoorInterest(),
        '/settings': (context) => Settings(),
        '/directions': (context) => DirectionsPage(),
        '/shuttle': (context) => ShuttleSchedule(),
        '/indoor': (context) => IndoorPage(),
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
