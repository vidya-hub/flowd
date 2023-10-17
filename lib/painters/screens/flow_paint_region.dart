import 'package:flowd/painters/flow_painter.dart';
import 'package:flowd/providers/paint_provider.dart';
import 'package:flowd/utils/render_box_fun.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlowPaintRegion extends StatefulWidget {
  const FlowPaintRegion({super.key});

  @override
  State<FlowPaintRegion> createState() => _FlowPaintRegionState();
}

class _FlowPaintRegionState extends State<FlowPaintRegion> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PaintProvider>(builder: (
      context,
      provider,
      _,
    ) {
      return MouseRegion(
        onHover: (event) {
          provider.setHoverPoint = renderBoxPosition(
            event.position,
            context,
          );
        },
        child: GestureDetector(
          onTapDown: (details) {
            Offset tapPoint = renderBoxPosition(
              details.globalPosition,
              context,
            );
            provider.addPoint = tapPoint;
          },
          child: CustomPaint(
            size: Size.infinite,
            painter: FlowPainter(
              provider: provider,
            ),
          ),
        ),
      );
    });
  }
}
