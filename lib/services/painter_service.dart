import 'package:concordia_navigation/services/change_later.dart';
import 'package:flutter/material.dart';

class PainterService extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3.0;
    int end = LoadBuildingInfo.xRoomList.length - 1;

    var path = Path();

    path.moveTo((940 * LoadBuildingInfo.xRoomList[0]) / 1000,
        (862 * LoadBuildingInfo.yRoomList[0]) / 920);
    for (int i = 0; i < LoadBuildingInfo.xRoomList.length; i++) {
      path.lineTo((940 * LoadBuildingInfo.xNearList[i]) / 1000,
          (862 * LoadBuildingInfo.yNearList[i]) / 920);
    }
    path.lineTo((940 * LoadBuildingInfo.xRoomList[end]) / 1000,
        (862 * LoadBuildingInfo.yRoomList[end]) / 920);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
