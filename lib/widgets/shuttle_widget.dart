import 'package:flutter/material.dart';
import '../storage/app_constants.dart' as constants;
import '../services/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'shuttle_tile.dart';

///Shuttle Widget at the bottom of the Directions Page.
class ShuttleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: constants.appColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
      height: SizeConfig.safeBlockVertical * 15,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Concordia Shuttle Bus",
                    style: GoogleFonts.raleway(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: constants.whiteColor,
                    ),
                  ),
                  InkWell(
                    key: Key("ViewSchedule"),
                    onTap: () {
                      Navigator.pushNamed(context, '/shuttle');
                    },
                    child: Text(
                      "View Schedule",
                      style: GoogleFonts.raleway(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: constants.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: constants.whiteColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                    ),
                    height: SizeConfig.safeBlockVertical * 15,
                    width: SizeConfig.safeBlockHorizontal * 100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 6.0),
                      child: ShuttleTile(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
