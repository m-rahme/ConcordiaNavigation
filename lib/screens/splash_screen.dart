import 'dart:async';
import 'dart:typed_data';
import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:concordia_navigation/models/outdoor/campus.dart';
import 'package:concordia_navigation/providers/indoor_data.dart';
import 'package:concordia_navigation/services/dijkstra.dart';
import 'package:concordia_navigation/services/location_search.dart';
import 'package:concordia_navigation/services/outdoor/shuttle_service.dart';
import 'package:concordia_navigation/services/outdoor_poi_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

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
    List<dynamic> campusData = await Campus.loadJson();
    ShuttleService.shuttleSchedule = await ShuttleService.loadJson();
    LocationSearch.classrooms = await LocationSearch.loadJson();
    OutdoorPOIList.poi = await OutdoorPOIList.loadJson();

    // Creating DAO's for campuses
    Campus.sgw = Campus.fromJson(campusData[0]);
    Campus.loy = Campus.fromJson(campusData[1]);

    IndoorData.shortest = Dijkstra.fromJson(campusData);
    Campus.sgw.buildings.forEach((building) async {
      if (building.logo != null)
        // Building.icons[building] = await BitmapDescriptor.fromAssetImage(
        //     ImageConfiguration(size: Size(350, 350)), building.logo);
        Building.icons[building] = BitmapDescriptor.fromBytes(
            await getBytesFromAsset(building.logo, 350));
    });
    Campus.loy.buildings.forEach((building) async {
      if (building.logo != null)
        // Building.icons[building] = await BitmapDescriptor.fromAssetImage(
        //     ImageConfiguration(size: Size(350, 350)), building.logo);
        Building.icons[building] = BitmapDescriptor.fromBytes(
            await getBytesFromAsset(building.logo, 350));
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
