import 'package:concordia_navigation/services/size_config.dart';
import 'package:concordia_navigation/widgets/custom_drawer.dart';
import 'package:concordia_navigation/widgets/directions_drawer.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/widgets/homepage_appbar.dart';
import 'package:concordia_navigation/widgets/map_widget.dart';

//The app will launch here.
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: HomePageAppBar(),
      drawer: CustomDrawer(),
      body: Stack(children: <Widget>[
        MapWidget(),
        DirectionsDrawer(),
      ]),
    );
  }
}
