import 'dart:async';
import 'package:concordia_navigation/models/university.dart';
import 'package:concordia_navigation/services/dijkstra.dart';
import 'package:concordia_navigation/services/outdoor/shuttle_service.dart';
import 'package:concordia_navigation/services/outdoor_poi_list.dart';
import 'package:concordia_navigation/services/search.dart';
import 'package:flutter/material.dart';

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
    // Preloading json data
    List<dynamic> data = await University.loadJson();
    ShuttleService.shuttleSchedule = await ShuttleService.loadJson();

    OutdoorPOIList.poi = await OutdoorPOIList.loadJson();
    University.concordia = University.fromJson(data);

    Dijkstra.shortest = Dijkstra.fromJson(data);

    Search.supported
        .forEach((object) => Search.names.add(object.name.toUpperCase()));

    // Building.icons[building] = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(size: Size(350, 350)), building.logo);
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

    loadAssets().then((value) {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    });
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
