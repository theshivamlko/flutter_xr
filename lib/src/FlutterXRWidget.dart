import 'package:flutter/material.dart';

class FlutterXRWidget extends StatelessWidget {
  final Widget? leftOrbit;
  final Widget? rightOrbit;
  final Widget? topOrbit;
  final Widget? bottomOrbit;
  final Widget mainBody;

  FlutterXRWidget({
    super.key,
    required this.mainBody,
    this.topOrbit,
    this.bottomOrbit,
    this.leftOrbit,
    this.rightOrbit,
  });

  final List<String> routes = [];

  @override
  Widget build(BuildContext context) {
    routes.add("/");

    if (leftOrbit != null) routes.add("/left");
    if (rightOrbit != null) routes.add("/right");
    if (topOrbit != null) routes.add("/top");
    if (bottomOrbit != null) routes.add("/bottom");
    print("FlutterXRWidget routes $routes");

    return MaterialApp(
      routes: {
        '/': (_) => mainBody,
        if (leftOrbit != null) '/left': (_) => leftOrbit!,
        if (rightOrbit != null) '/right': (_) => rightOrbit!,
        if (topOrbit != null) '/top': (_) => topOrbit!,
        if (bottomOrbit != null) '/bottom': (_) => bottomOrbit!,
      },
    );
  }
}
