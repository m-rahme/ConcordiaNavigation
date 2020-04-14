import 'models/providers.dart';
import 'screens/indoor_page.dart';
import 'screens/outdoor_interest.dart';
import 'screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'services/localization.dart';
import 'screens/home_page.dart';
import 'package:provider/provider.dart';
import 'screens/settings.dart';
import 'screens/profile.dart';
import 'screens/course_schedule.dart';
import 'screens/shuttle_schedule.dart';

Future<void> main() async {
  runApp(MultiProvider(
    providers: providers,
    child: App(),
  ));
}

// Main app
class App extends StatelessWidget {
  // Holds name of initial page (route)
  final String initialRoute;
  // Sets initial page for the app
  App({this.initialRoute});

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
      initialRoute: initialRoute ?? '/',
      routes: {
        '/home': (context) => HomePage(),
        '/schedule': (context) => CourseSchedule(),
        '/profile': (context) => Profile(),
        '/o_interest': (context) => OutdoorInterest(),
        '/settings': (context) => Settings(),
        '/shuttle': (context) => ShuttleSchedule(),
        '/indoor': (context) => IndoorPage(),
      },
      debugShowCheckedModeBanner: false,
      home: initialRoute != null ? null : SplashScreen(),
    );
  }
}
