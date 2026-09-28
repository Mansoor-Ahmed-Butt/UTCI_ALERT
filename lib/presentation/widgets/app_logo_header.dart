import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AppLogoHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AppLogoHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            color: AppColors.accentMuted,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.wb_sunny_rounded, size: 36, color: AppColors.accent),
        ),
        const SizedBox(height: 16),
        Text(title, style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 4),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
