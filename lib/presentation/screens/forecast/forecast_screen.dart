import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../controllers/dashboard_controller.dart';
import '../../controllers/forecast_controller.dart';
import '../../widgets/status_badge.dart';

class ForecastScreen extends GetView<ForecastController> {
  const ForecastScreen({super.key});

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
              'Heat Stress Forecast',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Obx(
              () => Text(
                '${dashboard.selectedCity.value.displayName} · Bioclimatic Projections',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up_outlined, color: AppColors.accent),
            tooltip: 'Listen to forecast',
            onPressed: controller.readForecastAloud,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh forecast',
            onPressed: controller.loadForecast,
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            );
          }

          final sw = controller.safeWindows.value;
          final hourly = controller.hourlyList;
          final daily = controller.dailyList;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Responsive.contentWidth(context),
                ),
                child: Responsive(
                  mobile: _buildContent(
                    context,
                    sw: sw,
                    hourly: hourly,
                    daily: daily,
                    isDark: isDark,
                  ),
                  tablet: _buildTabletContent(
                    context,
                    sw: sw,
                    hourly: hourly,
                    daily: daily,
                    isDark: isDark,
                  ),
                  desktop: _buildTabletContent(
                    context,
                    sw: sw,
                    hourly: hourly,
                    daily: daily,
                    isDark: isDark,
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
    required dynamic sw,
    required dynamic hourly,
    required dynamic daily,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (sw != null) ...[
          _buildSafeWindowsCard(context, sw: sw, isDark: isDark),
          const SizedBox(height: 20),
        ],
        _buildHourlySection(context, hourly: hourly, isDark: isDark),
        const SizedBox(height: 24),
        _build7DaySection(context, daily: daily, isDark: isDark),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildTabletContent(
    BuildContext context, {
    required dynamic sw,
    required dynamic hourly,
    required dynamic daily,
    required bool isDark,
  }) {
    return Column(
      children: [
        if (sw != null) ...[
          _buildSafeWindowsCard(context, sw: sw, isDark: isDark),
          const SizedBox(height: 24),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child:
                  _buildHourlySection(context, hourly: hourly, isDark: isDark),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 5,
              child: _build7DaySection(context, daily: daily, isDark: isDark),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildSafeWindowsCard(BuildContext context,
      {required dynamic sw, required bool isDark}) {
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
                  Icon(Icons.schedule, color: AppColors.accent, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Safe Outdoor Work Windows',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: controller.readForecastAloud,
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
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _windowBox(
                  title: 'Morning Window',
                  time: sw.morningWindow,
                  status: 'Safe / Moderate',
                  color: AppColors.noStress,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _windowBox(
                  title: 'Peak Danger',
                  time: sw.dangerWindow,
                  status: 'Very Strong',
                  color: AppColors.veryStrongStress,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _windowBox(
                  title: 'Evening Window',
                  time: sw.eveningWindow,
                  status: 'Recommended',
                  color: AppColors.accent,
                  isDark: isDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            sw.recommendation,
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _windowBox({
    required String title,
    required String time,
    required String status,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.15 : 0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            status,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlySection(BuildContext context,
      {required dynamic hourly, required bool isDark}) {
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
            'Hourly UTCI Timeline (24 Hours)',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Physiological thermal stress calculated per hour',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
          ),
          const SizedBox(height: 14),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: hourly.length > 10 ? 10 : hourly.length,
            separatorBuilder: (_, __) => Divider(
              color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final item = hourly[index];
              final catColor = AppColors.statusColor(item.category);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 52,
                      child: Text(
                        item.hourLabel,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: catColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'UTCI ${item.utciValue.toStringAsFixed(1)}°C',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: catColor,
                            ),
                          ),
                          Text(
                            'Temp: ${item.temperature.toStringAsFixed(0)}°C · Humidity: ${item.humidity.toStringAsFixed(0)}%',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    StatusBadge(
                      category: item.category,
                      label: item.isPeakDanger ? 'DANGER' : item.category,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _build7DaySection(BuildContext context,
      {required dynamic daily, required bool isDark}) {
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
                '7-Day Heatwave Risk Radar',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'ERA5-HEAT Model',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Detects extended multi-day heat episodes (3-5 day duration risk)',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
          ),
          const SizedBox(height: 14),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: daily.length,
            separatorBuilder: (_, __) => Divider(
              color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final d = daily[index];
              final catColor = AppColors.statusColor(d.maxCategory);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 72,
                      child: Text(
                        d.dayLabel,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.wb_sunny_outlined,
                              size: 16, color: catColor),
                          const SizedBox(width: 8),
                          Text(
                            'Max ${d.maxUtci.toStringAsFixed(0)}°C',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: catColor,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Min ${d.minUtci.toStringAsFixed(0)}°C',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (d.isHeatwaveDay) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color:
                              AppColors.extremeStress.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color:
                                AppColors.extremeStress.withValues(alpha: 0.4),
                          ),
                        ),
                        child: const Text(
                          'HEATWAVE',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: AppColors.extremeStress,
                          ),
                        ),
                      ),
                    ] else ...[
                      Text(
                        'Normal',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white38 : Colors.black38,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
