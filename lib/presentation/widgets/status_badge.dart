import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Renders a UTCI category as a colored pill (Home screen).
class StatusBadge extends StatelessWidget {
  final String category;
  final String label;

  const StatusBadge({super.key, required this.category, required this.label});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.statusColor(category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color, width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
