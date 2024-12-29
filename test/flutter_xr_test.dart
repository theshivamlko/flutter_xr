import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_xr/flutter_xr.dart';
import 'package:flutter_xr/flutter_xr_platform_interface.dart';
import 'package:flutter_xr/flutter_xr_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterXrPlatform
    with MockPlatformInterfaceMixin
    implements FlutterXrPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterXrPlatform initialPlatform = FlutterXrPlatform.instance;

  test('$MethodChannelFlutterXr is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterXr>());
  });

  test('getPlatformVersion', () async {
    FlutterXr flutterXrPlugin = FlutterXr();
    MockFlutterXrPlatform fakePlatform = MockFlutterXrPlatform();
    FlutterXrPlatform.instance = fakePlatform;

    expect(await flutterXrPlugin.getPlatformVersion(), '42');
  });
}
