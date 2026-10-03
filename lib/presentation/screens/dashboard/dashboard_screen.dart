import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/user_role.dart';
import '../../../services/native_language_service.dart';
import '../../../services/tts_service.dart';
import '../../controllers/dashboard_controller.dart';
import '../../widgets/city_selector_sheet.dart';
import '../../widgets/geofence_detail_dialog.dart';
import '../../widgets/metric_card.dart';
import '../../widgets/utci_gauge.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final status = controller.status.value;
          final weather = controller.weather.value;
          final city = controller.selectedCity.value;
          final role = controller.activeRole.value;
          final advice = controller.dynamicAdvice.value;
          final lang = controller.nativeLanguage.value;
          final geofence = controller.geofenceStatus.value;

          return RefreshIndicator(
            onRefresh: controller.refreshData,
            color: AppColors.accent,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.contentWidth(context),
                  ),
                  child: Responsive(
                    mobile: _buildContent(
                      context,
                      status: status,
                      weather: weather,
                      city: city,
                      role: role,
                      advice: advice,
                      lang: lang,
                      geofence: geofence,
                      isDark: isDark,
                      isWide: false,
                    ),
                    tablet: _buildContent(
                      context,
                      status: status,
                      weather: weather,
                      city: city,
                      role: role,
                      advice: advice,
                      lang: lang,
                      geofence: geofence,
                      isDark: isDark,
                      isWide: true,
                    ),
                    desktop: _buildContent(
                      context,
                      status: status,
                      weather: weather,
                      city: city,
                      role: role,
                      advice: advice,
                      lang: lang,
                      geofence: geofence,
                      isDark: isDark,
                      isWide: true,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required dynamic status,
    required dynamic weather,
    required dynamic city,
    required dynamic role,
    required dynamic advice,
    required NativeLanguage lang,
    required dynamic geofence,
    required bool isDark,
    required bool isWide,
  }) {
    if (isWide) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTopBar(context, city: city, role: role, lang: lang, geofence: geofence, isDark: isDark),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    _buildGaugeCard(context, status: status, lang: lang, isDark: isDark),
                    const SizedBox(height: 14),
                    _buildNativeAlertBanner(context, status: status, role: role, lang: lang, isDark: isDark),
                    const SizedBox(height: 14),
                    _buildHourlyMiniTrend(context, isDark: isDark),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    if (advice != null) _buildDeClutteredAdviceGrid(context, advice: advice, isDark: isDark),
                    const SizedBox(height: 14),
                    if (weather != null) _buildMetricsGrid(context, weather: weather),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTopBar(context, city: city, role: role, lang: lang, geofence: geofence, isDark: isDark),
        const SizedBox(height: 16),

        // UTCI Gauge Card
        _buildGaugeCard(context, status: status, lang: lang, isDark: isDark),
        const SizedBox(height: 14),

        // High Impact Native Language Alert Banner (Clean, no wall of text!)
        _buildNativeAlertBanner(context, status: status, role: role, lang: lang, isDark: isDark),
        const SizedBox(height: 14),

        // AI Safety Action Micro-Cards
        if (advice != null) ...[
          _buildDeClutteredAdviceGrid(context, advice: advice, isDark: isDark),
          const SizedBox(height: 14),
        ],

        // Environmental Metrics Grid
        if (weather != null) ...[
          _buildMetricsGrid(context, weather: weather),
          const SizedBox(height: 14),
        ],

        // 24H Mini Progression
        _buildHourlyMiniTrend(context, isDark: isDark),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildTopBar(
    BuildContext context, {
    required dynamic city,
    required dynamic role,
    required NativeLanguage lang,
    required dynamic geofence,
    required bool isDark,
  }) {
    final isDanger = geofence.isInsideDangerZone;
    final geofenceColor = isDanger ? AppColors.extremeStress : const Color(0xFF10B981);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            // City / Location Selector Pill
            Expanded(
              child: InkWell(
                onTap: () => _openCitySelector(context),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1B202A) : const Color(0xFFF1F3F7),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on, color: AppColors.accent, size: 17),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          city.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down, size: 16),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Profile Switcher Pill
            InkWell(
              onTap: () => _openProfileSelector(context),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.accent.withValues(alpha: 0.35)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(role.icon, color: AppColors.accent, size: 15),
                    const SizedBox(width: 5),
                    Text(
                      role.localizedLabel,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.5,
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(Icons.swap_horiz, size: 14, color: AppColors.accent),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Sub-bar: Geofence Badge & Language Selector Pill
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Geofence Status Pill
            InkWell(
              onTap: () => _openGeofenceDialog(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: geofenceColor.withValues(alpha: isDark ? 0.16 : 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: geofenceColor.withValues(alpha: 0.4), width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isDanger ? Icons.warning_amber_rounded : Icons.shield_outlined,
                      color: geofenceColor,
                      size: 13,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      geofence.badgeLabel,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: geofenceColor,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.info_outline, size: 12, color: geofenceColor),
                  ],
                ),
              ),
            ),

            // Native Language Selector Pill
            InkWell(
              onTap: () => _openLanguageSelector(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E2430) : const Color(0xFFEBF0F7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(lang.flag, style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 5),
                    Text(
                      lang.nativeName,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(Icons.keyboard_arrow_down, size: 13),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGaugeCard(
    BuildContext context, {
    required dynamic status,
    required NativeLanguage lang,
    required bool isDark,
  }) {
    final val = status?.value ?? 34.0;
    final cat = status?.category ?? 'strong';
    final catLabel = status?.categoryLabel ?? 'Strong Heat Stress';
    final tts = Get.find<TtsService>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161A22) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'radar_title'.tr,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'radar_subtitle'.tr,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ],
              ),

              // Voice Read Aloud Button
              Obx(() {
                final isSpeaking = tts.isSpeaking.value;
                return InkWell(
                  onTap: controller.readAlertAloud,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSpeaking ? AppColors.accent : AppColors.accent.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.accent.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSpeaking ? Icons.volume_up : Icons.volume_up_outlined,
                          size: 15,
                          color: isSpeaking ? Colors.black87 : AppColors.accent,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          isSpeaking ? 'stop'.tr : '${'voice_label'.tr} (${lang.code.toUpperCase()})',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isSpeaking ? Colors.black87 : AppColors.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: UtciGauge(
              value: val,
              category: cat,
              categoryLabel: catLabel,
              size: 215,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'radar_desc'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white38 : Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

  /// High-impact native language warning banner.
  /// Extremely clean: 1-2 sentence core message + 3 quick glanceable action badges.
  Widget _buildNativeAlertBanner(
    BuildContext context, {
    required dynamic status,
    required dynamic role,
    required NativeLanguage lang,
    required bool isDark,
  }) {
    final cat = status?.category ?? 'strong';
    final utci = status?.value ?? 34.0;
    final color = AppColors.statusColor(cat);

    final langService = Get.find<NativeLanguageService>();
    final nativeWarning = langService.getNativeWarning(
      category: cat,
      role: role,
      utci: utci,
      lang: lang,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.16 : 0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'live_hazard_advisory'.tr,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${lang.nativeName} (${lang.code.toUpperCase()})',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.volume_up, size: 18),
                color: color,
                tooltip: 'listen_in_lang'.trParams({'lang': lang.nativeName}),
                onPressed: controller.readAlertAloud,
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Native warning text
          Text(
            nativeWarning,
            textDirection: lang.isRtl ? TextDirection.rtl : TextDirection.ltr,
            style: TextStyle(
              fontSize: 13.5,
              height: 1.45,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white.withValues(alpha: 0.95) : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          // 3 Quick Action Pills (No wall of text!)
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _actionChip(
                icon: Icons.timer_outlined,
                label: utci >= 38 ? 'chip_rest_extreme'.tr : 'chip_rest_normal'.tr,
                color: color,
                isDark: isDark,
              ),
              _actionChip(
                icon: Icons.water_drop_outlined,
                label: utci >= 38 ? 'chip_water_extreme'.tr : 'chip_water_normal'.tr,
                color: color,
                isDark: isDark,
              ),
              _actionChip(
                icon: Icons.wb_shade_outlined,
                label: 'deep_shade_mandatory'.tr,
                color: color,
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionChip({
    required IconData icon,
    required String label,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E232E) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  /// 4-Tile Modern Micro-Cards replacing the old long text rows
  Widget _buildDeClutteredAdviceGrid(
    BuildContext context, {
    required dynamic advice,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161A22) : Colors.white,
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
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.auto_awesome, size: 16, color: AppColors.accent),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'ai_safety_plan'.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5),
                  ),
                ],
              ),
              Text(
                'instant_field_protocol'.tr,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white38 : Colors.black45,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            advice.headline,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 12),

          // 2x2 Clean Tile Layout
          Row(
            children: [
              Expanded(
                child: _adviceTile(
                  title: 'work_rest_label'.tr,
                  value: advice.workRestCycle,
                  icon: Icons.timer_outlined,
                  color: Colors.amber,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _adviceTile(
                  title: 'hydration_label'.tr,
                  value: advice.hydrationGoal,
                  icon: Icons.water_drop_outlined,
                  color: Colors.blueAccent,
                  isDark: isDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _adviceTile(
                  title: 'field_action_label'.tr,
                  value: advice.profileAction,
                  icon: Icons.shield_outlined,
                  color: Colors.tealAccent,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _adviceTile(
                  title: 'cooling_method_label'.tr,
                  value: advice.coolingMethod,
                  icon: Icons.ac_unit_outlined,
                  color: AppColors.accent,
                  isDark: isDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _adviceTile({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E232E) : const Color(0xFFF6F8FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 5),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 11.5,
              height: 1.3,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(BuildContext context, {required dynamic weather}) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.62,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        MetricCard(
          label: 'air_temp'.tr,
          value: weather.airTemperature.toStringAsFixed(1),
          unit: '°C',
          icon: Icons.thermostat_outlined,
          iconColor: Colors.deepOrangeAccent,
          subtitle: weather.weatherDescription,
        ),
        MetricCard(
          label: 'rel_humidity'.tr,
          value: weather.relativeHumidity.toStringAsFixed(0),
          unit: '%',
          icon: Icons.water_drop_outlined,
          iconColor: Colors.blueAccent,
          subtitle: weather.relativeHumidity > 60
              ? 'high_sweat_barrier'.tr
              : 'normal_sweat_rate'.tr,
        ),
        MetricCard(
          label: 'wind_speed'.tr,
          value: weather.windSpeedKmh.toStringAsFixed(1),
          unit: 'km/h',
          icon: Icons.air,
          iconColor: Colors.tealAccent,
          subtitle: '${weather.windSpeedMps.toStringAsFixed(1)} m/s ${'airflow_suffix'.tr}',
        ),
        MetricCard(
          label: 'apparent_heat'.tr,
          value: weather.apparentTemperature.toStringAsFixed(1),
          unit: '°C',
          icon: Icons.wb_sunny_outlined,
          iconColor: AppColors.accent,
          subtitle: 'direct_solar_radiance'.tr,
        ),
      ],
    );
  }

  Widget _buildHourlyMiniTrend(BuildContext context, {required bool isDark}) {
    return Obx(() {
      final list = controller.hourlyPoints;
      if (list.isEmpty) return const SizedBox.shrink();

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF161A22) : Colors.white,
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
                Text(
                  'hourly_progression'.tr,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                ),
                Text(
                  'hourly_curve'.tr,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 94,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final point = list[index];
                  final color = AppColors.statusColor(point.category);

                  return Container(
                    width: 58,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: point.isPeakDanger
                          ? color.withValues(alpha: 0.16)
                          : (isDark ? const Color(0xFF1E232E) : const Color(0xFFF6F8FA)),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: point.isPeakDanger ? color : (isDark ? AppColors.dividerDark : AppColors.dividerLight),
                        width: point.isPeakDanger ? 1.4 : 1.0,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          point.hourLabel,
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ),
                        Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                        ),
                        Text(
                          '${point.utciValue.toStringAsFixed(0)}°',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  void _openCitySelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CitySelectorSheet(
        currentCity: controller.selectedCity.value,
        onCitySelected: controller.selectCity,
        onUseGps: controller.useGpsLocation,
      ),
    );
  }

  void _openGeofenceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => GeofenceDetailDialog(
        status: controller.geofenceStatus.value,
        onRefreshLocation: controller.useGpsLocation,
      ),
    );
  }

  void _openLanguageSelector(BuildContext context) {
    final isDark = context.isDark;
    const languages = NativeLanguageService.supportedLanguages;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(sheetContext).size.height * 0.75,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF151922) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'choose_language'.tr,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                'choose_language_desc'.tr,
                style: const TextStyle(fontSize: 11.5, color: Colors.grey),
              ),
              const SizedBox(height: 14),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    final lang = languages[index];
                    final isSelected = controller.nativeLanguage.value.code == lang.code;
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      leading: Text(lang.flag, style: const TextStyle(fontSize: 22)),
                      title: Text(
                        lang.nativeName,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          color: isSelected ? AppColors.accent : null,
                        ),
                      ),
                      subtitle: Text(
                        '${lang.name} (${lang.ttsLocale})',
                        style: const TextStyle(fontSize: 11),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: AppColors.accent, size: 20)
                          : null,
                      onTap: () {
                        controller.selectLanguage(lang);
                        Navigator.pop(sheetContext);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _openProfileSelector(BuildContext context) {
    const roles = UserRole.values;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final isDark = sheetContext.isDark;
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(sheetContext).size.height * 0.75,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF151922) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'switch_profile'.tr,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                'switch_profile_desc'.tr,
                style: const TextStyle(fontSize: 11.5, color: Colors.grey),
              ),
              const SizedBox(height: 14),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: roles.length,
                  itemBuilder: (context, index) {
                    final role = roles[index];
                    final isSelected = controller.activeRole.value == role;
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      leading: Icon(
                        role.icon,
                        color: isSelected ? AppColors.accent : (isDark ? Colors.white70 : Colors.black87),
                      ),
                      title: Text(
                        role.localizedLabel,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? AppColors.accent : null,
                        ),
                      ),
                      subtitle: Text(role.localizedDescription, style: const TextStyle(fontSize: 11)),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: AppColors.accent, size: 20)
                          : null,
                      onTap: () {
                        controller.selectRole(role);
                        Navigator.pop(sheetContext);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
