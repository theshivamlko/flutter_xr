import 'package:flutter/material.dart';
import 'OrbitNav.dart';

class BottomOrbit extends StatelessWidget {
  const BottomOrbit({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: OrbitNav(
        orientation: Axis.horizontal,
        currentIndex: 0,
        onTap: (_) {},
      ),
    );
  }
}
