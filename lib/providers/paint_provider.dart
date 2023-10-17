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
  ArrowPoint? _selectedData;
  ArrowPoint? get selectedArrow => _selectedData;
  set setHoverPoint(Offset? hPoint) {
    _hoverPoint = hPoint;
    if (_paintMode == PaintMode.select) {
      // onSelectionHover(_hoverPoint!);
    }
    notifyListeners();
  }

  set setPaintMode(PaintMode paintMode) {
    _paintMode = paintMode;
    notifyListeners();
  }

  List<DrawingPoint> get drawingPoints => _drawingPoints;
  set addPoint(Offset offset) {
    List<DrawingPoint> dPoints = [..._drawingPoints];
    if (_paintMode == PaintMode.select) {
      _selectedData = chooseArrow(offset);
      notifyListeners();
      // onSelectionHover(
      //   offset,
      //   isSelect: true,
      // );
    }
    if (_paintMode == PaintMode.line) {
      ArrowPoint? arrowPoint;
      if (drawingPoints.isNotEmpty) {
        Offset startingPoint = drawingPoints.last.startingPoint;
        double currentAngle = MathFun.findAngle(
          startingPoint: startingPoint,
          endingPoint: offset,
        );
        double currentLeftAngle = currentAngle - 150;
        double currentRightAngle = currentAngle + 150;
        Offset endingLeftOne = MathFun.getPointWithAngleWithDistance(
          degrees: currentLeftAngle,
          distance: 20,
          offset: offset,
        );
        Offset endingRightOne = MathFun.getPointWithAngleWithDistance(
          degrees: currentRightAngle,
          distance: 20,
          offset: offset,
        );
        arrowPoint = ArrowPoint(
          arrowLIne: [
            startingPoint,
            offset,
          ],
          leftTipPoint: endingLeftOne,
          rightTipPoint: endingRightOne,
        );
      }
      dPoints.add(
        DrawingPoint(
          startingPoint: offset,
          arrowPoint: arrowPoint,
        ),
      );
      _drawingPoints = dPoints;
      notifyListeners();
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
    DrawingPoint drawingData =
        drawingPoints.firstWhere((point) => PainterFun.isPointBetween(
              startPoint: point.arrowPoint!.arrowLIne.first,
              endPoint: point.arrowPoint!.arrowLIne.last,
              hoverPoint: hoverOffset,
            ));
    return drawingData.arrowPoint;
  }

  void onSelectionHover(
    Offset hoverOffset, {
    bool isSelect = false,
  }) {
    if (drawingPoints.isNotEmpty) {
      List<DrawingPoint> drawingData = drawingPoints.map((point) {
        if (point.arrowPoint != null) {
          bool inHoverRegion = PainterFun.isPointBetween(
            startPoint: point.arrowPoint!.arrowLIne.first,
            endPoint: point.arrowPoint!.arrowLIne.last,
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
