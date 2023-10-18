import 'package:flutter/material.dart';

class DrawingPoint {
  Offset startingPoint;
  ArrowPoint? arrowPoint;
  DrawingPoint({required this.startingPoint, this.arrowPoint});

  DrawingPoint copyWith({Offset? startingPoint, ArrowPoint? arrowPoint}) {
    return DrawingPoint(
      startingPoint: startingPoint ?? this.startingPoint,
      arrowPoint: arrowPoint ?? this.arrowPoint,
    );
  }
}

class ArrowPoint {
  final Rect boundingBox;
  final List<Offset> arrowLIne;
  final Offset leftTipPoint;
  final Offset rightTipPoint;
  final bool selected;
  final bool hovered;
  ArrowPoint({
    required this.boundingBox,
    required this.arrowLIne,
    required this.leftTipPoint,
    required this.rightTipPoint,
    this.selected = false,
    this.hovered = false,
  });

  ArrowPoint copyWith({
    List<Offset>? arrowLIne,
    Offset? leftTipPoint,
    Offset? rightTipPoint,
    bool? selected,
    bool? hovered,
    Rect? boundingBox,
  }) {
    return ArrowPoint(
      boundingBox: boundingBox ?? this.boundingBox,
      arrowLIne: arrowLIne ?? this.arrowLIne,
      leftTipPoint: leftTipPoint ?? this.leftTipPoint,
      rightTipPoint: rightTipPoint ?? this.rightTipPoint,
      selected: selected ?? this.selected,
      hovered: hovered ?? this.hovered,
    );
  }
}
