
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon/pigeon.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
    'android/src/main/kotlin/com/theshivamlko/flutter_xr/pigeon/FlutterXRPigeon.g.kt',
    kotlinOptions: KotlinOptions(package: "com.theshivamlko.flutter_xr"),
    dartPackageName: 'flutter_xr',
  ),
)

@HostApi()
abstract class FlutterXRPigeon {
  bool isSpatialEnabled();
}
