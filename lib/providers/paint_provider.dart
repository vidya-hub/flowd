import 'package:flowd/painters/model/drawing_points.dart';
import 'package:flowd/utils/enumns.dart';
import 'package:flowd/utils/math_fun.dart';
import 'package:flowd/utils/painter_fun.dart';
import 'package:flutter/material.dart';

class PaintProvider extends ChangeNotifier {
  PaintMode _paintMode = PaintMode.line;
  List<DrawingPoint> _drawingPoints = [];
  PaintMode get paintMode => _paintMode;
  Offset? _hoverPoint;
  Offset? get hoverPoint => _hoverPoint;
  int selectedArrows = 0;

  double boundingBoxHeight = 10;
  set setHoverPoint(Offset? hPoint) {
    _hoverPoint = hPoint;
    // handle hover for selection
    if (_paintMode == PaintMode.select && _hoverPoint != null) {
      for (var i = 0; i < _drawingPoints.length; i++) {
        DrawingPoint point = _drawingPoints[i];
        if (point.arrowPoint != null) {
          bool isInBoundingBox = PainterFun.inBoundingBox(
            boundingBox: point.arrowPoint!.boundingBox,
            hoverPoint: _hoverPoint!,
          );
          if (point.arrowPoint != null) {
            _drawingPoints[i] = point.copyWith(
              arrowPoint: point.arrowPoint!.copyWith(hovered: isInBoundingBox),
            );
          }
        }
      }
    }
    notifyListeners();
  }

  void deleteSelected() {
    var drawingPoints = [..._drawingPoints];
    drawingPoints.removeWhere((element) =>
        element.arrowPoint != null && element.arrowPoint!.selected);
    _drawingPoints = drawingPoints;
    notifyListeners();
  }

  set setPaintMode(PaintMode paintMode) {
    _paintMode = paintMode;
    notifyListeners();
  }

  List<DrawingPoint> get drawingPoints => _drawingPoints;
  set addPoint(Offset endOffSet) {
    List<DrawingPoint> dPoints = [..._drawingPoints];

    if (_paintMode == PaintMode.line) {
      ArrowPoint? arrowPoint;
      if (drawingPoints.isNotEmpty) {
        Offset startingPoint = drawingPoints.last.startingPoint;
        double currentAngle = MathFun.findAngle(
          startingPoint: startingPoint,
          endingPoint: endOffSet,
        );
        double currentLeftAngle = currentAngle - 150;
        double currentRightAngle = currentAngle + 150;

        Offset endingLeftOne = MathFun.getPointWithAngleWithDistance(
          degrees: currentLeftAngle,
          distance: 20,
          offset: endOffSet,
        );
        Offset endingRightOne = MathFun.getPointWithAngleWithDistance(
          degrees: currentRightAngle,
          distance: 20,
          offset: endOffSet,
        );

        // TODO: bounding box points gen

        Offset boundingBoxLeftTopPoint = MathFun.getPointWithAngleWithDistance(
          degrees: currentAngle - 90,
          distance: boundingBoxHeight,
          offset: startingPoint,
        );
        Offset boundingBoxBottomPoint = MathFun.getPointWithAngleWithDistance(
          degrees: currentAngle + 90,
          distance: boundingBoxHeight,
          offset: startingPoint,
        );
        Offset boundingBoxRightTopPoint = MathFun.getPointWithAngleWithDistance(
          degrees: currentAngle - 90,
          distance: boundingBoxHeight,
          offset: endOffSet,
        );
        Offset boundingBoxRightBottomPoint =
            MathFun.getPointWithAngleWithDistance(
          degrees: currentAngle + 90,
          distance: boundingBoxHeight,
          offset: endOffSet,
        );
        List<Offset> boundingPoints = [
          boundingBoxLeftTopPoint,
          boundingBoxBottomPoint,
          boundingBoxRightBottomPoint,
          boundingBoxRightTopPoint,
        ];
        arrowPoint = ArrowPoint(
          boundingBoxPoints: boundingPoints,
          boundingBox: MathFun.getBoundingPath(
            boundingPoints: boundingPoints,
          ),
          arrowLIne: [
            startingPoint,
            endOffSet,
          ],
          leftTipPoint: endingLeftOne,
          rightTipPoint: endingRightOne,
        );
      }
      dPoints.add(
        DrawingPoint(
          startingPoint: endOffSet,
          arrowPoint: arrowPoint,
        ),
      );
      _drawingPoints = dPoints;
      notifyListeners();
    } else if (_paintMode == PaintMode.select) {
      _drawingPoints = _drawingPoints.map((element) {
        if (element.arrowPoint != null && element.arrowPoint!.hovered) {
          element = element.copyWith(
            arrowPoint: element.arrowPoint!.copyWith(
              selected: true,
            ),
          );
        }
        return element;
      }).toList();
    }
  }

  void onSelectionDrag(Offset dragOffset) {
    if (_paintMode == PaintMode.select) {
      print(dragOffset);
    }
  }

  ArrowPoint? chooseArrow(
    Offset hoverOffset,
  ) {
    DrawingPoint drawingData = drawingPoints.firstWhere(
      (point) => PainterFun.inBoundingBox(
        boundingBox: point.arrowPoint!.boundingBox,
        hoverPoint: hoverOffset,
      ),
    );
    return drawingData.arrowPoint;
  }

  void onSelectionHover(
    Offset hoverOffset, {
    bool isSelect = false,
  }) {
    if (drawingPoints.isNotEmpty) {
      List<DrawingPoint> drawingData = drawingPoints.map((point) {
        if (point.arrowPoint != null) {
          bool inHoverRegion = PainterFun.inBoundingBox(
            boundingBox: point.arrowPoint!.boundingBox,
            hoverPoint: hoverOffset,
          );
          point = point.copyWith(
            arrowPoint: (isSelect)
                ? point.arrowPoint!.copyWith(
                    selected: inHoverRegion,
                  )
                : point.arrowPoint!.copyWith(
                    hovered: inHoverRegion,
                  ),
          );
        }
        return point;
      }).toList();
      _drawingPoints = drawingData;
      notifyListeners();
    }
  }
}
