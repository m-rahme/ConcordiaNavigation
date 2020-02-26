import 'package:concordia_navigation/models/buildings_data.dart';
import 'package:concordia_navigation/screens/outdoor_interest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'services/localization.dart';
import 'screens/home_page.dart';
import 'package:provider/provider.dart';
import 'models/map_data.dart';
import 'package:concordia_navigation/screens/settings.dart';
import 'package:concordia_navigation/screens/profile.dart';
import 'package:concordia_navigation/screens/schedule.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MapData>(
          create: (_) => MapData(),
        ),
        ChangeNotifierProvider<BuildingsData>(
          create: (_) => BuildingsData(),
        ),
      ],
      child: MaterialApp(
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
        },
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
