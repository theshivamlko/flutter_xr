// filepath: lib/src/flutter_xr.dart

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_xr/src/pigeon/pigeon.g.dart';

import '../flutter_xr_platform_interface.dart';
import 'XRCallbackHandler.dart';

abstract class FlutterXrInterface {
  Future<bool> isSpatialUiEnabled();

  Future<void> requestFullSpaceMode();

  Future<void> requestHomeSpaceMode();
  Future<void> setOrbitLayout();

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
  Future<void> setOrbitLayout() {

    throw UnimplementedError();
  }
}
