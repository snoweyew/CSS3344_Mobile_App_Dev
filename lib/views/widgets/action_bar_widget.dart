import 'package:flutter/material.dart';

/// ButtonSection: CALL / ROUTE / SHARE evenly spaced.
class ActionBarWidget extends StatelessWidget {
  const ActionBarWidget({
    super.key,
    required this.onCall,
    required this.onRoute,
    required this.onShare,
  });

  final VoidCallback onCall;
  final VoidCallback onRoute;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ActionButton(icon: Icons.call, label: 'CALL', onTap: onCall),
          _ActionButton(icon: Icons.near_me, label: 'ROUTE', onTap: onRoute),
          _ActionButton(icon: Icons.share, label: 'SHARE', onTap: onShare),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}