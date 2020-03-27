import 'package:concordia_navigation/main.dart';
import 'package:concordia_navigation/models/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget appWidget = MultiProvider(
    providers: providers,
    child: App(),
  );
