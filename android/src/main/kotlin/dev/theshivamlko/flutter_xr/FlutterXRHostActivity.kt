package dev.theshivamlko.flutter_xr

import android.annotation.SuppressLint
import android.app.Activity
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.background
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
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
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
import androidx.compose.ui.viewinterop.AndroidView
import androidx.xr.compose.platform.LocalSession
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
import androidx.xr.compose.spatial.ContentEdge
import androidx.xr.compose.spatial.OrbiterOffsetType
import androidx.xr.compose.subspace.SpatialPanel
import androidx.xr.compose.subspace.layout.SpatialRoundedCornerShape

class FlutterXRHostActivity: ComponentActivity() {


    @SuppressLint("RestrictedApi")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()



        setContent {
                val spatialConfiguration = LocalSpatialConfiguration.current
                println("isSpatialUiEnabled  "+LocalSpatialCapabilities.current.isSpatialUiEnabled)

                //   if (LocalSpatialCapabilities.current.isSpatialUiEnabled) {
                Subspace {
                    MySpatialContent(
                        onRequestHomeSpaceMode = spatialConfiguration::requestHomeSpaceMode
                    )
                }
                /*  } else {
                      My2DContent(onRequestFullSpaceMode = spatialConfiguration::requestFullSpaceMode)
                  }*/
        }
    }
}

@SuppressLint("RestrictedApi")
@Composable
fun MySpatialContent(onRequestHomeSpaceMode: () -> Unit) {
    var searchQuery by rememberSaveable { mutableStateOf("") }

    SpatialPanel(SubspaceModifier.width(1280.dp).height(800.dp).resizable().movable()) {

        MainContent(
            modifier = Modifier
                .fillMaxSize().background(color = Color.Red)
                .padding(48.dp)
        )

        Orbiter(
            position = ContentEdge.Top,
            alignment = Alignment.End,
            offsetType = OrbiterOffsetType.OuterEdge,

            shape = SpatialRoundedCornerShape(CornerSize(28.dp))
        ) {
            HomeSpaceModeIconButton(
                onClick = onRequestHomeSpaceMode,
                modifier = Modifier.size(56.dp)
            )
        }
        Orbiter(
            position = ContentEdge.Top,
            alignment = Alignment.End,
            offsetType = OrbiterOffsetType.InnerEdge,
            shape = SpatialRoundedCornerShape(CornerSize(28.dp))
        ) {
            FullWidthSearchBar(
                modifier = Modifier.height(64.dp).padding(horizontal = 32.dp),
                query = searchQuery,
                onQueryChange = { newQuery: String ->
                    searchQuery = newQuery
                    println(searchQuery)
                }
            )}


    }
    Orbiter(
        position = ContentEdge.Start,
        alignment = Alignment.CenterVertically,
        offsetType = OrbiterOffsetType.InnerEdge,
        shape = SpatialRoundedCornerShape(CornerSize(28.dp))
    ) {
        MainContent(
            modifier = Modifier
                .fillMaxSize().background(color = Color.Red)
                .padding(48.dp)
        )


    }
}


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
                },                placeholder = { Text(text = stringResource(android.R.string.search_go)) },
                singleLine = true,
                modifier = Modifier.fillMaxSize(),
                colors = TextFieldDefaults.colors(  Color.White),
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
            modifier = Modifier.fillMaxSize(),
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
    Text(text =  "MainContent", modifier = modifier)
}

@Composable
fun FullSpaceModeIconButton(onClick: () -> Unit, modifier: Modifier = Modifier) {
    IconButton(onClick = onClick, modifier = modifier) {
        Icon(
            painter = painterResource(id =android.R.mipmap.sym_def_app_icon),
            contentDescription ="contentDescription"
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