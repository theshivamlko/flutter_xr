import 'package:flutter/material.dart';
import 'package:flutter_xr/src/pigeon/pigeon.g.dart' show OrbiterConfig;

import '../flutter_xr.dart';

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

/*
class FlutterXRWidget extends StatelessWidget {
  final Orbiter? leftOrbit;
  final Orbiter? rightOrbit;
  final Orbiter? topOrbit;
  final Orbiter? bottomOrbit;
  final Widget mainBody;
  final FlutterXr flutterXr;

  FlutterXRWidget({
    super.key,
    required this.mainBody,
    required this.flutterXr,
    this.topOrbit,
    this.bottomOrbit,
    this.leftOrbit,
    this.rightOrbit,
  });

  final Map<String, OrbiterConfig> routes = {};

  @override
  Widget build(BuildContext context) {
    if (leftOrbit != null) {
      routes["/left"] = OrbiterConfig(
        contentEdge: leftOrbit!.contentEdge.name,
        alignment: leftOrbit!.alignment.name,
        orbiterOffsetType: leftOrbit!.orbiterOffsetType.name,
        width: leftOrbit!.width,
        height: leftOrbit!.height,
      );
    }
    if (rightOrbit != null) {
      routes["/right"] = OrbiterConfig(
        contentEdge: rightOrbit!.contentEdge.name,
        alignment: rightOrbit!.alignment.name,
        orbiterOffsetType: rightOrbit!.orbiterOffsetType.name,
        width: rightOrbit!.width,
        height: rightOrbit!.height,
      );
    }
    if (topOrbit != null) {
      routes["/top"] = OrbiterConfig(
        contentEdge: topOrbit!.contentEdge.name,
        alignment: topOrbit!.alignment.name,
        orbiterOffsetType: topOrbit!.orbiterOffsetType.name,
        width: topOrbit!.width,
        height: topOrbit!.height,
      );
    }
    if (bottomOrbit != null) {
      routes["/bottom"] = OrbiterConfig(
        contentEdge: bottomOrbit!.contentEdge.name,
        alignment: bottomOrbit!.alignment.name,
        orbiterOffsetType: bottomOrbit!.orbiterOffsetType.name,
        width: bottomOrbit!.width,
        height: bottomOrbit!.height,
      );
    }
    print("FlutterXRWidget routes $routes");

    flutterXr.registerRoutes(routes);

    return MaterialApp(
      routes: {
        '/': (_) => mainBody,
        if (leftOrbit != null) '/left': (_) => leftOrbit!.child,
        if (rightOrbit != null) '/right': (_) => rightOrbit!.child,
        if (topOrbit != null) '/top': (_) => topOrbit!.child,
        if (bottomOrbit != null) '/bottom': (_) => bottomOrbit!.child,
      },
    );
  }
}
*/
