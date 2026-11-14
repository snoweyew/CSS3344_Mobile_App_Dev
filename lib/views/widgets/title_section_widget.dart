import 'package:flutter/material.dart';

/// TitleSection: name, location and a tappable star with a dynamic counter.
class TitleSectionWidget extends StatelessWidget {
  const TitleSectionWidget({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
    required this.isStarred,
    required this.onStarTap,
  });

  final String name;
  final String location;
  final int starCount;
  final bool isStarred;
  final VoidCallback onStarTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onStarTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isStarred ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$starCount',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}