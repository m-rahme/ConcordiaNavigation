import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'screens/map.dart';
import 'dart:async';
import 'widgets/custom_appbar.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Concordia Navigation',
      routes: {
//          Welcome.id: (context) => Welcome(),
//          Register.id: (context) => Register(),
//          Login.id: (context) => Login(),
//          Create.id: (context) => Create(),
//          Settings.id: (context) => Settings()
      },
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _completer = Completer();
  Future<void> animateTo(double lat, double lng) async {
    final c = await _completer.future;
    final p = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 17,
      tilt: 30.440717697143555,
      bearing: 30.8334901395799,
    );
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  }

  Widget _expendTile() {
    return ExpansionTile(
      leading: Icon(Icons.map),
      title: new Text(
        "Campus",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      children: <Widget>[
        new Column(
          children: _buildExpandableContent(),
        ),
      ],
    );
  }

  _buildExpandableContent() {
    List<Widget> columnContent = [];

    columnContent.add(
      new ListTile(
          title: new Text(
            "Sir George Williams",
          ),
          onTap: () {
            Navigator.of(context).pop();
            animateTo(45.4957, -73.5781);
          }),
    );
    columnContent.add(
      new ListTile(
        title: new Text(
          "Loyola",
        ),
        onTap: () {
          Navigator.of(context).pop();
          animateTo(45.4582, -73.6405);
        },
      ),
    );

    return columnContent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                "ConNavigator",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            _expendTile(),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(
                "Your Schedule",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                "Settings",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          MapPage(
            completer: _completer,
          ),
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: CustomAppBar(),
          ),
        ],
      ),
    );
  }
}
