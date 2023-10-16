import 'package:flowd/extensions/offset_extensions.dart';
import 'package:flowd/painters/model/drawing_points.dart';
import 'package:flowd/utils/math_fun.dart';
import 'package:flutter/material.dart';

class PainterFun {
  static Paint linePaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.green
    ..strokeWidth = 3;
  static Paint coOrdinatePaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.lightGreen
    ..strokeWidth = 0.3;
  static Paint pointPaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.red
    ..strokeWidth = 5;

  static void drawBackGround(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    canvas.drawLine(
      Offset(size.width / 2, 0).os(size),
      Offset(size.width / 2, size.height).os(size),
      coOrdinatePaint,
    );

    canvas.drawLine(
      Offset(0, size.height / 2).os(size),
      Offset(size.width, size.height / 2).os(size),
      coOrdinatePaint,
    );
  }

  static void drawArrowLine({
    required Canvas canvas,
    required Size size,
    ArrowPoint? arrowPoint,
  }) {
    if (arrowPoint != null) {
      canvas.drawLine(
        arrowPoint.arrowLIne.first.os(size),
        arrowPoint.arrowLIne.last.os(size),
        linePaint,
      );
      canvas.drawLine(
        arrowPoint.arrowLIne.last.os(size),
        arrowPoint.leftTipPoint.os(size),
        linePaint,
      );
      canvas.drawLine(
        arrowPoint.arrowLIne.last.os(size),
        arrowPoint.rightTipPoint.os(size),
        linePaint,
      );
    }
  }

  static void drawRotatePointer({
    required Canvas canvas,
    required Offset startingPoint,
    required Offset endingPoint,
  }) {
    double currentAngle = MathFun.findAngle(
      startingPoint: startingPoint,
      endingPoint: endingPoint,
    );
    double distance = (endingPoint - startingPoint).distance;
    double currentLeftAngle = currentAngle - 150;
    double currentRightAngle = currentAngle + 150;
    Offset endingOne = MathFun.getPointWithAngleWithDistance(
      degrees: currentAngle,
      distance: distance,
      offset: startingPoint,
    );
    Offset endingLeftOne = MathFun.getPointWithAngleWithDistance(
      degrees: currentLeftAngle,
      distance: 20,
      offset: endingOne,
    );
    Offset endingRightOne = MathFun.getPointWithAngleWithDistance(
      degrees: currentRightAngle,
      distance: 20,
      offset: endingOne,
    );
    canvas.drawCircle(startingPoint, 3, pointPaint);
    canvas.drawCircle(endingOne, 3, pointPaint);
    canvas.drawLine(
      startingPoint,
      endingOne,
      linePaint,
    );
    canvas.drawLine(
      endingOne,
      endingLeftOne,
      linePaint,
    );
    canvas.drawLine(
      endingOne,
      endingRightOne,
      linePaint,
    );
  }
}
