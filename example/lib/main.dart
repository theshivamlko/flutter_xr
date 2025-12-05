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
  final _flutterXrPlugin = FlutterXr();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      isSpatialEnabled =
          await _flutterXrPlugin.isSpatialEnabled() ;
    } on PlatformException catch (e) {
      print(e);
    }


    if (!mounted) return;

    setState(() {
     });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('isSpatialEnabled: $isSpatialEnabled\n\n',style: TextStyle(fontSize: 30),),
            ],
          ),
        ),
      ),
    );
  }
}
