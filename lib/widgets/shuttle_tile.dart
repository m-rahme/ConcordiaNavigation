import 'package:flutter/material.dart';
import 'package:concordia_navigation/models/size_config.dart';
import 'package:concordia_navigation/models/shuttle_data.dart';
import 'package:provider/provider.dart';

class ShuttleTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var response1 = "via Shuttle Bus";
    if (Provider.of<ShuttleData>(context).getNextShuttle() ==
        "Check Shuttle Schedule for More Info") {
      response1 = "No Shuttle Bus Until Monday";
    }
    return ListTile(
      contentPadding: EdgeInsets.only(
          left: SizeConfig.safeBlockHorizontal * 8.0,
          right: SizeConfig.safeBlockHorizontal * 0.0,
          top: SizeConfig.safeBlockHorizontal * 4.0),
      leading: IconButton(
        icon: new Image.asset('assets/logo.png'),
        tooltip: 'Concordia',
        onPressed: () {},
        iconSize: 45.0,
      ),
      title: Text(response1),
      subtitle: Text(Provider.of<ShuttleData>(context).getNextShuttle()),
    );
  }
}
