import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:concordia_navigation/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class DirectionsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Map<String, Map<String, String>>> _fetchMoreData() async {
      Map<String, Map<String, String>> test =
          Provider.of<MapData>(context, listen: false)?.itinerary?.itinerary;
      await Future.delayed(Duration(seconds: 1));
      return Future.value(test);
    }

    return FutureBuilder(
        future: _fetchMoreData(),
        builder: (context, AsyncSnapshot itinerary) {
          switch (itinerary.connectionState) {
            // Uncompleted State
            case ConnectionState.none:
              return new Text('Error');
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              // Completed with error
              if (itinerary.hasError) {
                return Container(
                  child: Text("Error Occured"),
                );
              }

              // Completed with data
              return Visibility(
                visible: itinerary.data != null,
                child: AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  bottom:
                      Provider.of<MapData>(context).bottomSheetBottomPosition,
                  left: 0,
                  right: 0,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Provider.of<MapData>(context, listen: false)
                                  .toggleDrawer();
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              height: 80,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.location_on, size: 60),
                                    IconButton(
                                      icon: Icon(Icons.swap_horizontal_circle),
                                      onPressed: () {
                                        print("Test");
                                      },
                                    ),
                                    Icon(Icons.school, size: 50),
                                    Text("SGW",
                                        style: GoogleFonts.raleway(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w700,
                                          color: constants.blackColor,
                                        )),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        Provider.of<MapData>(context,
                                                listen: false)
                                            .itinerary = null;
                                      },
                                    ),
                                  ]),
                            ),
                          ),
                          Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                height: SizeConfig.blockSizeVertical * 60,
                                width: SizeConfig.screenWidth * 0.9,
                                child: ListView.builder(
                                    padding: EdgeInsets.only(
                                        right:
                                            SizeConfig.safeBlockHorizontal * 0),
                                    itemCount: itinerary.data?.length?? 0,
                                    itemBuilder: (BuildContext context, index) {
                                      String key =
                                          itinerary.data.keys.elementAt(index);
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: constants.offWhiteColor,
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.0,
                                                color:
                                                    constants.lightGreyColor),
                                          ),
                                        ),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5.0,
                                              right: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5.0),
                                          leading: Icon(
                                              Icons.subdirectory_arrow_right),
                                          title: Text(
                                            "$key",
                                            style: GoogleFonts.raleway(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w600,
                                              color: constants.blackColor,
                                            ),
                                          ),
                                          subtitle: Text(itinerary.data != null?
                                                "Time: " +
                                                    "${itinerary.data[key].keys.toString().replaceAll(RegExp(r"\(|\)"), "")}" +
                                                    "  " +
                                                    "Distance: " +
                                                    "${itinerary.data[key].values.toString().replaceAll(RegExp(r"\(|\)"), "")}": "Itinerary is null!",
                                            style: GoogleFonts.raleway(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400,
                                              color: constants.blackColor,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              );
          }
        });
  }
}
