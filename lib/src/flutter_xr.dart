// filepath: lib/src/flutter_xr.dart

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_xr/flutter_xr.dart';
import 'package:flutter_xr/src/pigeon/pigeon.g.dart';

import '../flutter_xr_platform_interface.dart';
import 'XRCallbackHandler.dart';

abstract class FlutterXrInterface {
  Future<bool> isSpatialUiEnabled();

  Future<void> requestFullSpaceMode();

  Future<void> requestHomeSpaceMode();

  Future<Map<String, WidgetBuilder>> registerRoutes({
    Orbiter leftOrbit,
    Orbiter rightOrbit,
    Orbiter topOrbit,
    Orbiter bottomOrbit,
  });

  void listenEvents(ValueChanged<String> listen);
}

class FlutterXr implements FlutterXrInterface {
  FlutterXRPigeon flutterXRPigeon = FlutterXRPigeon();

  @override
  Future<bool> isSpatialUiEnabled() {
    return flutterXRPigeon.isSpatialUiEnabled();
  }

  @override
  Future<void> requestFullSpaceMode() async {
    await flutterXRPigeon.requestFullSpaceMode();
  }

  @override
  Future<void> requestHomeSpaceMode() async {
    await flutterXRPigeon.requestHomeSpaceMode();
  }

  @override
  void listenEvents(ValueChanged<String> listen) {
    FlutterXRPigeonCallbacks.setUp(
      XRCallbackHandler((event) {
        print("FlutterXrP FlutterXr listenEvents $event");
        listen(event);
      }),
    );
  }

  @override
  Future<Map<String, WidgetBuilder>> registerRoutes({
    Orbiter? leftOrbit,
    Orbiter? rightOrbit,
    Orbiter? topOrbit,
    Orbiter? bottomOrbit,
  }) async {
    Map<String, OrbiterConfig> orbiterConfig = {};
    Map<String, WidgetBuilder> appRoutes = {};

    if (leftOrbit != null) {
      appRoutes["/left"] = (_) => leftOrbit!.child;
      orbiterConfig["/left"] = OrbiterConfig(
        contentEdge: leftOrbit!.contentEdge.name,
        alignment: leftOrbit!.alignment.name,
        orbiterOffsetType: leftOrbit!.orbiterOffsetType.name,
        width: leftOrbit!.width,
        height: leftOrbit!.height,
      );
    }
    if (rightOrbit != null) {
      appRoutes["/right"] = (_) => rightOrbit!.child;
      orbiterConfig["/right"] = OrbiterConfig(
        contentEdge: rightOrbit!.contentEdge.name,
        alignment: rightOrbit!.alignment.name,
        orbiterOffsetType: rightOrbit!.orbiterOffsetType.name,
        width: rightOrbit!.width,
        height: rightOrbit!.height,
      );
    }
    if (topOrbit != null) {
      appRoutes["/top"] = (_) => topOrbit!.child;
      orbiterConfig["/top"] = OrbiterConfig(
        contentEdge: topOrbit!.contentEdge.name,
        alignment: topOrbit!.alignment.name,
        orbiterOffsetType: topOrbit!.orbiterOffsetType.name,
        width: topOrbit!.width,
        height: topOrbit!.height,
      );
    }
    if (bottomOrbit != null) {
      appRoutes["/bottom"] = (_) => bottomOrbit!.child;
      orbiterConfig["/bottom"] = OrbiterConfig(
        contentEdge: bottomOrbit!.contentEdge.name,
        alignment: bottomOrbit!.alignment.name,
        orbiterOffsetType: bottomOrbit!.orbiterOffsetType.name,
        width: bottomOrbit!.width,
        height: bottomOrbit!.height,
      );
    }

    await flutterXRPigeon.registerRoutes(orbiterConfig);
    return appRoutes;
  }
}
