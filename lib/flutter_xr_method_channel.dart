import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_xr_platform_interface.dart';

/// An implementation of [FlutterXrPlatform] that uses method channels.
class MethodChannelFlutterXr extends FlutterXrPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_xr');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
