import 'package:concordia_navigation/main.dart';
import 'package:concordia_navigation/models/providers.dart';
import 'package:concordia_navigation/models/user_location.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Widget appWidget() {
  return MultiProvider(
    providers: providers,
    child: App(),
  );
} 

