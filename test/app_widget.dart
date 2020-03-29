import 'package:concordia_navigation/main.dart';
import 'package:concordia_navigation/models/user_location.dart';
import 'package:concordia_navigation/providers/buildings_data.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/providers/shuttle_data.dart';
import 'package:concordia_navigation/services/location_service.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Widget appWidget({MapData mapData}) {

  Widget userLocationProvider = StreamProvider<UserLocation>(
    create: (context) => LocationService.getInstance().stream,
    initialData: UserLocation.sgw(),
  );

  Widget mapDataProvider = ChangeNotifierProvider<MapData>(
    create: (context) => MapData(),
  );

  Widget buildingsDataProvider = ChangeNotifierProvider<BuildingsData>(
    create: (context) => BuildingsData(),
  );

  Widget shuttleData = ChangeNotifierProvider<ShuttleData>(
    create: (_) => ShuttleData(),
  );

  if(mapData != null) {
    mapDataProvider = ChangeNotifierProvider<MapData>.value(value: mapData);
  }

  return MediaQuery(
    data: new MediaQueryData(),
    child: MultiProvider(
      providers: [
        userLocationProvider,
        mapDataProvider,
        buildingsDataProvider,
        shuttleData
      ],
      child: AppTestWidget(),
    ),
  );
}

class AppTestWidget extends StatelessWidget {
  AppTestWidget();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return App();
  }
}
