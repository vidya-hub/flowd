import 'package:flowd/painters/flow_painter.dart';
import 'package:flowd/painters/model/drawing_points.dart';
import 'package:flowd/utils/render_box_fun.dart';
import 'package:flutter/material.dart';

class FlowPaintRegion extends StatefulWidget {
  const FlowPaintRegion({super.key});

  @override
  State<FlowPaintRegion> createState() => _FlowPaintRegionState();
}

class _FlowPaintRegionState extends State<FlowPaintRegion> {
  List<DrawingPoints> drawingPoints = [];
  DrawingPoints? hoverPoint;
  Paint currentPainter = Paint()
    ..isAntiAlias = true
    ..color = Colors.red
    ..strokeWidth = 5;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          hoverPoint = DrawingPoints(
            points: renderBoxPosition(
              event.position,
              context,
            ),
            paint: currentPainter,
          );
        });
      },
      child: GestureDetector(
        onTapDown: (details) {
          setState(() {
            drawingPoints.add(
              DrawingPoints(
                points: renderBoxPosition(
                  details.globalPosition,
                  context,
                ),
                paint: currentPainter,
              ),
            );
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
