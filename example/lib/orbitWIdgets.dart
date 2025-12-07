import 'package:flutter/material.dart';

Widget leftOrbit() {
  return SizedBox(width: 150, child: _OrbitNavDemo(vertical: true));
}

Widget rightOrbit() {
  // Feed-style list with 5 dummy cards similar to the provided image
  return Material(child: const _RightOrbitFeed());
}

Widget topOrbit(ValueChanged<String> listen) {
  // Fixed height with pill-style search bar like the provided image
  return Material(
    child: Container(
      height: 80,
      color: const Color(0xFF2D2551), // dark purple background similar to example
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: _RoundedSearchBar(listen),
    ),
  );
}

Widget bottomOrbit() {
  return SizedBox(height: 80, child: _OrbitNavDemo(vertical: false));
}

class _RoundedSearchBar extends StatelessWidget {
  final ValueChanged<String> listen;

  const _RoundedSearchBar(this.listen);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(Icons.search, color: Colors.grey.shade400, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: (value) {
                listen(value);
              },
            ),
          ),
          // Right-side colored "Search" pill
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6C5C), // coral / salmon color like image
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Search',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
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
      return Container(color: Colors.white, child: _buildVertical(context));
    }
    return Container(color: Colors.black, child: _buildHorizontal(context));
  }

  Widget _buildHorizontal(BuildContext context) {
    final theme = Theme.of(context);
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

class _RightOrbitFeed extends StatelessWidget {
  const _RightOrbitFeed();

  @override
  Widget build(BuildContext context) {
    final items = _dummyFeedItems;
    return Material(
      color: const Color(0xFFF5F3FF),
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final bool isHighlighted = index == 1; // second card highlighted like image
          return _FeedCard(item: item, highlighted: isHighlighted);
        },
      ),
    );
  }
}

class _FeedItem {
  const _FeedItem({
    required this.avatarLetter,
    required this.name,
    required this.timeAgo,
    required this.title,
    required this.subtitle,
  });

  final String avatarLetter;
  final String name;
  final String timeAgo;
  final String title;
  final String subtitle;
}

const List<_FeedItem> _dummyFeedItems = [
  _FeedItem(
    avatarLetter: '鹿',
    name: '老强',
    timeAgo: '10 min ago',
    title: '豆花鱼',
    subtitle: '最近吃了吗？昨天我去了你最爱的那家豆花鱼店，吃完吃得我想睡了。',
  ),
  _FeedItem(
    avatarLetter: 'S',
    name: 'So Duri',
    timeAgo: '20 min ago',
    title: 'Dinner Club',
    subtitle:
        'I think it\'s time for us to finally try that new noodle shop downtown that doesn\'t use menus. Anyone...',
  ),
  _FeedItem(
    avatarLetter: 'L',
    name: 'Lily MacDonald',
    timeAgo: '2 hours ago',
    title: 'This food show is made for you',
    subtitle:
        'Ping – you\'d love this new food show I started watching. It\'s produced by a Thai drummer who...',
  ),
  _FeedItem(
    avatarLetter: 'A',
    name: 'Alex Chen',
    timeAgo: 'Yesterday',
    title: 'New ramen place',
    subtitle: 'They have a broth that simmers for 24 hours. We should go this weekend.',
  ),
  _FeedItem(
    avatarLetter: 'J',
    name: 'Jia Li',
    timeAgo: '2 days ago',
    title: 'Street food tour',
    subtitle: 'Found a night market with amazing skewers and deserts. Let\'s plan a trip.',
  ),
];

class _FeedCard extends StatelessWidget {
  const _FeedCard({required this.item, this.highlighted = false});

  final _FeedItem item;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final Color cardColor = highlighted
        ? const Color(0xFFB49CFF) // purple highlight similar to screenshot
        : Colors.white;
    final Color textColor = highlighted ? Colors.white : Colors.black87;
    final Color secondaryTextColor =
        highlighted ? Colors.white70 : Colors.black54;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: highlighted
                      ? Colors.white.withOpacity(0.9)
                      : const Color(0xFFE0E0E0),
                  child: Text(
                    item.avatarLetter,
                    style: TextStyle(
                      color: highlighted
                          ? cardColor
                          : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.name,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            item.timeAgo,
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.title,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: secondaryTextColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  highlighted ? Icons.add_circle : Icons.star_border,
                  size: 18,
                  color: secondaryTextColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
