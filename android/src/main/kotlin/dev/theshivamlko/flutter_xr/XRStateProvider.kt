package dev.theshivamlko.flutter_xr

interface  XRStateProvider {

    fun isSpatialUiEnabled(): Boolean
    fun setSpatialUiEnabled(enable: Boolean)
    fun isHandTrackingEnabled(): Boolean
    fun setHandTrackingEnabled(enabled: Boolean)
}