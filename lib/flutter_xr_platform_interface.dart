import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_xr_method_channel.dart';

abstract class FlutterXrPlatform extends PlatformInterface {
  /// Constructs a FlutterXrPlatform.
  FlutterXrPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterXrPlatform _instance = MethodChannelFlutterXr();

  /// The default instance of [FlutterXrPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterXr].
  static FlutterXrPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterXrPlatform] when
  /// they register themselves.
  static set instance(FlutterXrPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
