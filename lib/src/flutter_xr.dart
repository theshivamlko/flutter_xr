// filepath: lib/src/flutter_xr.dart

import '../flutter_xr_platform_interface.dart';




class FlutterXr {
  Future<String?> getPlatformVersion() {
    return FlutterXrPlatform.instance.getPlatformVersion();
  }
}

