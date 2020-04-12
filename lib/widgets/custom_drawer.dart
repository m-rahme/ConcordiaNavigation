import 'package:concordia_navigation/providers/buildings_data.dart';
import 'package:concordia_navigation/providers/calendar_data.dart';
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
        accentColor: constants.appColor,
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
                  ModalRoute.withName('/home'),
                );
                mapData.animateToLatLng(constants.sgw);
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
                  ModalRoute.withName('/home'),
                );
                mapData.animateToLatLng(constants.loyola);
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
              color: constants.whiteColor,
            ),
            child: ListTile(
              title: Text(
                "ConNavigation",
                style: GoogleFonts.raleway(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: constants.appColor,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Container(
            color: constants.whiteColor,
            child: Container(
              color: constants.lightGreyColor,
              height: 2,
            ),
          ),
          Container(
            color: constants.whiteColor,
            child: _expendTile(),
          ),
          Container(
            color: constants.whiteColor,
            child: ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(
                ConcordiaLocalizations.of(context).schedule,
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Provider.of<CalendarData>(context, listen: false)
                    .retrieveFromDevice();
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/schedule');
              },
            ),
          ),
          Container(
            color: constants.whiteColor,
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
            color: constants.whiteColor,
            child: ListTile(
              leading: Icon(Icons.wb_sunny),
              title: Text(
                "Toggle Building Highlights",
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Provider.of<BuildingsData>(context, listen: false)
                    .toggleOutline();
              },
            ),
          ),
          Container(
            color: constants.whiteColor,
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
            color: constants.whiteColor,
            child: Container(
              color: constants.lightGreyColor,
              height: 2,
            ),
          ),
          Container(
            color: constants.whiteColor,
            height: 570,
          ),
        ],
      ),
    );
  }
}
