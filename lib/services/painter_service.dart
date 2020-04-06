import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/node.dart';
import 'package:concordia_navigation/providers/indoor_data.dart';
import 'package:flutter/material.dart';

class PainterService extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3.0;

    List<Node> result = IndoorData.shortest.pathTo("H110", "exitMRH1");
    print(result);

    Path path = Path();
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
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
