import 'package:concordia_navigation/services/change_later.dart';
import 'package:concordia_navigation/services/painter_service.dart';
import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

const List<String> assetNames = <String>[
  'assets/Hall-8.svg',
];

class IndoorView extends StatefulWidget {
  @override
  _IndoorViewState createState() => _IndoorViewState();
}

class _IndoorViewState extends State<IndoorView> {
  final List<Widget> _painters = <Widget>[];

  @override
  void initState() {
    super.initState();
    for (String assetName in assetNames) {
      _painters.add(
        SvgPicture.asset(assetName),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: LayoutBuilder(
        builder: (_, constraints) => Zoom(
          backgroundColor: Colors.white,
          canvasColor: Colors.white,
          doubleTapZoom: true,
          enableScroll: true,
          opacityScrollBars: 0,
          width: 940,
          height: 862,
          child: Container(
            width: 1080,
            height: 1080,
            child: Stack(
              children: <Widget>[
                _painters[0],
                CustomPaint(
                  painter: PainterService(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
