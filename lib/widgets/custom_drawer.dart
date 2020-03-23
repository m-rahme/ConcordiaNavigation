import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:concordia_navigation/services/localization.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:provider/provider.dart';

//Custom drawer used in the app.
class CustomDrawer extends StatelessWidget {
  Widget _expendTile() {
    return Theme(
      data: ThemeData(
        accentColor: constants.greenColor,
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
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator.defaultRouteName),
                );
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
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator.defaultRouteName),
                );
                mapData.animateTo(45.4582, -73.6405);
              });
        },
      ),
    );

    return columnContent;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 42.5,
            ),
            decoration: BoxDecoration(
              color: constants.offWhiteColor,
            ),
            child: ListTile(
              title: Text(
                "ConNavigation",
                style: GoogleFonts.raleway(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: constants.greenColor,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Container(
            color: constants.offWhiteColor,
            child: Container(
              color: constants.lightGreyColor,
              height: 2,
            ),
          ),
          Container(
            color: constants.offWhiteColor,
            child: _expendTile(),
          ),
          Container(
            color: constants.offWhiteColor,
            child: ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(
                ConcordiaLocalizations.of(context).schedule,
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/schedule');
              },
            ),
          ),
          Container(
            color: constants.offWhiteColor,
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: Text(
                ConcordiaLocalizations.of(context).interest,
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/o_interest');
              },
            ),
          ),
          Container(
            color: constants.offWhiteColor,
            child: ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(
                ConcordiaLocalizations.of(context).profile,
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ),
          Container(
            color: constants.offWhiteColor,
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                ConcordiaLocalizations.of(context).settings,
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ),
          Container(
            color: constants.offWhiteColor,
            child: Container(
              color: constants.lightGreyColor,
              height: 2,
            ),
          ),
          Container(
            color: constants.offWhiteColor,
            height: 570,
          ),
        ],
      ),
    );
  }
}
