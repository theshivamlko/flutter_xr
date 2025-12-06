// filepath: lib/src/flutter_xr.dart

import 'package:flutter_xr/src/pigeon/pigeon.g.dart';

import '../flutter_xr_platform_interface.dart';

abstract class FlutterXrInterface {
  Future<bool> isSpatialUiEnabled();
  Future<void> requestFullSpaceMode();
  Future<void> requestHomeSpaceMode();
}

class FlutterXr implements FlutterXrInterface {

  FlutterXRPigeon flutterXRPigeon=FlutterXRPigeon();

  @override
  Future<bool> isSpatialUiEnabled() {
    return flutterXRPigeon.isSpatialUiEnabled();
  }


  @override
  Future<void> requestFullSpaceMode() async{
   await flutterXRPigeon.requestFullSpaceMode();

  }

  @override
  Future<void> requestHomeSpaceMode()async {
   await flutterXRPigeon.requestHomeSpaceMode();
  }
}
