import 'package:concordia_navigation/models/itinerary.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';
import 'package:google_fonts/google_fonts.dart';

//This widget is where the directions will be displayed in the directions page.
class ListViewWidget extends StatefulWidget {
  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  @override
  Widget build(BuildContext context) {
    ///Fetch transit mode
    final _mode = Provider.of<MapData>(context);

    ///Memoizer used to optimize the List Builder
    final AsyncMemoizer _memoizer = AsyncMemoizer();
    _fetchData() {
      return _memoizer.runOnce(() async {
        await Future.delayed(Duration(seconds: 1));
        return Itinerary(
          Provider.of<MapData>(context, listen: false).getStart,
          Provider.of<MapData>(context, listen: false).getEnd,
          _mode.getMode,
        ).parseJson();
      });
    }

    return Expanded(
      child: FutureBuilder(
          future: _fetchData(),
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
                if (itinerary.hasError)
                  return Container(
                    child: Text("Error Occured"),
                  );

                // Completed with data
                return ListView.builder(
                  padding: EdgeInsets.only(
                      right: SizeConfig.safeBlockHorizontal * 0),
                  itemCount: itinerary.data.length,
                  itemBuilder: (BuildContext context, index) {
                    String key = itinerary.data.keys.elementAt(index);
                    return Container(
                      decoration: BoxDecoration(
                        color: offWhiteColor,
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: lightGreyColor),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 5.0,
                            right: SizeConfig.safeBlockHorizontal * 5.0),
                        leading: Icon(Icons.subdirectory_arrow_right),
                        title: Text(
                          "$key",
                          style: GoogleFonts.raleway(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                        subtitle: Text(
                          "Time: " +
                              "${itinerary.data[key].keys.toString().replaceAll(RegExp(r"\(|\)"), "")}" +
                              "  " +
                              "Distance: " +
                              "${itinerary.data[key].values.toString().replaceAll(RegExp(r"\(|\)"), "")}",
                          style: GoogleFonts.raleway(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: blackColor,
                          ),
                        ),
                      ),
                    );
                  },
                );
            }
          }),
    );
  }
}
