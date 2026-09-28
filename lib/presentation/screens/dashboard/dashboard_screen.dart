import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../controllers/dashboard_controller.dart';
import '../../widgets/city_selector_sheet.dart';
import '../../widgets/metric_card.dart';
import '../../widgets/utci_gauge.dart';
import '../../../data/models/user_role.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final status = controller.status.value;
          final weather = controller.weather.value;
          final city = controller.selectedCity.value;
          final role = controller.activeRole.value;
          final advice = controller.dynamicAdvice.value;

          return RefreshIndicator(
            onRefresh: controller.refreshData,
            color: AppColors.accent,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.contentWidth(context),
                  ),
                  child: Responsive(
                    mobile: _buildMobileLayout(
                      context,
                      status: status,
                      weather: weather,
                      city: city,
                      role: role,
                      advice: advice,
                      isDark: isDark,
                    ),
                    tablet: _buildTabletLayout(
                      context,
                      status: status,
                      weather: weather,
                      city: city,
                      role: role,
                      advice: advice,
                      isDark: isDark,
                    ),
                    desktop: _buildTabletLayout(
                      context,
                      status: status,
                      weather: weather,
                      city: city,
                      role: role,
                      advice: advice,
                      isDark: isDark,
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

  Widget _buildTopBar(
    BuildContext context, {
    required dynamic city,
    required dynamic role,
    required bool isDark,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // City Selector Pill
            InkWell(
              onTap: () => _openCitySelector(context),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E232E)
                      : const Color(0xFFF0F2F6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color:
                        isDark ? AppColors.dividerDark : AppColors.dividerLight,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on,
                        color: AppColors.accent, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      city.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, size: 18),
                  ],
                ),
              ),
            ),

            // Profile Switcher Pill
            InkWell(
              onTap: () => _openProfileSelector(context),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.accent.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(role.icon, color: AppColors.accent, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      role.label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(Icons.swap_horiz,
                        size: 16, color: AppColors.accent),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            city.historicalTrend,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white38 : Colors.black45,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(
    BuildContext context, {
    required dynamic status,
    required dynamic weather,
    required dynamic city,
    required dynamic role,
    required dynamic advice,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTopBar(context, city: city, role: role, isDark: isDark),
        const SizedBox(height: 20),

        // UTCI Gauge Card
        _buildGaugeCard(context, status: status, isDark: isDark),
        const SizedBox(height: 16),

        // Plain Language Alert Banner
        _buildAlertBanner(context, status: status, role: role, isDark: isDark),
        const SizedBox(height: 16),

        // AI Dynamic Action Card
        if (advice != null) ...[
          _buildAdviceCard(context, advice: advice, isDark: isDark),
          const SizedBox(height: 16),
        ],

        // Environmental Metrics Grid
        if (weather != null) ...[
          _buildMetricsGrid(context, weather: weather),
          const SizedBox(height: 16),
        ],

        // 24H Mini Trend
        _buildHourlyMiniTrend(context, isDark: isDark),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildTabletLayout(
    BuildContext context, {
    required dynamic status,
    required dynamic weather,
    required dynamic city,
    required dynamic role,
    required dynamic advice,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTopBar(context, city: city, role: role, isDark: isDark),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column (Gauge & Plain Alert)
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  _buildGaugeCard(context, status: status, isDark: isDark),
                  const SizedBox(height: 16),
                  _buildAlertBanner(context,
                      status: status, role: role, isDark: isDark),
                  const SizedBox(height: 16),
                  _buildHourlyMiniTrend(context, isDark: isDark),
                ],
              ),
            ),
            const SizedBox(width: 20),

            // Right Column (Advice & Metrics)
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  if (advice != null)
                    _buildAdviceCard(context, advice: advice, isDark: isDark),
                  const SizedBox(height: 16),
                  if (weather != null)
                    _buildMetricsGrid(context, weather: weather),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildGaugeCard(BuildContext context,
      {required dynamic status, required bool isDark}) {
    final val = status?.value ?? 34.0;
    final cat = status?.category ?? 'strong';
    final catLabel = status?.categoryLabel ?? 'Strong Heat Stress';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF171B22) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
                  const Text(
                    'THERMAL COMFORT RADAR',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'ERA5-HEAT Reanalysis Standard',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.volume_up_outlined,
                    color: AppColors.accent),
                tooltip: 'Listen to heat conditions',
                onPressed: controller.readAlertAloud,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: UtciGauge(
              value: val,
              category: cat,
              categoryLabel: catLabel,
              size: 230,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Combines temperature, humidity, wind & direct solar load',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white38 : Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertBanner(
    BuildContext context, {
    required dynamic status,
    required dynamic role,
    required bool isDark,
  }) {
    final cat = status?.category ?? 'strong';
    final color = AppColors.statusColor(cat);
    final warningText = status?.suggestion ??
        'Elevated thermal strain. Stay hydrated and schedule frequent shade rests.';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.18 : 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.warning_amber_rounded,
                color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Community Heat Alert',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  warningText,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.9)
                        : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceCard(BuildContext context,
      {required dynamic advice, required bool isDark}) {
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
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.auto_awesome,
                        size: 18, color: AppColors.accent),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'AI Heat Safety Plan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: controller.readAlertAloud,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.volume_up, size: 14, color: Colors.black87),
                      SizedBox(width: 4),
                      Text(
                        'Read Aloud',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            advice.headline,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          _adviceRow(
            icon: Icons.timer_outlined,
            title: 'Work / Rest Cycle',
            content: advice.workRestCycle,
            isDark: isDark,
          ),
          const SizedBox(height: 10),
          _adviceRow(
            icon: Icons.water_drop_outlined,
            title: 'Hydration Target',
            content: advice.hydrationGoal,
            isDark: isDark,
          ),
          const SizedBox(height: 10),
          _adviceRow(
            icon: Icons.task_alt_outlined,
            title: 'Targeted Action',
            content: advice.profileAction,
            isDark: isDark,
          ),
          const SizedBox(height: 10),
          _adviceRow(
            icon: Icons.ac_unit_outlined,
            title: 'Cooling Technique',
            content: advice.coolingMethod,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _adviceRow({
    required IconData icon,
    required String title,
    required String content,
    required bool isDark,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 17, color: AppColors.accent),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 13,
                height: 1.35,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
              children: [
                TextSpan(
                  text: '$title: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: content),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsGrid(BuildContext context, {required dynamic weather}) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.55,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        MetricCard(
          label: 'Air Temperature',
          value: weather.airTemperature.toStringAsFixed(1),
          unit: '°C',
          icon: Icons.thermostat_outlined,
          iconColor: Colors.deepOrangeAccent,
          subtitle: weather.weatherDescription,
        ),
        MetricCard(
          label: 'Relative Humidity',
          value: weather.relativeHumidity.toStringAsFixed(0),
          unit: '%',
          icon: Icons.water_drop_outlined,
          iconColor: Colors.blueAccent,
          subtitle: weather.relativeHumidity > 60
              ? 'High sweat barrier'
              : 'Moderate sweat rate',
        ),
        MetricCard(
          label: 'Wind Speed',
          value: weather.windSpeedKmh.toStringAsFixed(1),
          unit: 'km/h',
          icon: Icons.air,
          iconColor: Colors.tealAccent,
          subtitle: '${weather.windSpeedMps.toStringAsFixed(1)} m/s airflow',
        ),
        MetricCard(
          label: 'Apparent Heat',
          value: weather.apparentTemperature.toStringAsFixed(1),
          unit: '°C',
          icon: Icons.wb_sunny_outlined,
          iconColor: AppColors.accent,
          subtitle: 'Direct radiation load',
        ),
      ],
    );
  }

  Widget _buildHourlyMiniTrend(BuildContext context, {required bool isDark}) {
    return Obx(() {
      final list = controller.hourlyPoints;
      if (list.isEmpty) return const SizedBox.shrink();

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '24-Hour Heat Stress Curve',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'UTCI Category Progression',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final point = list[index];
                  final color = AppColors.statusColor(point.category);

                  return Container(
                    width: 62,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: point.isPeakDanger
                          ? color.withValues(alpha: 0.16)
                          : (isDark
                              ? const Color(0xFF1F242F)
                              : const Color(0xFFF6F7F9)),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: point.isPeakDanger
                            ? color
                            : (isDark
                                ? AppColors.dividerDark
                                : AppColors.dividerLight),
                        width: point.isPeakDanger ? 1.5 : 1.0,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          point.hourLabel,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          '${point.utciValue.toStringAsFixed(0)}°',
                          style: TextStyle(
                            fontSize: 13,
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

  void _openProfileSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final isDark = Theme.of(sheetContext).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkMode : Colors.white,
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
              const SizedBox(height: 16),
              const Text(
                'Switch Vulnerability Profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Dynamically adjusts work-rest ratios, hydration targets, and AI warnings.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ...controller.activeRole.value.runtimeType == Null
                  ? []
                  : UserRole.values.map(
                      (role) => Obx(() {
                        final isSelected = controller.activeRole.value == role;
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          leading: Icon(role.icon,
                              color: isSelected
                                  ? AppColors.accent
                                  : (isDark ? Colors.white70 : Colors.black87)),
                          title: Text(
                            role.label,
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected ? AppColors.accent : null,
                            ),
                          ),
                          subtitle: Text(
                            role.description,
                            style: const TextStyle(fontSize: 11),
                          ),
                          trailing: isSelected
                              ? const Icon(Icons.check_circle,
                                  color: AppColors.accent)
                              : null,
                          onTap: () {
                            controller.selectRole(role);
                            Navigator.pop(sheetContext);
                          },
                        );
                      }),
                    ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
