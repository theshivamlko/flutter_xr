import 'package:flutter/material.dart';

enum ContentEdge { top, bottom, start, end }

enum OrbiterOffsetType { outerEdge, innerEdge }

enum Alignment {
  topStart,
  topCenter,
  topEnd,
  centerStart,
  center,
  centerEnd,
  bottomStart,
  bottomCenter,
  bottomEnd,
  top,
  centerVertically,
  bottom,
  start,
  centerHorizontally,
  end,
}

class Orbiter {
  Widget child;
  ContentEdge contentEdge;
  Alignment alignment;
  OrbiterOffsetType orbiterOffsetType;
  double? width;
  double? height;

  Orbiter(
    this.contentEdge,
    this.alignment,
    this.orbiterOffsetType,
    this.child, {
    this.height,
    this.width,
  });
}
