package dev.theshivamlko.flutter_xr

import android.media.metrics.Event
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.xr.compose.platform.SpatialCapabilities
import androidx.xr.compose.platform.SpatialConfiguration

interface OnFlutterComposeBridgeListener{
    fun onListen(event: String)
}

object  FlutterComposeBridge :XRStateProvider{


    lateinit var onListener: OnFlutterComposeBridgeListener

    lateinit var _spatialConfiguration: SpatialConfiguration
    lateinit var _spatialCapabilities: SpatialCapabilities
    var routes: List<String>?= null;


    fun updateSpatialState(spatialConfiguration: SpatialConfiguration,spatialCapabilities: SpatialCapabilities) {
        _spatialConfiguration=spatialConfiguration
        _spatialCapabilities=spatialCapabilities
    }

    fun sendEvent(event: String) {
        println("Native FlutterComposeBridge onSpatialUiChanged $event")
        onListener.onListen(event)

    }



    override fun isSpatialUiEnabled(): Boolean {
        println("Native isSpatialUiEnabled")
        println(_spatialCapabilities.isSpatialUiEnabled)
        return  _spatialCapabilities.isSpatialUiEnabled
    }

    override fun requestFullSpaceMode() {
        println("Native requestFullSpaceMode1")
        _spatialConfiguration.requestFullSpaceMode()
        println("Native requestFullSpaceMode2")
    }

    override fun requestHomeSpaceMode() {
        println("Native requestHomeSpaceMode1")
        _spatialConfiguration.requestHomeSpaceMode()
        println("Native requestHomeSpaceMode2")

    }


    override fun isHandTrackingEnabled(): Boolean {
        TODO("Not yet implemented")
    }

    override fun setHandTrackingEnabled(enabled: Boolean) {
        TODO("Not yet implemented")
    }


}