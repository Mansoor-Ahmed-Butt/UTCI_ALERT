import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../controllers/main_nav_controller.dart';
import '../widgets/audio_player_bar.dart';
import 'ai_advisor/ai_advisor_screen.dart';
import 'dashboard/dashboard_screen.dart';
import 'forecast/forecast_screen.dart';
import 'guidance/guidance_screen.dart';
import 'settings/settings_screen.dart';

class MainNavScreen extends GetView<MainNavController> {
  const MainNavScreen({super.key});

  static const List<Widget> _screens = [
    DashboardScreen(),
    ForecastScreen(),
    AiAdvisorScreen(),
    GuidanceScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildMobileScaffold(context),
      tablet: _buildTabletScaffold(context),
      desktop: _buildTabletScaffold(context),
    );
  }

  Widget _buildMobileScaffold(BuildContext context) {
    final isDark = context.isDark;

    return Obx(() {
      final index = controller.currentIndex.value;

      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const AudioPlayerBar(),
              Expanded(
                child: IndexedStack(
                  index: index,
                  children: _screens,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: controller.changeTab,
          backgroundColor: isDark ? AppColors.darkMode : Colors.white,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.radar_outlined),
              selectedIcon: const Icon(Icons.radar, color: AppColors.accent),
              label: 'nav_radar'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.timeline_outlined),
              selectedIcon: const Icon(Icons.timeline, color: AppColors.accent),
              label: 'nav_forecast'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.psychology_outlined),
              selectedIcon: const Icon(Icons.psychology, color: AppColors.accent),
              label: 'nav_ai'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.health_and_safety_outlined),
              selectedIcon:
                  const Icon(Icons.health_and_safety, color: AppColors.accent),
              label: 'nav_toolkit'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.tune_outlined),
              selectedIcon: const Icon(Icons.tune, color: AppColors.accent),
              label: 'nav_settings'.tr,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTabletScaffold(BuildContext context) {
    final isDark = context.isDark;

    return Obx(() {
      final index = controller.currentIndex.value;

      return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final isCompact = constraints.maxHeight < 480;

                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: NavigationRail(
                          selectedIndex: index,
                          onDestinationSelected: controller.changeTab,
                          labelType: NavigationRailLabelType.all,
                          backgroundColor:
                              isDark ? AppColors.darkMode : Colors.white,
                          indicatorColor: isDark
                              ? AppColors.accentDarkMuted
                              : AppColors.accentMuted,
                          minWidth: isCompact ? 64 : 72,
                          groupAlignment: -1.0,
                          selectedLabelTextStyle: TextStyle(
                            fontSize: isCompact ? 10 : 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accent,
                          ),
                          unselectedLabelTextStyle: TextStyle(
                            fontSize: isCompact ? 10 : 12,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                          selectedIconTheme: IconThemeData(
                            size: isCompact ? 20 : 24,
                            color: AppColors.accent,
                          ),
                          unselectedIconTheme: IconThemeData(
                            size: isCompact ? 20 : 24,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                          leading: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: isCompact ? 6 : 14,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(isCompact ? 6 : 9),
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.thermostat,
                                color: Colors.black87,
                                size: isCompact ? 18 : 22,
                              ),
                            ),
                          ),
                          destinations: [
                            NavigationRailDestination(
                              icon: const Icon(Icons.radar_outlined),
                              selectedIcon: const Icon(Icons.radar,
                                  color: AppColors.accent),
                              label: Text('nav_radar'.tr),
                            ),
                            NavigationRailDestination(
                              icon: const Icon(Icons.timeline_outlined),
                              selectedIcon: const Icon(Icons.timeline,
                                  color: AppColors.accent),
                              label: Text('nav_forecast'.tr),
                            ),
                            NavigationRailDestination(
                              icon: const Icon(Icons.psychology_outlined),
                              selectedIcon: const Icon(Icons.psychology,
                                  color: AppColors.accent),
                              label: Text('nav_ai_copilot'.tr),
                            ),
                            NavigationRailDestination(
                              icon:
                                  const Icon(Icons.health_and_safety_outlined),
                              selectedIcon: const Icon(Icons.health_and_safety,
                                  color: AppColors.accent),
                              label: Text('nav_toolkit'.tr),
                            ),
                            NavigationRailDestination(
                              icon: const Icon(Icons.tune_outlined),
                              selectedIcon: const Icon(Icons.tune,
                                  color: AppColors.accent),
                              label: Text('nav_settings'.tr),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: Column(
                  children: [
                    const AudioPlayerBar(),
                    Expanded(
                      child: IndexedStack(
                        index: index,
                        children: _screens,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
