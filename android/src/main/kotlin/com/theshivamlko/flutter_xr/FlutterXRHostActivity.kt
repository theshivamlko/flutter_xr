package com.theshivamlko.flutter_xr

import android.app.Activity
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CornerSize
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import androidx.xr.compose.platform.LocalSpatialCapabilities
import androidx.xr.compose.platform.LocalSpatialConfiguration
import androidx.xr.compose.spatial.Orbiter
import androidx.xr.compose.spatial.Subspace
import androidx.xr.compose.subspace.SpatialAndroidViewPanel
import androidx.xr.compose.subspace.layout.SubspaceModifier
import androidx.xr.compose.subspace.layout.fillMaxSize
import androidx.xr.compose.subspace.layout.height
import androidx.xr.compose.subspace.layout.movable
import androidx.xr.compose.subspace.layout.resizable
import androidx.xr.compose.subspace.layout.width
import io.flutter.embedding.android.FlutterView
import androidx.xr.compose.spatial.ContentEdge
import androidx.xr.compose.spatial.OrbiterOffsetType
import androidx.xr.compose.subspace.layout.SpatialRoundedCornerShape
import io.flutter.embedding.android.FlutterSurfaceView

class FlutterXRHostActivity: ComponentActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        print("onCreate")

         setContent {
            FlutterInsideComposeScreen()
        }
    }
}
@Composable
fun FlutterInsideComposeScreen() {
    // Read CompositionLocals here — inside a composable context where
    // CompositionLocal.current access is valid.
    val spatialConfiguration = LocalSpatialConfiguration.current
    println("isSpatialUiEnabled  " + LocalSpatialCapabilities.current.isSpatialUiEnabled)

    Subspace {
        Box{
            Text("Hello Android Compose")

        }
    }
}