package dev.theshivamlko.flutter_xr

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue

object  FlutterComposeBridge :XRStateProvider{

    var spatialUiState by mutableStateOf(true)

    override fun isSpatialUiEnabled(): Boolean {
        return  spatialUiState
    }

    override fun setSpatialUiEnabled(enable: Boolean) {
        spatialUiState=enable
    }

    override fun isHandTrackingEnabled(): Boolean {
        TODO("Not yet implemented")
    }

    override fun setHandTrackingEnabled(enabled: Boolean) {
        TODO("Not yet implemented")
    }


}