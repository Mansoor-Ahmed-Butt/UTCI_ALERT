import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/user_role.dart';

class RoleSelectionCard extends StatelessWidget {
  final UserRole role;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleSelectionCard({
    super.key,
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final selectedBg = isDark
        ? AppColors.accent.withValues(alpha: 0.18)
        : AppColors.accentMuted;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: isSelected ? selectedBg : null,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isSelected ? AppColors.accent : (isDark ? AppColors.dividerDark : AppColors.dividerLight),
          width: isSelected ? 2.0 : 1.0,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.accent
                      : (isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF0F0F0)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  role.icon,
                  color: isSelected ? Colors.black87 : (isDark ? Colors.white70 : Colors.black87),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role.localizedLabel,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? AppColors.accent : null,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      role.localizedDescription,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isSelected ? AppColors.accent : Colors.grey.withValues(alpha: 0.5),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
