#include "include/flutter_xr/flutter_xr_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_xr_plugin.h"

void FlutterXrPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_xr::FlutterXrPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
