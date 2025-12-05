package dev.theshivamlko.flutter_xr

import dev.theshivamlko.flutter_xr.FlutterXRPigeon
import dev.theshivamlko.flutter_xr.FlutterComposeBridge

class FlutterXrPluginImplementation  : FlutterXRPigeon {

    override fun isSpatialUiEnabled(): Boolean {
       return  FlutterComposeBridge.isSpatialUiEnabled()
    }

    override fun setSpatialUiEnabled(enable: Boolean) {
        TODO("Not yet implemented")
    }


}