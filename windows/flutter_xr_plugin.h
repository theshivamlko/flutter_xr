#ifndef FLUTTER_PLUGIN_FLUTTER_XR_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_XR_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_xr {

class FlutterXrPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterXrPlugin();

  virtual ~FlutterXrPlugin();

  // Disallow copy and assign.
  FlutterXrPlugin(const FlutterXrPlugin&) = delete;
  FlutterXrPlugin& operator=(const FlutterXrPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_xr

#endif  // FLUTTER_PLUGIN_FLUTTER_XR_PLUGIN_H_
