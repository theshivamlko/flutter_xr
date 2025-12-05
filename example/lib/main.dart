import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_xr/flutter_xr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSpatialEnabled = false;
  int count =1;

  final _flutterXrPlugin = FlutterXr();

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 3), (timer) {
      ++count;
      print("Count $count");
      setState(() {

      });
    },);

    Timer(Duration(seconds: 3), () {
      initPlatformState();
    });
  }

  Future<void> initPlatformState() async {
    try {
      isSpatialEnabled = await _flutterXrPlugin.isSpatialUiEnabled();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Plugin example app')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  'Count: $count\n\n',
                  style: TextStyle(fontSize: 30),
                ),Text(
                  'isSpatialEnabled: $isSpatialEnabled\n\n',
                  style: TextStyle(fontSize: 30),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    isSpatialEnabled ? "Disable Spatial" : "Enable Spatial",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
