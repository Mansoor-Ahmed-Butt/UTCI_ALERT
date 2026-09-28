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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.radar_outlined),
              selectedIcon: Icon(Icons.radar, color: AppColors.accent),
              label: 'Radar',
            ),
            NavigationDestination(
              icon: Icon(Icons.timeline_outlined),
              selectedIcon: Icon(Icons.timeline, color: AppColors.accent),
              label: 'Forecast',
            ),
            NavigationDestination(
              icon: Icon(Icons.psychology_outlined),
              selectedIcon: Icon(Icons.psychology, color: AppColors.accent),
              label: 'AI Advisor',
            ),
            NavigationDestination(
              icon: Icon(Icons.health_and_safety_outlined),
              selectedIcon:
                  Icon(Icons.health_and_safety, color: AppColors.accent),
              label: 'Toolkit',
            ),
            NavigationDestination(
              icon: Icon(Icons.tune_outlined),
              selectedIcon: Icon(Icons.tune, color: AppColors.accent),
              label: 'Settings',
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTabletScaffold(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      final index = controller.currentIndex.value;

      return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              NavigationRail(
                selectedIndex: index,
                onDestinationSelected: controller.changeTab,
                labelType: NavigationRailLabelType.all,
                backgroundColor: isDark ? AppColors.darkMode : Colors.white,
                indicatorColor:
                    isDark ? AppColors.accentDarkMuted : AppColors.accentMuted,
                leading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.thermostat,
                        color: Colors.black87, size: 24),
                  ),
                ),
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.radar_outlined),
                    selectedIcon: Icon(Icons.radar, color: AppColors.accent),
                    label: Text('Radar'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.timeline_outlined),
                    selectedIcon: Icon(Icons.timeline, color: AppColors.accent),
                    label: Text('Forecast'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.psychology_outlined),
                    selectedIcon:
                        Icon(Icons.psychology, color: AppColors.accent),
                    label: Text('AI Copilot'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.health_and_safety_outlined),
                    selectedIcon:
                        Icon(Icons.health_and_safety, color: AppColors.accent),
                    label: Text('Toolkit'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.tune_outlined),
                    selectedIcon: Icon(Icons.tune, color: AppColors.accent),
                    label: Text('Settings'),
                  ),
                ],
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
