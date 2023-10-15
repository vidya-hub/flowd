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
  }) {
    double angle = math.atan2(
      (endingPoint.dy - startingPoint.dy),
      (endingPoint.dx - startingPoint.dx),
    );
    double conventionalAngle = getDegree(angle);
    return conventionalAngle;
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
}
