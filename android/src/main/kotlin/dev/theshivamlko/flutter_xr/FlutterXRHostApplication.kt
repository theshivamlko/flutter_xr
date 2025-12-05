package dev.theshivamlko.flutter_xr

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class FlutterXRHostApplication: Application() {

    companion object{
        lateinit var flutterEngine: FlutterEngine
    }

    override fun onCreate() {
        super.onCreate()

        flutterEngine = FlutterEngine(this)
        flutterEngine.navigationChannel.setInitialRoute("/")
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        FlutterEngineCache
            .getInstance()
            .put("main", flutterEngine)

    }
}