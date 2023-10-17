// import 'dart:math' as math;

import 'package:flowd/extensions/offset_extensions.dart';
import 'package:flowd/providers/paint_provider.dart';
import 'package:flowd/utils/enumns.dart';
import 'package:flowd/utils/painter_fun.dart';
import 'package:flutter/material.dart';

class FlowPainter extends CustomPainter {
  PaintProvider provider;

  Paint linePaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.lightGreen
    ..strokeWidth = 50;

  Paint pointPaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.red
    ..strokeWidth = 5;
  Paint rectPaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.red
    ..strokeWidth = 3
    ..style = PaintingStyle.stroke;
  Paint originPaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.blue
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;
  double pointRadius = 3;
  FlowPainter({required this.provider});

  @override
  void paint(Canvas canvas, Size size) {
    PainterFun.drawBackGround(canvas, size);
    if (provider.hoverPoint != null) {
      Offset hoverPoint = provider.hoverPoint!.os(size);
      if (provider.paintMode == PaintMode.line) {
        canvas.drawCircle(
          hoverPoint,
          pointRadius,
          pointPaint,
        );
      }
      if (provider.drawingPoints.isNotEmpty &&
          provider.paintMode == PaintMode.line) {
        canvas.drawLine(
          provider.drawingPoints.last.startingPoint.os(size),
          provider.hoverPoint!.os(size),
          linePaint..strokeWidth = 0.2,
        );
      }
      for (var i = 0; i < provider.drawingPoints.length; i++) {
        canvas.drawCircle(
          provider.drawingPoints[i].startingPoint.os(size),
          i == 0 ? 8 : pointRadius,
          i == 0 ? originPaint : pointPaint,
        );
        PainterFun.drawArrowLine(
          canvas: canvas,
          size: size,
          arrowPoint: provider.drawingPoints[i].arrowPoint,
        );
      }
      if (provider.paintMode == PaintMode.select) {
        if (provider.selectedArrow == null) {
          canvas.drawRect(
            Rect.fromCircle(
              center: hoverPoint,
              radius: 10,
            ),
            rectPaint,
          );
        } else {
          // canvas.dra
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
