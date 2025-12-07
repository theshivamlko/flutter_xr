import 'package:flutter/material.dart';
import 'OrbitNav.dart';

class BottomOrbit extends StatefulWidget {
  const BottomOrbit({super.key});

  @override
  State<BottomOrbit> createState() => _BottomOrbitState();
}

class _BottomOrbitState extends State<BottomOrbit> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: OrbitNav(
        orientation: Axis.horizontal,
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
