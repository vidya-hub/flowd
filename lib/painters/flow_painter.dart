// import 'dart:math' as math;

import 'package:flowd/extensions/offset_extensions.dart';
import 'package:flowd/painters/model/drawing_points.dart';
import 'package:flowd/utils/painter_fun.dart';
import 'package:flutter/material.dart';

class FlowPainter extends CustomPainter {
  List<DrawingArrowPoints> drawingPoints;

  Offset? hoverPoint;

  Paint linePaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.lightGreen
    ..strokeWidth = 50;

  Paint pointPaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.red
    ..strokeWidth = 5;
  Paint originPaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.blue;
  double pointRadius = 3;
  FlowPainter({
    this.drawingPoints = const [],
    this.hoverPoint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    PainterFun.drawBackGround(canvas, size);
    if (hoverPoint != null) {
      canvas.drawCircle(
        hoverPoint!.os(size),
        pointRadius,
        pointPaint,
      );
      if (drawingPoints.isNotEmpty) {
        canvas.drawLine(
          drawingPoints.last.startingPoint.os(size),
          hoverPoint!.os(size),
          linePaint..strokeWidth = 0.2,
        );
      }
      for (var i = 0; i < drawingPoints.length; i++) {
        canvas.drawCircle(
          drawingPoints[i].startingPoint.os(size),
          i == 0 ? 8 : pointRadius,
          i == 0 ? originPaint : pointPaint,
        );
        PainterFun.drawArrowLine(
          canvas: canvas,
          size: size,
          arrowPoint: drawingPoints[i].arrowPoint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
