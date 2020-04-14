import '../../providers/map_data.dart';
import '../../storage/app_constants.dart' as constants;
import '../../services/size_config.dart';
import '../directions_list_widget.dart';
import '../outdoor/map_widget.dart';
import '../search_bars.dart';
import '../shuttle_widget.dart';
import '../transportation_mode_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Widget displaying the map
class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 18.0),
      controller: Provider.of<MapData>(context, listen: false).panelController,
      maxHeight: SizeConfig.safeBlockVertical * 85,
      minHeight: Provider.of<MapData>(context).itinerary == null
          ? SizeConfig.safeBlockVertical * 0
          : SizeConfig.safeBlockVertical * 24,
      defaultPanelState: PanelState.CLOSED,
      backdropEnabled: true,
      backdropOpacity: 0.3,
      parallaxEnabled: false,
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
      boxShadow: [
        BoxShadow(
          blurRadius: 20.0,
          color: constants.lightGreyColor.withOpacity(0.6),
        ),
      ],
      panel: Consumer<MapData>(
        builder: (context, mapData, child) => Column(
          children: <Widget>[
            TransportationModeWidget(),
            SearchBars(), // top row for transportation mode selection
            DirectionsList(), // list of directions
            ShuttleWidget(),
          ],
        ),
      ),
      body: MapWidget(),
    );
  }
}
