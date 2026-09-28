import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../controllers/dashboard_controller.dart';
import '../../controllers/guidance_controller.dart';

class GuidanceScreen extends GetView<GuidanceController> {
  const GuidanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dashboard = Get.find<DashboardController>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Protective Toolkit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Obx(
              () => Text(
                'Personalized for ${dashboard.activeRole.value.label}',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: Responsive.contentWidth(context)),
              child: Responsive(
                mobile: _buildMobileContent(context, isDark: isDark),
                tablet: _buildTabletContent(context, isDark: isDark),
                desktop: _buildTabletContent(context, isDark: isDark),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileContent(BuildContext context, {required bool isDark}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHydrationTracker(context, isDark: isDark),
        const SizedBox(height: 20),
        _buildChecklistSection(context, isDark: isDark),
        const SizedBox(height: 20),
        _buildEmergencyTriage(context, isDark: isDark),
        const SizedBox(height: 20),
        _buildPassiveCoolingGuide(context, isDark: isDark),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildTabletContent(BuildContext context, {required bool isDark}) {
    return Column(
      children: [
        _buildHydrationTracker(context, isDark: isDark),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 5, child: _buildChecklistSection(context, isDark: isDark)),
            const SizedBox(width: 20),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  _buildEmergencyTriage(context, isDark: isDark),
                  const SizedBox(height: 20),
                  _buildPassiveCoolingGuide(context, isDark: isDark),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildHydrationTracker(BuildContext context, {required bool isDark}) {
    return Obx(() {
      final consumed = controller.consumedMilliliters.value;
      final target = controller.targetMilliliters.value;
      final progress = controller.hydrationProgress;

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
                    Icon(Icons.water_drop, color: Colors.blueAccent, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'Hydration Guard',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: controller.resetWater,
                  child: const Text('Reset', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    children: [
                      TextSpan(text: '${(consumed / 1000).toStringAsFixed(2)}L '),
                      TextSpan(
                        text: '/ ${(target / 1000).toStringAsFixed(1)}L goal',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white54 : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: isDark ? const Color(0xFF262E3B) : const Color(0xFFE2E7EE),
                valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('+250ml Glass'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => controller.logWater(250),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.local_drink, size: 16),
                    label: const Text('+500ml Bottle'),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => controller.logWater(500),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildChecklistSection(BuildContext context, {required bool isDark}) {
    return Obx(() {
      final list = controller.currentChecklist;

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
                    Icon(Icons.checklist, color: AppColors.accent, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'Shift Heat Preparedness',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                InkWell(
                  onTap: controller.readChecklistAloud,
                  child: const Row(
                    children: [
                      Icon(Icons.volume_up, size: 16, color: AppColors.accent),
                      SizedBox(width: 4),
                      Text(
                        'Listen',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...list.map(
              (item) => Obx(() {
                final checked = item.isChecked.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: checked
                        ? AppColors.noStress.withValues(alpha: 0.1)
                        : (isDark ? const Color(0xFF1F242F) : const Color(0xFFF7F8FA)),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: checked
                          ? AppColors.noStress.withValues(alpha: 0.4)
                          : Colors.transparent,
                    ),
                  ),
                  child: CheckboxListTile(
                    value: checked,
                    activeColor: AppColors.noStress,
                    secondary: Icon(
                      item.icon,
                      color: checked ? AppColors.noStress : AppColors.accent,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        decoration: checked ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text(
                      item.description,
                      style: const TextStyle(fontSize: 11),
                    ),
                    onChanged: (val) {
                      item.isChecked.value = val ?? false;
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildEmergencyTriage(BuildContext context, {required bool isDark}) {
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
                  Icon(Icons.medical_services_outlined,
                      color: AppColors.extremeStress, size: 22),
                  SizedBox(width: 8),
                  Text(
                    'Heatstroke Emergency Triage',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              InkWell(
                onTap: controller.readFirstAidAloud,
                child: const Row(
                  children: [
                    Icon(Icons.volume_up, size: 16, color: AppColors.extremeStress),
                    SizedBox(width: 4),
                    Text(
                      'Listen',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.extremeStress,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.strongStress.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppColors.strongStress.withValues(alpha: 0.3)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Heat Exhaustion',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.strongStress,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('• Cool, pale clammy skin', style: TextStyle(fontSize: 11)),
                      Text('• Heavy sweating', style: TextStyle(fontSize: 11)),
                      Text('• Dizziness & nausea', style: TextStyle(fontSize: 11)),
                      SizedBox(height: 6),
                      Text(
                        'Action: Move to shade, loosen clothes, sip cool water.',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.extremeStress.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppColors.extremeStress.withValues(alpha: 0.4)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Heat Stroke (CRITICAL)',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.extremeStress,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('• Core Temp > 40°C', style: TextStyle(fontSize: 11)),
                      Text('• Hot, red skin (dry/sweaty)', style: TextStyle(fontSize: 11)),
                      Text('• Confusion or delirium', style: TextStyle(fontSize: 11)),
                      SizedBox(height: 6),
                      Text(
                        'Action: Call 112 / Emergency! Douse with cold water.',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPassiveCoolingGuide(BuildContext context, {required bool isDark}) {
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
          const Row(
            children: [
              Icon(Icons.roofing_outlined, color: AppColors.accent, size: 22),
              SizedBox(width: 8),
              Text(
                'Informal Settlement Cooling Hacks',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Zero-electricity techniques co-designed for informal settlement realities',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
          ),
          const SizedBox(height: 12),
          _coolingTip(
            title: 'Damp Jute Window Screen',
            desc: 'Hang wet burlap across open windows; air passing through drops 3-5°C.',
          ),
          _coolingTip(
            title: 'Whitewash Corrugated Tin Roofs',
            desc: 'Calcium lime whitewash reflects 75% of solar heat, saving living areas from baking.',
          ),
          _coolingTip(
            title: 'Night Thermal Flushing',
            desc: 'Open opposing high vents after sunset to purge heat stored in walls and metal sheets.',
          ),
        ],
      ),
    );
  }

  Widget _coolingTip({required String title, required String desc}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: AppColors.accent, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 12, height: 1.35),
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
