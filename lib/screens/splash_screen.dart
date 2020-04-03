import 'dart:async';
import 'package:concordia_navigation/services/building_list.dart';
import 'package:concordia_navigation/services/change_later.dart';
import 'package:concordia_navigation/services/location_search.dart';
import 'package:concordia_navigation/services/location_service.dart';
import 'package:concordia_navigation/services/outdoor_poi_list.dart';
import 'package:concordia_navigation/services/shuttle_service.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/screens/home_page.dart';

// This is the Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  Future<void> loadAssets() async {
    //WidgetsFlutterBinding.ensureInitialized();
    BuildingList.buildingInfo = await BuildingList.loadJson();
    LoadBuildingInfo.indoorData = await LoadBuildingInfo.loadJson();
    ShuttleService.shuttleSchedule = await ShuttleService.loadJson();
    LocationSearch.classrooms = await LocationSearch.loadJson();
    OutdoorPOIList.poi = await OutdoorPOIList.loadJson();
  }

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _animation.addListener(() => this.setState(() {}));
    _animationController.forward();

    loadAssets()
        .then((value) => Navigator.pushReplacementNamed(context, '/home'));
    // Timer(Duration(seconds: 3), () {
    //   Navigator.pushNamed(context, '/home');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
              child: Image.asset(
            'assets/LaunchImage.png',
            fit: BoxFit.cover,
          )),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                      width: _animation.value * 300.0,
                      height: _animation.value * 300.0,
                      duration: const Duration(seconds: 3),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: Image.asset(
                        'assets/app_logo.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }
}