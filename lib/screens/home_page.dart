import '../services/indoor/painters.dart';
import '../services/size_config.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/outdoor/map_page.dart';
import 'package:flutter/material.dart';
import '../widgets/homepage_appbar.dart';

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
    Painters();
    return Scaffold(
      appBar: HomePageAppBar(),
      drawer: CustomDrawer(),
      body: MapPage(),
    );
  }
}
