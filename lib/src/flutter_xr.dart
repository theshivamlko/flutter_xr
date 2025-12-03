// filepath: lib/src/flutter_xr.dart

import '../flutter_xr_platform_interface.dart';

/// Public API exposed by `package:flutter_xr/flutter_xr.dart`.
class FlutterXr {
  Future<String?> getPlatformVersion() {
    return FlutterXrPlatform.instance.getPlatformVersion();
  }
}

