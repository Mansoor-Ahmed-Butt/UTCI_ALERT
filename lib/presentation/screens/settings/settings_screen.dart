import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../controllers/dashboard_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../../data/models/user_role.dart';
import '../../widgets/theme_toggle_switch.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dashboard = Get.find<DashboardController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings & Profile',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: ThemeToggleSwitch(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: Responsive.contentWidth(context)),
              child: Responsive(
                mobile: _buildContent(context, dashboard: dashboard, isDark: isDark),
                tablet: _buildTabletContent(context, dashboard: dashboard, isDark: isDark),
                desktop: _buildTabletContent(context, dashboard: dashboard, isDark: isDark),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required DashboardController dashboard,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildProfileSection(context, dashboard: dashboard, isDark: isDark),
        const SizedBox(height: 20),
        _buildVoiceTtsSection(context, isDark: isDark),
        const SizedBox(height: 20),
        _buildAlertThresholdSection(context, isDark: isDark),
        const SizedBox(height: 20),
        _buildScientificAboutSection(context, isDark: isDark),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildTabletContent(
    BuildContext context, {
    required DashboardController dashboard,
    required bool isDark,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              _buildProfileSection(context, dashboard: dashboard, isDark: isDark),
              const SizedBox(height: 20),
              _buildVoiceTtsSection(context, isDark: isDark),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              _buildAlertThresholdSection(context, isDark: isDark),
              const SizedBox(height: 20),
              _buildScientificAboutSection(context, isDark: isDark),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(
    BuildContext context, {
    required DashboardController dashboard,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF171B22) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Active User Profile',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Select your profile to automatically adapt alert messaging, tone, and guidance.',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
          const SizedBox(height: 14),
          ...UserRole.values.map((role) {
            return Obx(() {
              final isSelected = dashboard.activeRole.value == role;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.accent.withValues(alpha: isDark ? 0.18 : 0.12)
                      : (isDark ? const Color(0xFF1E232E) : const Color(0xFFF7F8FA)),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? AppColors.accent : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.accent
                          : (isDark ? const Color(0xFF282E3C) : const Color(0xFFE8EBF0)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      role.icon,
                      size: 20,
                      color: isSelected ? Colors.black87 : (isDark ? Colors.white70 : Colors.black87),
                    ),
                  ),
                  title: Text(
                    role.label,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      fontSize: 14,
                      color: isSelected ? AppColors.accent : null,
                    ),
                  ),
                  subtitle: Text(
                    role.description,
                    style: const TextStyle(fontSize: 11),
                  ),
                  trailing: Icon(
                    isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: isSelected ? AppColors.accent : Colors.grey.withValues(alpha: 0.5),
                  ),
                  onTap: () => controller.setRole(role),
                ),
              );
            });
          }),
        ],
      ),
    );
  }

  Widget _buildVoiceTtsSection(BuildContext context, {required bool isDark}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF171B22) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.record_voice_over_outlined,
                      color: AppColors.accent, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Voice Engine (TTS)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              FilledButton.tonal(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accent.withValues(alpha: 0.2),
                ),
                onPressed: controller.testVoice,
                child: const Text(
                  'Test Voice',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'On-device speech synthesizer. Enables hands-free audio alerts while riding or working.',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Speech Speed', style: TextStyle(fontSize: 13)),
              Obx(() => Text('${(controller.speechRate * 2).toStringAsFixed(1)}x',
                  style: const TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          Obx(
            () => Slider(
              value: controller.speechRate,
              min: 0.2,
              max: 1.0,
              divisions: 8,
              activeColor: AppColors.accent,
              onChanged: controller.setSpeechRate,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Voice Pitch', style: TextStyle(fontSize: 13)),
              Obx(() => Text(controller.pitch.toStringAsFixed(1),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          Obx(
            () => Slider(
              value: controller.pitch,
              min: 0.5,
              max: 1.5,
              divisions: 10,
              activeColor: AppColors.accent,
              onChanged: controller.setPitch,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertThresholdSection(
      BuildContext context, {required bool isDark}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF171B22) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Alert Trigger Threshold',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Obx(
                () => Text(
                  '${controller.alertThreshold.value.toInt()}°C UTCI',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Notify with audio and banner when local thermal index exceeds this limit.',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => Slider(
              value: controller.alertThreshold.value,
              min: 26.0,
              max: 46.0,
              divisions: 10,
              activeColor: AppColors.statusColor(
                controller.alertThreshold.value >= 46
                    ? 'extreme'
                    : controller.alertThreshold.value >= 38
                        ? 'very_strong'
                        : 'strong',
              ),
              onChanged: controller.setThreshold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScientificAboutSection(
      BuildContext context, {required bool isDark}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF171B22) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About UTCI Alert & Science Basis',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            'Intechvia Flutter Internship Programme · Innovation Sprint\nAuthor: Mansoor Ahmed\nVersion: 1.0 Production Edition',
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          const Text(
            'Scientific References & Data Sources:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          _refItem(
            title: 'ERA5-HEAT Global Reanalysis (1974–2023)',
            desc: '50-year 0.25°x0.25° grid bioclimatic heat index reanalysis (Hersbach et al. 2020).',
          ),
          _refItem(
            title: 'African Urban Heatwaves Study',
            desc: 'Extreme heat doubling across Alexandria, Algiers, Tunis, Kano, Dakar, Ibadan (Igun et al. 2022).',
          ),
          _refItem(
            title: 'CHEWS Early Warning (Nigeria)',
            desc: 'Community-Centred Heat Early Warning System benchmark (Adegun et al. 2026).',
          ),
        ],
      ),
    );
  }

  Widget _refItem({required String title, required String desc}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.bookmark_border, size: 14, color: AppColors.accent),
          const SizedBox(width: 6),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 11, height: 1.35),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: desc),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
