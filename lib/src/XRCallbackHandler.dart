import 'package:flutter_xr/src/pigeon/pigeon.g.dart';

class XRCallbackHandler extends FlutterXRPigeonCallbacks {
  final void Function(String event) onChanged;

  XRCallbackHandler(this.onChanged);


  @override
  void listenEvents(String event) {
    print("FlutterXrP XRCallbackHandler listenEvents $event");
    onChanged(event);
  }
}
