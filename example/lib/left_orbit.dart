import 'package:flutter/material.dart';
import 'OrbitNav.dart';

class LeftOrbit extends StatefulWidget {
  const LeftOrbit({super.key});

  @override
  State<LeftOrbit> createState() => _LeftOrbitState();
}

class _LeftOrbitState extends State<LeftOrbit> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: OrbitNav(
        orientation: Axis.vertical,
        currentIndex: selectedIndex,
        onTap: (index) {
          print(index);
          setState(() {

            selectedIndex = index;
          });
        },
      ),
    );
  }
}
