import 'package:flutter/material.dart';

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
      return Container(color: Colors.white, child: _buildVertical(context));
    }
    return Container(color: Colors.black, child: _buildHorizontal(context));
  }

  Widget _buildHorizontal(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.purpleAccent,
      unselectedItemColor: Colors.white60,
      showUnselectedLabels: true,
      iconSize: 30,
      selectedFontSize: 20,
      unselectedFontSize: 16,
      backgroundColor: Colors.black87,
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
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          activeIcon: Icon(Icons.search),
          label: 'Search',
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
        icon: Icons.search,
        activeIcon: Icons.search,
        label: 'Search',
      ),
      _NavItemData(
        icon: Icons.add_circle_outline,
        activeIcon: Icons.add_circle,
        label: 'Contribute',
      ),
      _NavItemData(
        icon: Icons.logout_outlined,
        activeIcon: Icons.logout_outlined,
        label: 'Logout',
      ),
    ];

    return Container(
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
              size: 30,
            ),
            const SizedBox(height: 4),
            /*  Text(
              data.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                color: selected ? Colors.deepPurple : Colors.grey.shade600,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

