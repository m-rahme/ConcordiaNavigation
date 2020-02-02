import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'screens/map.dart';
import 'dart:async';
import 'widgets/custom_appbar.dart';
import 'package:google_fonts/google_fonts.dart';

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
      zoom: 16.5,
      tilt: 30.440717697143555,
      bearing: 30.8334901395799,
    );
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  }

  Widget _expendTile() {
    return Theme(
      data: ThemeData(
        accentColor: Color(0xFF73C700),
      ),
      child: ExpansionTile(
        leading: Icon(Icons.map),
        title: new Text(
          "Campus",
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          new Column(
            children: _buildExpandableContent(),
          ),
        ],
      ),
    );
  }

  _buildExpandableContent() {
    List<Widget> columnContent = [];

    columnContent.add(
      new ListTile(
          title: new Text(
            "Sir George Williams",
            style: GoogleFonts.raleway(),
          ),
          onTap: () {
            Navigator.of(context).pop();
            animateTo(45.496676, -73.578760);
          }),
    );
    columnContent.add(
      new ListTile(
        title: new Text(
          "Loyola",
          style: GoogleFonts.raleway(),
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
            Container(
              padding: EdgeInsets.only(
                top: 35.0,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF73C700),
              ),
              child: ListTile(
                title: Text(
                  "ConNavigator",
                  style: GoogleFonts.raleway(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onTap: () {},
              ),
            ),
            _expendTile(),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(
                "Your Schedule",
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(
                "Profile",
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                "Settings",
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
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
            right: 40,
            left: 40,
            child: CustomAppBar(),
          ),
        ],
      ),
    );
  }
}
