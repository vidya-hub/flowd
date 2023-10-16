import 'package:flutter/material.dart';

extension OffsetX on Offset {
  Offset os(Size size) {
    return Offset(dx - size.width / 2, dy - size.height / 2);
  }
}
