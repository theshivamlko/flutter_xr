package dev.theshivamlko.flutter_xr

import dev.theshivamlko.flutter_xr.FlutterXRPigeon
import dev.theshivamlko.flutter_xr.FlutterComposeBridge
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

class FlutterXrPluginImplementation  : FlutterXRPigeon {
    val TAG="FlutterXrPluginImplementation"
    var flutterCallback: FlutterXRPigeonCallbacks? = null
    var routes: List<String>?= null;

    init {
    /*    val numbersFlow: Flow<Int> = flow {
            repeat(60) { it ->
                emit(it+1) //Emits the result of the request to the flow
            }
        }*/
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

    override fun registerRoutes(routes: List<String>) {
       this.routes=routes
        FlutterComposeBridge.routes=routes
    }


}