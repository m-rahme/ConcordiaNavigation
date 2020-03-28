import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

//Concordia Shuttle Schedule Screen
class ShuttleSchedule extends StatefulWidget {
  @override
  _ShuttleScheduleState createState() => _ShuttleScheduleState();
}

class _ShuttleScheduleState extends State<ShuttleSchedule> {
  // bool variable to know whenever the user presses the top buttons to highlight the bus schedule hours depending on the destination
  bool isSelectedSGWToLoy = false;
  bool isSelectedLoyToSGW = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ConcordiaLocalizations.of(context).shuttle,
        ),
        backgroundColor: greenColor,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // Shuttle bus destinations
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Table(
                border: TableBorder(
                  top: BorderSide.none,
                  bottom: BorderSide(width: 3.0, color: Colors.lightGreen),
                ),
                children: [
                  TableRow(children: [
                    buildTitleTableCellSGWToLoy('SGW to Loyola'),
                    buildTitleTableCellLoyToSGW('Loyola to SGW'),
                  ]),
                ],
              ),
            ),

            // Days of the week of shuttle bus schedule
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Table(
                border: TableBorder(
                  bottom: BorderSide(width: 3.0, color: Colors.lightGreen),
                ),
                children: [
                  TableRow(children: [
                    buildTableCellSGWtoLoy('Mon-Thu'),
                    buildTableCellSGWtoLoy('Friday'),
                    buildTableCellLoyToSGW('Mon-Thu'),
                    buildTableCellLoyToSGW('Friday'),
                  ]),
                ],
              ),
            ),

            // Shuttle bus departure schedule
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                child: SingleChildScrollView(
                  child: Table(
                    border: TableBorder(
                      verticalInside:
                          BorderSide(width: 1.0, color: Colors.grey[200]),
                    ),
                    children: [
                      TableRow(children: [
                        buildTableCellSGWtoLoy('07:30'),
                        buildTableCellSGWtoLoy('07:40'),
                        buildTableCellLoyToSGW('07:35'),
                        buildTableCellLoyToSGW('07:45'),
                      ]),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('07:40'),
                          buildTableCellSGWtoLoy('08:15'),
                          buildTableCellLoyToSGW('08:05'),
                          buildTableCellLoyToSGW('08:20'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('07:55'),
                          buildTableCellSGWtoLoy('08:15'),
                          buildTableCellLoyToSGW('08:20'),
                          buildTableCellLoyToSGW('08:55'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('08:20'),
                          buildTableCellSGWtoLoy('09:10'),
                          buildTableCellLoyToSGW('08:35'),
                          buildTableCellLoyToSGW('09:30'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('08:35'),
                          buildTableCellSGWtoLoy('09:10'),
                          buildTableCellLoyToSGW('08:55'),
                          buildTableCellLoyToSGW('09:30'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('08:55'),
                          buildTableCellSGWtoLoy('10:20'),
                          buildTableCellLoyToSGW('09:10'),
                          buildTableCellLoyToSGW('10:05'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('09:10'),
                          buildTableCellSGWtoLoy('10:35'),
                          buildTableCellLoyToSGW('09:30'),
                          buildTableCellLoyToSGW('10:55'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('09:30'),
                          buildTableCellSGWtoLoy('11:10'),
                          buildTableCellLoyToSGW('09:45'),
                          buildTableCellLoyToSGW('11:10'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('09:45'),
                          buildTableCellSGWtoLoy('11:30'),
                          buildTableCellLoyToSGW('10:05'),
                          buildTableCellLoyToSGW('11:45'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('10:20'),
                          buildTableCellSGWtoLoy('11:45'),
                          buildTableCellLoyToSGW('10:20'),
                          buildTableCellLoyToSGW('12:05'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('10:35'),
                          buildTableCellSGWtoLoy('12:20'),
                          buildTableCellLoyToSGW('10:55'),
                          buildTableCellLoyToSGW('12:20'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('10:55'),
                          buildTableCellSGWtoLoy('12:40'),
                          buildTableCellLoyToSGW('11:10'),
                          buildTableCellLoyToSGW('12:55'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('11:10'),
                          buildTableCellSGWtoLoy('12:55'),
                          buildTableCellLoyToSGW('11:45'),
                          buildTableCellLoyToSGW('13:30'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('11:30'),
                          buildTableCellSGWtoLoy('13:30'),
                          buildTableCellLoyToSGW('12:15'),
                          buildTableCellLoyToSGW('13:45'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('12:00'),
                          buildTableCellSGWtoLoy('14:05'),
                          buildTableCellLoyToSGW('12:45'),
                          buildTableCellLoyToSGW('14:05'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('12:30'),
                          buildTableCellSGWtoLoy('14:20'),
                          buildTableCellLoyToSGW('13:15'),
                          buildTableCellLoyToSGW('14:40'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('13:00'),
                          buildTableCellSGWtoLoy('14:40'),
                          buildTableCellLoyToSGW('13:45'),
                          buildTableCellLoyToSGW('14:55'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('13:30'),
                          buildTableCellSGWtoLoy('15:15'),
                          buildTableCellLoyToSGW('14:15'),
                          buildTableCellLoyToSGW('15:15'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('14:00'),
                          buildTableCellSGWtoLoy('15:30'),
                          buildTableCellLoyToSGW('14:45'),
                          buildTableCellLoyToSGW('15:50'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('14:30'),
                          buildTableCellSGWtoLoy('15:50'),
                          buildTableCellLoyToSGW('15:15'),
                          buildTableCellLoyToSGW('16:05'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('15:00'),
                          buildTableCellSGWtoLoy('16:25'),
                          buildTableCellLoyToSGW('15:45'),
                          buildTableCellLoyToSGW('16:25'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('15:30'),
                          buildTableCellSGWtoLoy('16:40'),
                          buildTableCellLoyToSGW('16:15'),
                          buildTableCellLoyToSGW('17:15'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('16:00'),
                          buildTableCellSGWtoLoy('17:00'),
                          buildTableCellLoyToSGW('16:45'),
                          buildTableCellLoyToSGW('17:30'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('16:30'),
                          buildTableCellSGWtoLoy('18:05'),
                          buildTableCellLoyToSGW('17:15'),
                          buildTableCellLoyToSGW('18:05'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('17:00'),
                          buildTableCellSGWtoLoy('18:40'),
                          buildTableCellLoyToSGW('17:45'),
                          buildTableCellLoyToSGW('18:40'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('17:30'),
                          buildTableCellSGWtoLoy('19:15'),
                          buildTableCellLoyToSGW('18:15'),
                          buildTableCellLoyToSGW('19:15'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('18:00'),
                          buildTableCellSGWtoLoy('19:50'),
                          buildTableCellLoyToSGW('18:45'),
                          buildTableCellLoyToSGW('19:50'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('18:30'),
                          buildTableCellSGWtoLoy('--:--'),
                          buildTableCellLoyToSGW('19:15'),
                          buildTableCellLoyToSGW('--:--'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('19:00'),
                          buildTableCellSGWtoLoy('--:--'),
                          buildTableCellLoyToSGW('19:45'),
                          buildTableCellLoyToSGW('--:--'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('19:30'),
                          buildTableCellSGWtoLoy('--:--'),
                          buildTableCellLoyToSGW('20:00'),
                          buildTableCellLoyToSGW('--:--'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('20:00'),
                          buildTableCellSGWtoLoy('--:--'),
                          buildTableCellLoyToSGW('20:10'),
                          buildTableCellLoyToSGW('--:--'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('20:30'),
                          buildTableCellSGWtoLoy('--:--'),
                          buildTableCellLoyToSGW('20:30'),
                          buildTableCellLoyToSGW('--:--'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('20:45'),
                          buildTableCellSGWtoLoy('--:--'),
                          buildTableCellLoyToSGW('21:00'),
                          buildTableCellLoyToSGW('--:--'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('21:05'),
                          buildTableCellSGWtoLoy('--:--'),
                          buildTableCellLoyToSGW('21:25'),
                          buildTableCellLoyToSGW('--:--'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('21:30'),
                          buildTableCellSGWtoLoy('--:--'),
                          buildTableCellLoyToSGW('21:45'),
                          buildTableCellLoyToSGW('--:--'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('22:00'),
                          buildTableCellSGWtoLoy('--:--'),
                          buildTableCellLoyToSGW('22:00'),
                          buildTableCellLoyToSGW('--:--'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('22:30'),
                          buildTableCellSGWtoLoy('--:--'),
                          buildTableCellLoyToSGW('22:30'),
                          buildTableCellLoyToSGW('--:--'),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildTableCellSGWtoLoy('23:00'),
                          buildTableCellSGWtoLoy('--:--'),
                          buildTableCellLoyToSGW('23:00'),
                          buildTableCellLoyToSGW('--:--'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Builds the button to highlight the shuttle bus schedule departure hours from SGW to Loyola
  Container buildTitleTableCellSGWToLoy(String cellDisplay) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      child: Center(
        child: RaisedButton(
          padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
          color: Colors.lightGreen[400],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
          onPressed: () {
            setState(
              () {
                if (!isSelectedSGWToLoy)
                  isSelectedSGWToLoy = !isSelectedSGWToLoy;
                if (isSelectedLoyToSGW)
                  isSelectedLoyToSGW = !isSelectedLoyToSGW;
              },
            );
          },
          child: Text(
            cellDisplay,
            style: GoogleFonts.raleway(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Builds the button to highlight the shuttle bus schedule departure hours from Loyola to SGW
  Container buildTitleTableCellLoyToSGW(String cellDisplay) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      child: Center(
        child: RaisedButton(
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          color: Colors.lightGreen[400],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
          onPressed: () {
            setState(
              () {
                if (!isSelectedLoyToSGW)
                  isSelectedLoyToSGW = !isSelectedLoyToSGW;
                if (isSelectedSGWToLoy)
                  isSelectedSGWToLoy = !isSelectedSGWToLoy;
              },
            );
          },
          child: Text(
            cellDisplay,
            style: GoogleFonts.raleway(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Builds the table cell to display the departure of the shuttle bus from SGW to Loyola
  Container buildTableCellSGWtoLoy(String cellDisplay) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: AnimatedDefaultTextStyle(
          style: isSelectedSGWToLoy
              ? GoogleFonts.raleway(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )
              : GoogleFonts.raleway(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
          duration: const Duration(milliseconds: 200),
          child: Text(
            cellDisplay,
          ),
        ),
      ),
    );
  }

  // Builds the table cell to display the departure of the shuttle bus from Loyola to SGW
  Container buildTableCellLoyToSGW(String cellDisplay) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: AnimatedDefaultTextStyle(
          style: isSelectedLoyToSGW
              ? GoogleFonts.raleway(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )
              : GoogleFonts.raleway(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
          duration: const Duration(milliseconds: 200),
          child: Text(
            cellDisplay,
          ),
        ),
      ),
    );
  }
}
