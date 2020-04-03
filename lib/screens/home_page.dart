import 'package:concordia_navigation/screens/indoor_page.dart';
import 'package:concordia_navigation/services/change_later.dart';
import 'package:concordia_navigation/services/painters.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:concordia_navigation/widgets/custom_drawer.dart';
import 'package:concordia_navigation/widgets/directions_drawer.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/widgets/homepage_appbar.dart';
import 'package:concordia_navigation/widgets/map_widget.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;

//The app will launch here.
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    LoadBuildingInfo();
    Painters();
    return Scaffold(
      backgroundColor: constants.whiteColor,
      appBar: HomePageAppBar(),
      drawer: CustomDrawer(),
      body: Stack(children: <Widget>[
//        MapWidget(),
//        DirectionsDrawer(),
        IndoorPage(),
      ]),
    );
  }
}
