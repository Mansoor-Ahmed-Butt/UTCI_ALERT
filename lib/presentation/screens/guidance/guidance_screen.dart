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
    final isDark = context.isDark;
    final dashboard = Get.find<DashboardController>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'guidance_title'.tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Obx(
              () => Text(
                '${'guidance_for'.tr} ${dashboard.activeRole.value.localizedLabel}',
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
                Row(
                  children: [
                    const Icon(Icons.water_drop, color: Colors.blueAccent, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'hydration_guard'.tr,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: controller.resetWater,
                  child: Text('hydration_reset'.tr, style: const TextStyle(fontSize: 12)),
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
                        text: '/ ${(target / 1000).toStringAsFixed(1)}L ${'goal_suffix'.tr}',
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
                    label: Text('add_glass'.tr),
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
                    label: Text('add_bottle'.tr),
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
                Row(
                  children: [
                    const Icon(Icons.checklist, color: AppColors.accent, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'shift_checklist'.tr,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                InkWell(
                  onTap: controller.readChecklistAloud,
                  child: Row(
                    children: [
                      const Icon(Icons.volume_up, size: 16, color: AppColors.accent),
                      const SizedBox(width: 4),
                      Text(
                        'listen'.tr,
                        style: const TextStyle(
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return Obx(() {
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
                          color: isDark ? Colors.white : Colors.black87,
                          decoration: checked ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      subtitle: Text(
                        item.description,
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.white60 : Colors.black54,
                        ),
                      ),
                      onChanged: (val) {
                        item.isChecked.value = val ?? false;
                      },
                    ),
                  );
                });
              },
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
              Row(
                children: [
                  const Icon(Icons.medical_services_outlined,
                      color: AppColors.extremeStress, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'emergency_triage'.tr,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              InkWell(
                onTap: controller.readFirstAidAloud,
                child: Row(
                  children: [
                    const Icon(Icons.volume_up, size: 16, color: AppColors.extremeStress),
                    const SizedBox(width: 4),
                    Text(
                      'listen'.tr,
                      style: const TextStyle(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'heat_exhaustion'.tr,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.strongStress,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('heat_exhaustion_s1'.tr, style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87)),
                      Text('heat_exhaustion_s2'.tr, style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87)),
                      Text('heat_exhaustion_s3'.tr, style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87)),
                      const SizedBox(height: 6),
                      Text(
                        'heat_exhaustion_action'.tr,
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'heatstroke_critical'.tr,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.extremeStress,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('heatstroke_s1'.tr, style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87)),
                      Text('heatstroke_s2'.tr, style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87)),
                      Text('heatstroke_s3'.tr, style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87)),
                      const SizedBox(height: 6),
                      Text(
                        'heatstroke_action'.tr,
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87),
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
          Row(
            children: [
              const Icon(Icons.roofing_outlined, color: AppColors.accent, size: 22),
              const SizedBox(width: 8),
              Text(
                'cooling_guide'.tr,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'cooling_guide_desc'.tr,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _coolingTips.length,
            itemBuilder: (itemContext, index) {
              final tip = _coolingTips[index];
              return _coolingTip(
                itemContext,
                title: tip['title']!.tr,
                desc: tip['desc']!.tr,
              );
            },
          ),
        ],
      ),
    );
  }

  static const List<Map<String, String>> _coolingTips = [
    {
      'title': 'tip_jute_title',
      'desc': 'tip_jute_desc',
    },
    {
      'title': 'tip_whitewash_title',
      'desc': 'tip_whitewash_desc',
    },
    {
      'title': 'tip_flushing_title',
      'desc': 'tip_flushing_desc',
    },
  ];

  Widget _coolingTip(BuildContext context,
      {required String title, required String desc}) {
    final isDark = context.isDark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline,
              color: AppColors.accent, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  height: 1.35,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
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
