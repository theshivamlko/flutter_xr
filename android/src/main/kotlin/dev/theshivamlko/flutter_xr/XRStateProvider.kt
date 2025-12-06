package dev.theshivamlko.flutter_xr

interface  XRStateProvider {

    fun isSpatialUiEnabled(): Boolean
    fun requestFullSpaceMode( ): Unit
    fun requestHomeSpaceMode( ): Unit
    fun isHandTrackingEnabled(): Boolean
    fun setHandTrackingEnabled(enabled: Boolean)
}