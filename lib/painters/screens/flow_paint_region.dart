import 'package:flowd/painters/flow_painter.dart';
import 'package:flowd/painters/model/drawing_points.dart';
import 'package:flowd/utils/math_fun.dart';
import 'package:flowd/utils/render_box_fun.dart';
import 'package:flutter/material.dart';

class FlowPaintRegion extends StatefulWidget {
  const FlowPaintRegion({super.key});

  @override
  State<FlowPaintRegion> createState() => _FlowPaintRegionState();
}

class _FlowPaintRegionState extends State<FlowPaintRegion> {
  List<DrawingArrowPoints> drawingPoints = [];
  Offset? hoverPoint;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          hoverPoint = renderBoxPosition(
            event.position,
            context,
          );
        });
      },
      child: GestureDetector(
        onTapDown: (details) {
          setState(() {
            if (hoverPoint != null) {
              Offset tapPoint = renderBoxPosition(
                details.globalPosition,
                context,
              );
              ArrowPoint? arrowPoint;
              if (drawingPoints.isNotEmpty) {
                Offset startingPoint = drawingPoints.last.startingPoint;
                double currentAngle = MathFun.findAngle(
                  startingPoint: startingPoint,
                  endingPoint: tapPoint,
                );
                double currentLeftAngle = currentAngle - 150;
                double currentRightAngle = currentAngle + 150;
                Offset endingLeftOne = MathFun.getPointWithAngleWithDistance(
                  degrees: currentLeftAngle,
                  distance: 20,
                  offset: tapPoint,
                );
                Offset endingRightOne = MathFun.getPointWithAngleWithDistance(
                  degrees: currentRightAngle,
                  distance: 20,
                  offset: tapPoint,
                );
                arrowPoint = ArrowPoint(
                  arrowLIne: [
                    startingPoint,
                    tapPoint,
                  ],
                  leftTipPoint: endingLeftOne,
                  rightTipPoint: endingRightOne,
                );
              }
              drawingPoints.add(
                DrawingArrowPoints(
                  startingPoint: tapPoint,
                  arrowPoint: arrowPoint,
                ),
              );
            }
          });
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: FlowPainter(
            drawingPoints: drawingPoints,
            hoverPoint: hoverPoint,
          ),
        ),
      ),
    );
  }
}
