import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:concordia_navigation/services/localization.dart';
import 'package:concordia_navigation/widgets/custom_appbar.dart';
import 'package:concordia_navigation/widgets/map_widget.dart';
import 'package:provider/provider.dart';
import 'package:concordia_navigation/models/map_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      Consumer<MapData>(
        builder: (context, mapData, child) {
          return ListTile(
              title: new Text(
                "Sir George Williams",
                style: GoogleFonts.raleway(),
              ),
              onTap: () {
                Navigator.of(context).pop();
                mapData.animateTo(45.496676, -73.578760);
              });
        },
      ),
    );

    columnContent.add(
      Consumer<MapData>(
        builder: (context, mapData, child) {
          return ListTile(
              title: new Text(
                "Loyola",
                style: GoogleFonts.raleway(),
              ),
              onTap: () {
                Navigator.of(context).pop();
                mapData.animateTo(45.4582, -73.6405);
              });
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
                ConcordiaLocalizations.of(context).schedule,
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(
                ConcordiaLocalizations.of(context).profile,
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                ConcordiaLocalizations.of(context).settings,
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          MapWidget(),
          Positioned(
            top: 50,
            right: 20,
            left: 20,
            child: CustomAppBar(),
          ),
        ],
      ),
    );
  }
}
