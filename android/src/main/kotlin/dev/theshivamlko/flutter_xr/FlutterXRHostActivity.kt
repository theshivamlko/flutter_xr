package dev.theshivamlko.flutter_xr

import android.annotation.SuppressLint
import android.app.Activity
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.background
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CornerSize
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.FilledTonalIconButton
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.dynamicDarkColorScheme
import androidx.compose.material3.dynamicLightColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.runtime.snapshotFlow
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.ComposeView
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalInspectionMode
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewLightDark
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.viewinterop.AndroidView
import androidx.xr.compose.platform.LocalSession
import androidx.xr.compose.platform.LocalSpatialCapabilities
import androidx.xr.compose.platform.LocalSpatialConfiguration
import androidx.xr.compose.platform.SpatialConfiguration
import androidx.xr.compose.spatial.Orbiter
import androidx.xr.compose.spatial.Subspace
import androidx.xr.compose.subspace.SpatialAndroidViewPanel
import androidx.xr.compose.subspace.layout.SubspaceModifier
import androidx.xr.compose.subspace.layout.fillMaxSize
import androidx.xr.compose.subspace.layout.height
import androidx.xr.compose.subspace.layout.movable
import androidx.xr.compose.subspace.layout.resizable
import androidx.xr.compose.subspace.layout.width
import androidx.xr.compose.spatial.ContentEdge
import androidx.xr.compose.spatial.OrbiterOffsetType
import androidx.xr.compose.subspace.SpatialPanel
import androidx.xr.compose.subspace.layout.SpatialRoundedCornerShape
import dev.theshivamlko.flutter_xr.ui.theme.Pink40
import dev.theshivamlko.flutter_xr.ui.theme.Pink80
import dev.theshivamlko.flutter_xr.ui.theme.Purple40
import dev.theshivamlko.flutter_xr.ui.theme.Purple80
import dev.theshivamlko.flutter_xr.ui.theme.PurpleGrey40
import dev.theshivamlko.flutter_xr.ui.theme.PurpleGrey80
import dev.theshivamlko.flutter_xr.ui.theme.Typography
import io.flutter.embedding.android.FlutterSurfaceView
import io.flutter.embedding.android.FlutterView
import kotlinx.coroutines.flow.distinctUntilChanged

class FlutterXRHostActivity : ComponentActivity() {


    @SuppressLint("RestrictedApi")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        setContent {
            MyXRApplicationTheme {
             /*   Handler(Looper.getMainLooper()).postDelayed({
                    println("Handler isSpatialUiEnabled  ")
                    FlutterComposeBridge.spatialUiState=!FlutterComposeBridge.spatialUiState
                }, 5000L)*/


                // Bridge
               FlutterComposeBridge.updateSpatialState(LocalSpatialConfiguration.current,LocalSpatialCapabilities.current)


                println("MyXRApplicationTheme ${FlutterComposeBridge.isSpatialUiEnabled()}")

                LaunchedEffect(Unit) {
                    println("MyXRApplicationTheme LaunchedEffect ${FlutterComposeBridge.isSpatialUiEnabled()}")
                    snapshotFlow { FlutterComposeBridge._spatialCapabilities.isSpatialUiEnabled }
                        .distinctUntilChanged()
                        .collect { enabled ->
                            println("MyXRApplicationTheme snapshotFlow $enabled")
                            FlutterComposeBridge.sendEvent("spatial_changed")

                            // Update your bridge
                         //   FlutterComposeBridge.setSpatialUiEnabled(enabled)

                            // Notify Flutter via Pigeon
                       //     SpatialEventEmitter.dart?.onSpatialUiChanged(enabled)
                        }
                }


                if (LocalSpatialCapabilities.current.isSpatialUiEnabled) {
                    FlutterSpatialContent()
                } else {
                    Flutter2DContent()
                }
                /* Subspace {
                     FlutterInsideComposeScreen()
                 }*/

            }
        }
    }

    private fun myFunctions(
        isSpatialUiEnabled: Boolean,
        spatialConfiguration: SpatialConfiguration
    ) {
        println("myFunctions $isSpatialUiEnabled")
        Handler(Looper.getMainLooper()).postDelayed({
            if (isSpatialUiEnabled)
                spatialConfiguration.requestHomeSpaceMode()
            else
                spatialConfiguration.requestFullSpaceMode()


        //    myFunctions(isSpatialUiEnabled, spatialConfiguration)
        }, 5000L)
    }
}



@Composable
fun FlutterSpatialContent() {
    Subspace {
        SpatialAndroidViewPanel(
            modifier = SubspaceModifier.width(1280.dp).height(800.dp).resizable().movable(),
            factory = { ctx ->
                val activity = ctx as Activity
                val surfaceView = FlutterSurfaceView(activity)
                val flutterView = FlutterView(activity, surfaceView)

                flutterView.post {
                    flutterView.attachToFlutterEngine(FlutterXRHostApplication.flutterEngine)
                    FlutterXRHostApplication.flutterEngine.lifecycleChannel.appIsResumed()
                }

                // IMPORTANT: Force XR to refresh this view every frame
                flutterView.viewTreeObserver.addOnDrawListener {
                    flutterView.invalidate()
                }

                flutterView


            }
        )
    }

}

@Composable
fun Flutter2DContent() {


    AndroidView(
        modifier = Modifier
            .width(1280.dp)
            .height(800.dp),

        factory = { ctx ->
            val activity = ctx as Activity
            val flutterView = FlutterView(activity)
            flutterView.attachToFlutterEngine(FlutterXRHostApplication.flutterEngine)
            flutterView.post {
                println("flutterView post")
                FlutterXRHostApplication.flutterEngine.lifecycleChannel.appIsResumed()
            }

            // REQUIRED FOR XR 2D MODE
            flutterView.viewTreeObserver.addOnDrawListener {
                println("flutterView ")
//                flutterView.invalidate()
            }

            flutterView


        })

}



@Composable
fun MyXRApplicationTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    // Dynamic color is available on Android 12+
    dynamicColor: Boolean = true,
    content: @Composable () -> Unit
) {
    val colorScheme = when {
        dynamicColor && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S -> {
            val context = LocalContext.current
            if (darkTheme) dynamicDarkColorScheme(context) else dynamicLightColorScheme(context)
        }


        darkTheme -> DarkColorScheme
        else -> LightColorScheme
    }

    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography,
        content = content
    )
}

private val DarkColorScheme = darkColorScheme(
    primary = Purple80,
    secondary = PurpleGrey80,
    tertiary = Pink80
)

private val LightColorScheme = lightColorScheme(
    primary = Purple40,
    secondary = PurpleGrey40,
    tertiary = Pink40

    /* Other default colors to override
    background = Color(0xFFFFFBFE),
    surface = Color(0xFFFFFBFE),
    onPrimary = Color.White,
    onSecondary = Color.White,
    onTertiary = Color.White,
    onBackground = Color(0xFF1C1B1F),
    onSurface = Color(0xFF1C1B1F),
    */
)



@Composable
fun FullWidthSearchBar(
    modifier: Modifier = Modifier,
    query: String = "",
    onQueryChange: (String) -> Unit = {}
) {
    var internalQuery by rememberSaveable { mutableStateOf(query) }

    Surface(
        tonalElevation = 2.dp,
        shape = RoundedCornerShape(28.dp),
        modifier = modifier
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier
                .fillMaxSize()
        ) {
            Icon(
                painter = painterResource(id = android.R.drawable.ic_menu_search),
                contentDescription = null,
                modifier = Modifier.size(24.dp)
            )
            Spacer(Modifier.width(12.dp))
            TextField(
                value = internalQuery,
                onValueChange = { newValue ->
                    internalQuery = newValue
                    onQueryChange(newValue)
                }, placeholder = { Text(text = stringResource(android.R.string.search_go)) },
                singleLine = true,
                modifier = Modifier.fillMaxSize(),
                colors = TextFieldDefaults.colors(Color.White),
                shape = RoundedCornerShape(28.dp)
            )
        }
    }
}

@SuppressLint("RestrictedApi")
@Composable
fun My2DContent(onRequestFullSpaceMode: () -> Unit) {
    Surface {
        Row(
            modifier = Modifier
                .fillMaxSize()
                .background(Color.White),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            MainContent(modifier = Modifier.padding(48.dp))

            if (!LocalInspectionMode.current && LocalSession.current != null) {
                FullSpaceModeIconButton(
                    onClick = onRequestFullSpaceMode,
                    modifier = Modifier.padding(32.dp)
                )
            }
        }
    }
}

@Composable
fun MainContent(modifier: Modifier = Modifier) {
    Text(
        text = "MainContent",
        modifier = modifier,
        color = Color.Black,
        fontSize = 48.sp
    )
}

@Composable
fun FullSpaceModeIconButton(onClick: () -> Unit, modifier: Modifier = Modifier) {
    IconButton(onClick = onClick, modifier = modifier) {
        Icon(
            painter = painterResource(id = android.R.mipmap.sym_def_app_icon),
            contentDescription = "contentDescription"
        )
    }
}

@Composable
fun HomeSpaceModeIconButton(onClick: () -> Unit, modifier: Modifier = Modifier) {
    FilledTonalIconButton(onClick = onClick, modifier = modifier) {
        Icon(
            painter = painterResource(id = android.R.mipmap.sym_def_app_icon),
            contentDescription = "contentDescription"
        )
    }
}

@PreviewLightDark
@Composable
fun My2dContentPreview() {

    My2DContent(onRequestFullSpaceMode = {})

}

@Preview(showBackground = true)
@Composable
fun FullSpaceModeButtonPreview() {
    FullSpaceModeIconButton(onClick = {})
}

@PreviewLightDark
@Composable
fun HomeSpaceModeButtonPreview() {
    HomeSpaceModeIconButton(onClick = {})

}
