package dev.theshivamlko.flutter_xr

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.xr.compose.platform.SpatialCapabilities
import androidx.xr.compose.platform.SpatialConfiguration

object  FlutterComposeBridge :XRStateProvider{


    var spatialUiState=true
    lateinit var _spatialConfiguration: SpatialConfiguration
    lateinit var _spatialCapabilities: SpatialCapabilities


    fun updateSpatialState(spatialConfiguration: SpatialConfiguration,spatialCapabilities: SpatialCapabilities) {

        _spatialConfiguration=spatialConfiguration
        _spatialCapabilities=spatialCapabilities
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