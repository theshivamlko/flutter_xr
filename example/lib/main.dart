import 'package:flutter/material.dart' hide Alignment;
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_xr/flutter_xr.dart';
import 'package:flutter_xr_example/orbitWIdgets.dart';

final _flutterXrPlugin = FlutterXr();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  print("Flutter Main");

  final appRoutes=await _flutterXrPlugin.registerRoutes(leftOrbit:Orbiter(
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

  );

  runApp(MaterialApp(home: MyApp(),routes: appRoutes,));

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
  int count = 1;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 5), (timer) {
      ++count;
      print("Count $count");
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
      appBar: AppBar(title: const Text('Plugin example app')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text('Count: $count\n\n', style: TextStyle(fontSize: 30)),
              Text(
                'isSpatialEnabled: $isSpatialEnabled\n\n',
                style: TextStyle(fontSize: 30),
              ),
              ElevatedButton(
                onPressed: () => checkSpatialEnabled(),
                child: Text("Check Spatial Status"),
              ),
              ElevatedButton(
                onPressed: () => toggleSpatialFullScreen(),
                child: Text(
                  isSpatialEnabled ? "Disable Spatial" : "Enable Spatial",
                ),
              ),
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
