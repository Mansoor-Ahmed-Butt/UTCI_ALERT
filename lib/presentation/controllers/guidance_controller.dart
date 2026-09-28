import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/user_role.dart';
import '../../services/tts_service.dart';
import 'dashboard_controller.dart';

class ChecklistItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final RxBool isChecked;

  ChecklistItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    bool initialChecked = false,
  }) : isChecked = initialChecked.obs;
}

class GuidanceController extends GetxController {
  final TtsService _tts;

  GuidanceController({required TtsService tts}) : _tts = tts;

  DashboardController get _dashboard => Get.find<DashboardController>();

  // Hydration Tracker State
  final RxInt targetMilliliters = 3000.obs;
  final RxInt consumedMilliliters = 1250.obs;

  double get hydrationProgress =>
      (consumedMilliliters.value / targetMilliliters.value).clamp(0.0, 1.0);

  // Checklists mapped by role
  final RxList<ChecklistItem> currentChecklist = <ChecklistItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadChecklistForRole(_dashboard.activeRole.value);
    ever(_dashboard.activeRole, _loadChecklistForRole);
  }

  void _loadChecklistForRole(UserRole role) {
    switch (role) {
      case UserRole.outdoorWorker:
        currentChecklist.assignAll([
          ChecklistItem(
            id: 'c1',
            title: '2.5L Clean Water Jug Prepared',
            description: 'Have cool water accessible within 2 minutes of your work area.',
            icon: Icons.water_drop_outlined,
          ),
          ChecklistItem(
            id: 'c2',
            title: 'Wide-Brim Hat or Neck Shade',
            description: 'Drape a damp cloth under your hardhat or wear a wide brim.',
            icon: Icons.shield_outlined,
          ),
          ChecklistItem(
            id: 'c3',
            title: 'Shade Canopy Identified',
            description: 'Locate a covered area with air movement for your 15-min hourly rest.',
            icon: Icons.beach_access_outlined,
          ),
          ChecklistItem(
            id: 'c4',
            title: 'Buddy System Active',
            description: 'Agree with a coworker to monitor each other for slurred speech or dizziness.',
            icon: Icons.group_outlined,
          ),
        ]);
        break;

      case UserRole.deliveryRider:
        currentChecklist.assignAll([
          ChecklistItem(
            id: 'r1',
            title: 'Visor Clean & Vent Opened',
            description: 'Keep face visor cracked 1-notch to prevent 48°C helmet heat pocket.',
            icon: Icons.sports_motorsports_outlined,
          ),
          ChecklistItem(
            id: 'r2',
            title: 'Wet Neck Gaiter / Bandana',
            description: 'Dampen bandana before heading out for wind-chill convective cooling.',
            icon: Icons.air,
          ),
          ChecklistItem(
            id: 'r3',
            title: 'Insulated Water Flask',
            description: 'Carry cold water; avoid energy drinks that cause kidney stress.',
            icon: Icons.local_drink_outlined,
          ),
          ChecklistItem(
            id: 'r4',
            title: 'Shaded Parking at Hubs',
            description: 'Park under canopy; remove helmet the instant bike engine stops.',
            icon: Icons.local_parking_outlined,
          ),
        ]);
        break;

      case UserRole.farmer:
        currentChecklist.assignAll([
          ChecklistItem(
            id: 'f1',
            title: 'Split-Shift Labor Planning',
            description: 'Harvest from 05:30 to 09:30, then resume after 17:00.',
            icon: Icons.wb_twilight_outlined,
          ),
          ChecklistItem(
            id: 'f2',
            title: 'Livestock Water Troughs Full',
            description: 'Animals need double water volume during UTCI >36°C heat spikes.',
            icon: Icons.pets_outlined,
          ),
          ChecklistItem(
            id: 'f3',
            title: 'Field Tarp Shade Stations',
            description: 'Erect palm frond or mesh tarps every 200m across active plots.',
            icon: Icons.roofing_outlined,
          ),
          ChecklistItem(
            id: 'f4',
            title: 'Mineral & Salt Replenishment',
            description: 'Add a pinch of salt to drinking jugs to replenish lost sodium.',
            icon: Icons.grain_outlined,
          ),
        ]);
        break;

      case UserRole.informalResident:
        currentChecklist.assignAll([
          ChecklistItem(
            id: 'i1',
            title: 'Damp Jute/Burlap on Windows',
            description: 'Evaporative cooling lowers room temperature by 3°C to 5°C.',
            icon: Icons.window_outlined,
          ),
          ChecklistItem(
            id: 'i2',
            title: 'Night Cross-Draft Ventilation',
            description: 'Open opposing high vents at 20:00 to purge daytime heat.',
            icon: Icons.wind_power_outlined,
          ),
          ChecklistItem(
            id: 'i3',
            title: 'Clay Zeer Pot Hydration Station',
            description: 'Store drinking water in terracotta pots for natural cooling.',
            icon: Icons.coffee_outlined,
          ),
          ChecklistItem(
            id: 'i4',
            title: 'Elderly & Infant Shade Relocation',
            description: 'Move vulnerable family members to tree shade between 12:00-15:30.',
            icon: Icons.family_restroom_outlined,
          ),
        ]);
        break;

      case UserRole.vulnerable:
        currentChecklist.assignAll([
          ChecklistItem(
            id: 'v1',
            title: 'Ground Floor Relocation',
            description: 'Stay in the lowest room of the house where air is coolest.',
            icon: Icons.home_outlined,
          ),
          ChecklistItem(
            id: 'v2',
            title: 'Cool Water Foot Soak',
            description: 'Submerging feet in cool water rapidly lowers core body temperature.',
            icon: Icons.bathtub_outlined,
          ),
          ChecklistItem(
            id: 'v3',
            title: 'Hourly Water Glass Schedule',
            description: 'Sip 200ml every hour even without feeling thirsty.',
            icon: Icons.alarm_on_outlined,
          ),
          ChecklistItem(
            id: 'v4',
            title: 'Emergency Contact Speed Dial',
            description: 'Ensure community health worker or neighbor phone is readily accessible.',
            icon: Icons.phone_in_talk_outlined,
          ),
        ]);
        break;
    }
  }

  void logWater(int amountMl) {
    consumedMilliliters.value =
        (consumedMilliliters.value + amountMl).clamp(0, 8000);
  }

  void resetWater() {
    consumedMilliliters.value = 0;
  }

  Future<void> readChecklistAloud() async {
    final role = _dashboard.activeRole.value.label;
    final items = currentChecklist.map((c) => '${c.title}: ${c.description}').join('. ');
    await _tts.speak('Heat safety checklist for $role: $items');
  }

  Future<void> readFirstAidAloud() async {
    const text =
        'Heat Stroke Emergency Protocol. Move victim to deep shade immediately. Lay them flat and elevate feet 30 centimeters. Douse body with cold water or wet towels. Call local emergency health services immediately. Do not give fluids if unconscious.';
    await _tts.speak(text);
  }
}
