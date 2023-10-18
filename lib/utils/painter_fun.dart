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
    // canvas.translate(size.width / 2, size.height / 2);

    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      coOrdinatePaint,
    );

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      coOrdinatePaint,
    );
  }

  static void drawArrowLine({
    required Canvas canvas,
    ArrowPoint? arrowPoint,
  }) {
    if (arrowPoint != null) {
      canvas.drawLine(
        arrowPoint.arrowLIne.first,
        arrowPoint.arrowLIne.last,
        (arrowPoint.hovered || arrowPoint.selected) ? pointPaint : linePaint,
      );
      canvas.drawLine(
        arrowPoint.arrowLIne.last,
        arrowPoint.leftTipPoint,
        (arrowPoint.hovered || arrowPoint.selected) ? pointPaint : linePaint,
      );
      canvas.drawLine(
        arrowPoint.arrowLIne.last,
        arrowPoint.rightTipPoint,
        (arrowPoint.hovered || arrowPoint.selected) ? pointPaint : linePaint,
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

  static bool inBoundingBox({
    required Rect boundingBox,
    required Offset hoverPoint,
  }) {
    return boundingBox.contains(hoverPoint);
  }
}
