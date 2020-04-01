import 'dart:async';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _animation.addListener(() => this.setState(() {}));
    _animationController.forward();

    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/home');
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
