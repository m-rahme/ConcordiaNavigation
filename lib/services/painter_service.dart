import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/node.dart';
import 'package:concordia_navigation/providers/indoor_data.dart';
import 'package:flutter/material.dart';

class PainterService extends CustomPainter {
  int index;
  PainterService(this.index);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3.0;
    String startLocation = "H980";
    String endLocation = "H961-26";

    List<Node> result = IndoorData.shortest.pathTo(startLocation, endLocation);

    Path path = Path();

    void drawPath() {
      for (Node node in result) {
        // get the indoor location with the same name
        IndoorLocation loc = IndoorData.indoors[node.name];
        if (node == result.first) {
          path.moveTo((940 * loc.room.x) / 1000, (862 * loc.room.y / 920));
        }
        path.lineTo((940 * loc.nearest.x) / 1000, (862 * loc.nearest.y / 920));
        if (node == result.last) {
          path.lineTo((940 * loc.room.x) / 1000, (862 * loc.room.y / 920));
        }
      }
    }

    if (startLocation.substring(0, 2) == endLocation.substring(0, 2)) {
      if (startLocation.substring(0, 2) == "H1") {
        if (index == 0) drawPath();
      }
      if (startLocation.substring(0, 2) == "H8") {
        if (index == 1) drawPath();
      }
      if (startLocation.substring(0, 2) == "H9") {
        if (index == 2) drawPath();
      }
      if (startLocation.substring(0, 2) == "MB") {
        if (index == 3) drawPath();
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
