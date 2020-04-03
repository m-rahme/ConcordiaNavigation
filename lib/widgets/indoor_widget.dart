import 'package:concordia_navigation/models/slide.dart';
import 'package:concordia_navigation/services/change_later.dart';
import 'package:concordia_navigation/services/painter_service.dart';
import 'package:concordia_navigation/services/painters.dart';
import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IndoorWidget extends StatelessWidget {
  final int index;
  IndoorWidget(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: LayoutBuilder(
        builder: (_, constraints) => Zoom(
          initZoom: 0.0,
          zoomSensibility: 1.0,
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
                Painters.painters[index],
//                CustomPaint(
//                  painter: PainterService(),
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
