import 'package:flutter/material.dart';

Offset renderBoxPosition(Offset globalPosition, BuildContext context) {
  RenderBox renderBox = context.findRenderObject() as RenderBox;
  return renderBox.globalToLocal(globalPosition);
}
