package dev.theshivamlko.flutter_xr

import dev.theshivamlko.flutter_xr.FlutterXRPigeon
import dev.theshivamlko.flutter_xr.FlutterComposeBridge

class FlutterXrPluginImplementation  : FlutterXRPigeon {
    val TAG="FlutterXrPluginImplementation"
    var flutterCallback: FlutterXRPigeonCallbacks? = null

    init {
        FlutterComposeBridge.onListener = object : OnFlutterComposeBridgeListener {
            override fun onListen(event: String) {
                println("Native $TAG onSpatialUiChanged $event")
                flutterCallback?.listenEvents(event) { }
            }
        }
    }


    override fun isSpatialUiEnabled(): Boolean {
       return  FlutterComposeBridge.isSpatialUiEnabled()
    }

    override fun requestFullSpaceMode() {
        FlutterComposeBridge.requestFullSpaceMode()
    }

    override fun requestHomeSpaceMode() {
        FlutterComposeBridge.requestHomeSpaceMode()
    }

    override fun listenEvents(event: String) {
        if(flutterCallback!=null) {


        }else
            throw Exception("Callback not registered")
    }


}