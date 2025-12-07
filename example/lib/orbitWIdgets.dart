import 'package:flutter/material.dart';

Widget leftOrbit() {
  return SizedBox(width: 150, child: _OrbitNavDemo(vertical: true));
}

Widget rightOrbit() {
  return SizedBox(
    width: 150,
    child: const Center(
      child: Text('Go Orbit', style: TextStyle(fontSize: 30)),
    ),
  );
}

Widget topOrbit() {
  return SizedBox(
    height: 80,
    child: const Center(
      child: Text('Saved Orbit', style: TextStyle(fontSize: 30)),
    ),
  );
}

Widget bottomOrbit() {
  return SizedBox(height: 80, child: _OrbitNavDemo(vertical: false));
}

class _OrbitNavDemo extends StatelessWidget {
  final bool vertical;

  _OrbitNavDemo({required this.vertical});

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return ValueListenableBuilder(
        valueListenable: _selectedIndex,
        builder: (context, value, child) {
          return OrbitNav(
            orientation: Axis.vertical,
            currentIndex: value,
            onTap: (i) => _selectedIndex.value = i,
          );
        },
      );
    }

    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, value, child) {
        return OrbitNav(
          orientation: Axis.horizontal,
          currentIndex: value,
          onTap: (i) => _selectedIndex.value = i,
        );
      },
    );
  }
}

class OrbitNav extends StatelessWidget {
  const OrbitNav({
    super.key,
    required this.orientation,
    required this.currentIndex,
    required this.onTap,
  });

  final Axis orientation;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    if (orientation == Axis.vertical) {
      return _buildVertical(context);
    }
    return _buildHorizontal(context);
  }

  Widget _buildHorizontal(BuildContext context) {
    final theme = Theme.of(context);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: Colors.grey.shade600,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.place_outlined),
          activeIcon: Icon(Icons.place),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car_outlined),
          activeIcon: Icon(Icons.directions_car),
          label: 'Go',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),
          activeIcon: Icon(Icons.bookmark),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          activeIcon: Icon(Icons.add_circle),
          label: 'Contribute',
        ),
      ],
    );
  }

  // --- Vertical (rail-style) ---
  Widget _buildVertical(BuildContext context) {
    const items = [
      _NavItemData(
        icon: Icons.place_outlined,
        activeIcon: Icons.place,
        label: 'Explore',
      ),
      _NavItemData(
        icon: Icons.directions_car_outlined,
        activeIcon: Icons.directions_car,
        label: 'Go',
      ),
      _NavItemData(
        icon: Icons.bookmark_border,
        activeIcon: Icons.bookmark,
        label: 'Saved',
      ),
      _NavItemData(
        icon: Icons.add_circle_outline,
        activeIcon: Icons.add_circle,
        label: 'Contribute',
      ),
    ];

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            _VerticalNavItem(
              data: items[i],
              selected: i == currentIndex,
              onTap: () => onTap(i),
            ),
            if (i != items.length - 1) const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

class _VerticalNavItem extends StatelessWidget {
  const _VerticalNavItem({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final _NavItemData data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.deepPurple.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? data.activeIcon : data.icon,
              color: selected ? Colors.deepPurple : Colors.grey.shade600,
            ),
            const SizedBox(height: 4),
            Text(
              data.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                color: selected ? Colors.deepPurple : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
