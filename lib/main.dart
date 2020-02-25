import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'services/localization.dart';
import 'screens/home_page.dart';
import 'package:provider/provider.dart';
import 'models/map_data.dart';

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
        routes: {
//      Settings.id: (context) => Settings()
        },
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
