import 'package:concordia_navigation/models/providers.dart';
import 'package:concordia_navigation/services/localization.dart';
import 'package:concordia_navigation/widgets/custom_appbar.dart';
import 'package:concordia_navigation/widgets/custom_drawer.dart';
import 'package:concordia_navigation/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

Widget testAppWidget = MultiProvider(
    providers: providers,
    child: MaterialApp(
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
      home: Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        body: MapWidget(),
      ),
    ));
