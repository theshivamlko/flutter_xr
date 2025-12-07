package dev.theshivamlko.flutter_xr

import android.app.Application
import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class FlutterXRHostApplication : Application() {


    companion object {

    }

    /*
    companion object {
        lateinit var mainEngine: FlutterEngine
        lateinit var leftEngine: FlutterEngine
        lateinit var rightEngine: FlutterEngine
        lateinit var topEngine: FlutterEngine
        lateinit var bottomEngine: FlutterEngine


        fun createEngines(context: Context,routes: List<String>){


            leftEngine = FlutterEngine(context)
            leftEngine.navigationChannel.setInitialRoute("/left")
            leftEngine.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )

            FlutterEngineCache
                .getInstance()
                .put("leftEngine", leftEngine)

            leftEngine = FlutterEngine(context)
            leftEngine.navigationChannel.setInitialRoute("/right")
            leftEngine.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )

            FlutterEngineCache
                .getInstance()
                .put("rightEngine", rightEngine)

            topEngine = FlutterEngine(context)
            topEngine.navigationChannel.setInitialRoute("/top")
            topEngine.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )

            FlutterEngineCache
                .getInstance()
                .put("topEngine", topEngine)



            bottomEngine = FlutterEngine(context)
            bottomEngine.navigationChannel.setInitialRoute("/bottom")
            bottomEngine.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )

            FlutterEngineCache
                .getInstance()
                .put("bottomEngine", bottomEngine)

        }
    }

    override fun onCreate() {
        super.onCreate()

        // Main Body
        mainEngine = FlutterEngine(this)
        mainEngine.navigationChannel.setInitialRoute("/")
        mainEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        FlutterEngineCache
            .getInstance()
            .put("mainEngine", mainEngine)

    }
*/


}