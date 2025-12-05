// filepath: lib/src/flutter_xr.dart

import 'package:flutter_xr/src/pigeon/pigeon.g.dart';

import '../flutter_xr_platform_interface.dart';

abstract class FlutterXrInterface {
  Future<bool> isSpatialUiEnabled();
}

class FlutterXr implements FlutterXrInterface {
  @override
  Future<bool> isSpatialUiEnabled() {
    return FlutterXRPigeon().isSpatialUiEnabled();
  }
}
