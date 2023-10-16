import 'package:flutter/material.dart';

class DrawingArrowPoints {
  Offset startingPoint;
  ArrowPoint? arrowPoint;
  DrawingArrowPoints({
    required this.startingPoint,
    this.arrowPoint,
  });
}

class ArrowPoint {
  final List<Offset> arrowLIne;
  final Offset leftTipPoint;
  final Offset rightTipPoint;
  ArrowPoint({
    required this.arrowLIne,
    required this.leftTipPoint,
    required this.rightTipPoint,
  });
}
