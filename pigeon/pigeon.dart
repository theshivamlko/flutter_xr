
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon/pigeon.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
    'android/src/main/kotlin/dev/theshivamlko/flutter_xr/pigeon/FlutterXRPigeon.g.kt',
    kotlinOptions: KotlinOptions(package: "dev.theshivamlko.flutter_xr"),
    dartPackageName: 'flutter_xr',
  ),
)



@HostApi()
abstract class FlutterXRPigeon {
  bool isSpatialUiEnabled();
  void requestFullSpaceMode();
  void requestHomeSpaceMode();
  void listenEvents(String event);
}

@FlutterApi()
abstract class FlutterXRPigeonCallbacks {
  void listenEvents(String event);
}
