import 'package:flutter/material.dart'  hide Alignment;
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_xr/flutter_xr.dart';
import 'package:flutter_xr_example/bottom_orbit.dart';
import 'package:flutter_xr_example/left_orbit.dart';
import 'package:flutter_xr_example/right_orbit.dart';
import 'package:flutter_xr_example/top_orbit.dart';
import 'package:intl/intl.dart';

final _flutterXrPlugin = FlutterXr();
ValueNotifier<String> leftOrbitListen = ValueNotifier<String>("");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Flutter Main");

  final appRoutes = await _flutterXrPlugin.registerRoutes(
    leftOrbit: Orbiter(
      ContentEdge.start,
      Alignment.centerVertically,
      OrbiterOffsetType.innerEdge,
      LeftOrbit(),
      width: 100,
      height: 100,
    ),
    rightOrbit: Orbiter(
      ContentEdge.end,
      Alignment.centerVertically,
      OrbiterOffsetType.innerEdge,
      RightOrbit(),
      width: 100,
      height: 100,
    ),
    topOrbit: Orbiter(
      ContentEdge.top,
      Alignment.centerHorizontally,
      OrbiterOffsetType.innerEdge,
      TopOrbit(
        onSearchChanged: (String value) {
          print("topOrbit $value");
          leftOrbitListen.value = value;
        },
      ),
      width: 100,
      height: 100,
    ),
    bottomOrbit: Orbiter(
      ContentEdge.bottom,
      Alignment.centerHorizontally,
      OrbiterOffsetType.innerEdge,
      BottomOrbit(),
      width: 100,
      height: 100,
    ),
  );

  runApp(
    MaterialApp(
      home: MyApp(),
      routes: appRoutes,
      debugShowCheckedModeBanner: false,
    ),
  );

  /* runApp(
    FlutterXRWidget(
      mainBody: const MyApp(),
      flutterXr: _flutterXrPlugin,
      leftOrbit: Orbiter(
        ContentEdge.start,
        Alignment.centerVertically,
        OrbiterOffsetType.innerEdge,
        leftOrbit(),
        width: 100,
        height: 100,
      ),
      rightOrbit: Orbiter(
        ContentEdge.end,
        Alignment.centerVertically,
        OrbiterOffsetType.innerEdge,
        leftOrbit(),
        width: 100,
        height: 100,
      ),
      topOrbit: Orbiter(
        ContentEdge.top,
        Alignment.centerHorizontally,
        OrbiterOffsetType.innerEdge,
        leftOrbit(),
        width: 100,
        height: 100,
      ),
      bottomOrbit: Orbiter(
        ContentEdge.bottom,
        Alignment.centerHorizontally,
        OrbiterOffsetType.innerEdge,
        leftOrbit(),
        width: 100,
        height: 100,
      ),
    ),
  );*/
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSpatialEnabled = false;
  String formattedDate1 = "";

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      DateFormat customFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
      formattedDate1 = customFormat.format(DateTime.now());
      setState(() {});
    });

    _flutterXrPlugin.listenEvents((event) {
      print("MyApp listenEvents $event");
      checkSpatialEnabled();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                'Local Time: $formattedDate1\n',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                'isSpatialEnabled: $isSpatialEnabled\n',
                style: TextStyle(fontSize: 30),
              ),
              ValueListenableBuilder(
                valueListenable: leftOrbitListen,
                builder: (context, value, child) {
                  return Text(
                    'Text Input => ${leftOrbitListen.value}',
                    style: TextStyle(fontSize: 30),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: ElevatedButton(
                  onPressed: () => checkSpatialEnabled(),
                  child: Text(
                    "Check Spatial Status",

                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => toggleSpatialFullScreen(),
                  child: Text(
                    isSpatialEnabled ? "Disable Spatial" : "Enable Spatial",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Image.asset("assets/flutter-logo.png",height: 200,)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkSpatialEnabled() async {
    print("checkSpatialEnabled1");
    try {
      isSpatialEnabled = await _flutterXrPlugin.isSpatialUiEnabled();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;
    print("checkSpatialEnabled2  $isSpatialEnabled");

    setState(() {});
  }

  void toggleSpatialFullScreen() async {
    print("toggleSpatialFullScreen $isSpatialEnabled");
    if (isSpatialEnabled) {
      await _flutterXrPlugin.requestHomeSpaceMode();
    } else {
      await _flutterXrPlugin.requestFullSpaceMode();
    }
    print("toggleSpatialFullScreen 2");
  }
}
