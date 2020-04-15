import 'dart:async';
import 'package:flutter/material.dart';
import '../models/indoor/indoor_location.dart';
import '../models/outdoor/building.dart';
import '../models/outdoor/university.dart';
import '../services/indoor/dijkstra.dart';
import '../storage/app_constants.dart' as constants;
import '../services/outdoor/location_service.dart';
import '../services/outdoor/shuttle_service.dart';
import '../services/search.dart';

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

    University.concordia = University.fromJson(data);

    Dijkstra.shortest = Dijkstra.fromJson(data);

    Search.supported.forEach((object) {
      if (object is Building ||
          (object is IndoorLocation &&
              constants.classroomFilter.hasMatch(object.name))) {
        Search.names.add(object.name.toUpperCase());
      }
    });
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
    // Trigger location update\
    try {
      LocationService.getInstance();
    } catch (Exception) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Location is unavailable at this time!')));
    }
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
              child: Image.asset(
            'assets/png/LaunchImage.png',
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
                        'assets/png/app_logo.png',
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
