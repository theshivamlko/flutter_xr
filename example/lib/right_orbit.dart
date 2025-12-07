import 'package:flutter/material.dart';

class RightOrbit extends StatefulWidget {
  const RightOrbit({super.key});

  @override
  State<RightOrbit> createState() => _RightOrbitState();
}

class _RightOrbitState extends State<RightOrbit> {


  int selectedIndex = 0;

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
          final bool isHighlighted =
              index == selectedIndex;
          return GestureDetector(
            onTap: () {
              selectedIndex=index;
              setState(() {});
            },
            child: _FeedCard(item: item, highlighted: isHighlighted),
          );
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

class _FeedCard extends StatelessWidget {
  const _FeedCard({required this.item, this.highlighted = false});

  final _FeedItem item;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final Color cardColor = highlighted
        ? const Color(0xFF8E70DF) // purple highlight similar to screenshot
        : Colors.white;
    final Color textColor = highlighted ? Colors.white : Colors.black87;
    final Color secondaryTextColor = highlighted
        ? Colors.white70
        : Colors.black54;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
                      ? Colors.white.withValues(alpha: 0.9)
                      : const Color(0xFFE0E0E0),
                  child: Text(
                    item.avatarLetter,
                    style: TextStyle(
                      color: highlighted ? cardColor : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            item.timeAgo,
                            style: TextStyle(color: textColor, fontSize: 12),
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

const List<_FeedItem> _dummyFeedItems = [
  _FeedItem(
    avatarLetter: 'L',
    name: 'Leo Zhang',
    timeAgo: '10 min ago',
    title: 'Spicy tofu fish',
    subtitle:
        'Did you eat yet? I went back to your favorite spicy tofu fish place yesterday and it was amazing.',
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
    subtitle:
        'They have a broth that simmers for 24 hours. We should go this weekend.',
  ),
  _FeedItem(
    avatarLetter: 'J',
    name: 'Jia Li',
    timeAgo: '2 days ago',
    title: 'Street food tour',
    subtitle:
        'Found a night market with amazing skewers and desserts. Let\'s plan a trip.',
  ),
];
