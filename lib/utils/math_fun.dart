import 'dart:math' as math;

import 'package:flutter/material.dart';

class MathFun {
  static List<List<double>> conventionalAngles = [
    [0, 180], // make y as zero
    [90, -90] // make x as zero
  ];
  static double angleThreshold = 0.5;
  static double findAngle({
    required Offset startingPoint,
    required Offset endingPoint,
    bool inDegrees = true,
  }) {
    double angle = math.atan2(
      (endingPoint.dy - startingPoint.dy),
      (endingPoint.dx - startingPoint.dx),
    );
    if (inDegrees) {
      angle = getDegree(angle);
    }
    return angle;
  }

  static double getDegree(double radians) => (radians * 180) / math.pi;
  static double getRadians(double angle) => (angle * math.pi) / 180;

  static Offset getConventionalOffset({
    required double angle,
    required Offset existingOffset,
    required Size canvasSize,
  }) {
    bool isNearXCorr = conventionalAngles.first
        .where((element) => (element - angle).abs() < angleThreshold)
        .isNotEmpty;
    bool isNearYCorr = conventionalAngles.last
        .where((element) => (element - angle).abs() < angleThreshold)
        .isNotEmpty;
    if (isNearYCorr) {
      existingOffset = Offset(canvasSize.width / 2, existingOffset.dy);
    }
    if (isNearXCorr) {
      existingOffset = Offset(existingOffset.dx, canvasSize.height / 2);
    }
    return existingOffset;
  }

  static Offset getPointWithAngleWithDistance({
    required double degrees,
    required double distance,
    required Offset offset,
  }) {
    Offset newPoint = Offset(
      offset.dx + distance * math.cos(getRadians(degrees)),
      offset.dy + distance * math.sin(getRadians(degrees)),
    );
    return newPoint;
  }

  static Offset getCenterPoint({
    required Offset start,
    required Offset end,
  }) {
    return (Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2));
  }

  static double getPointsDistance({
    required Offset start,
    required Offset end,
  }) {
    return (end - start).distance.abs();
  }

  static Path getBoundingPath({
    required List<Offset> boundingPoints,
  }) {
    return (Path()
      ..addPolygon(
        boundingPoints,
        true,
      ));
  }

  static Offset findPerpendicularPoint(Offset originalPoint) {
    double newX = originalPoint.dy; // Swap x and y
    double newY = -originalPoint.dx; // Negate one of the coordinates

    return Offset(newX, newY);
  }
}
