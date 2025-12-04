
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon/message.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
    'android/src/main/kotlin/com/theshivamlko/flutter_xr/pigeon/Message.g.kt',
    kotlinOptions: KotlinOptions(package: "com.theshivamlko.flutter_xr"),
    dartPackageName: 'flutter_xr',
  ),
)

@HostApi()
abstract class FlutterXR {
  bool isSpatialEnabled();

}
