import 'package:flutter/material.dart';
import 'OrbitNav.dart';

class LeftOrbit extends StatelessWidget {
  const LeftOrbit({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: OrbitNav(
        orientation: Axis.vertical,
        currentIndex: 0,
        onTap: (_) {},
      ),
    );
  }
}
