// import 'dart:math' as math;
import 'dart:ui';

import 'package:flowd/painters/model/drawing_points.dart';
import 'package:flutter/material.dart';

class FlowPainter extends CustomPainter {
  List<DrawingPoints> drawingPoints;
  DrawingPoints? hoverPoint;

  Paint dottedPaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.lightGreen
    ..strokeWidth = 1;
  Paint endingHoverPoint = Paint()
    ..isAntiAlias = true
    ..color = Colors.red
    ..strokeWidth = 5;

  FlowPainter({
    this.drawingPoints = const [],
    this.hoverPoint,
  });
  @override
  void paint(Canvas canvas, Size size) {
    if (hoverPoint != null) {
      canvas.drawPoints(
        PointMode.points,
        [hoverPoint!.points],
        endingHoverPoint,
      );
    }
    if (drawingPoints.isNotEmpty) {
      Offset startingPoint = drawingPoints.last.points;
      Offset endingPoint = hoverPoint!.points;
      canvas.drawLine(startingPoint, endingPoint, dottedPaint);
    }
    for (var i = 0; i < drawingPoints.length; i++) {
      canvas.drawPoints(
        PointMode.points,
        [Offset(drawingPoints[i].points.dx, drawingPoints[i].points.dy)],
        drawingPoints[i].paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


/*
 double conventionalAngle = MathFun.findAngle(
  startingPoint: startingPoint,
  endingPoint: endingPoint,
);

Offset imaginaryCoordinate = Offset.fromDirection(
  MathFun.getRadians(conventionalAngle.getProperAngle),
  (endingPoint - startingPoint).distance,
);
canvas.drawLine(
  startingPoint,
  imaginaryCoordinate,
  endingHoverPoint,
);
 */