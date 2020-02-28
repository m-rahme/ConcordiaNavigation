import 'package:flutter/material.dart';
import 'package:concordia_navigation/models/size_config.dart';
import 'package:concordia_navigation/models/shuttle_data.dart';
import 'package:provider/provider.dart';

class ShuttleTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
          left: SizeConfig.safeBlockHorizontal * 8.0,
          right: SizeConfig.safeBlockHorizontal * 8.0),
      leading: IconButton(
        icon: new Image.asset('assets/logo.png'),
        tooltip: 'Concordia',
        onPressed: () {},
        iconSize: 45.0,
      ),
      title: Text("via Shuttle Bus"),
      subtitle: Text(Provider.of<ShuttleData>(context).getNextShuttle()),
    );
  }
}
