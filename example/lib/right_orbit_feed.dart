import 'package:flutter/material.dart';

class RightOrbitFeed extends StatelessWidget {
  const RightOrbitFeed({super.key});

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
        ? const Color(0xFFB49CFF)
        : Colors.white;
    final Color textColor = highlighted ? Colors.white : Colors.black87;
    final Color secondaryTextColor =
        highlighted ? Colors.white70 : Colors.black54;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 8,
            offset: Offset(0, 4),
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
                  backgroundColor:
                      highlighted ? const Color.fromRGBO(255, 255, 255, 0.9) : const Color(0xFFE0E0E0),
                  child: Text(
                    item.avatarLetter,
                    style: TextStyle(
                      color: highlighted ? cardColor : Colors.black87,
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

