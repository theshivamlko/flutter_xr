import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  String _platformVersion = 'Unknown';
  final _flutterXrPlugin = FlutterXr();

  bool isSpatialEnabled=false;
  @override
  void initState() {
    super.initState();


    SchedulerBinding.instance.addPostFrameCallback((timeStamp)async {
      isSpatialEnabled= await FlutterXr().isSpatialEnabled();

      setState(() {

      });

    },);







   }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('isSpatialEnabled: $isSpatialEnabled'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
