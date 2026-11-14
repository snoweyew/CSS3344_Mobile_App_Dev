import 'package:flutter/material.dart';

/// TextSection: padded container with the descriptive paragraph.
class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key, required this.text, this.title});

  final String text;

  /// Optional heading (e.g. "About the Destination" in landscape).
  final String? title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style:
              textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
          ],
          Text(
            text,
            softWrap: true,
            style: textTheme.bodyMedium?.copyWith(height: 1.4),
          ),
        ],
      ),
    );
  }
}