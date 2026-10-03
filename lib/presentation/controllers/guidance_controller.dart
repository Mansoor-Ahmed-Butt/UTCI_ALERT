import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/user_role.dart';
import '../../services/native_language_service.dart';
import '../../services/tts_service.dart';
import 'dashboard_controller.dart';

class ChecklistItem {
  final String id;
  final String titleKey;
  final String descriptionKey;
  final IconData icon;
  final RxBool isChecked;

  ChecklistItem({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.icon,
    bool initialChecked = false,
  }) : isChecked = initialChecked.obs;

  /// Dynamic getters — re-evaluated every rebuild so locale changes propagate.
  String get title => titleKey.tr;
  String get description => descriptionKey.tr;
}

class GuidanceController extends GetxController {
  final TtsService _tts;

  GuidanceController({required TtsService tts}) : _tts = tts;

  DashboardController get _dashboard => Get.find<DashboardController>();
  NativeLanguageService get _langService => Get.find<NativeLanguageService>();

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
    // Reload when language changes so titles/descriptions re-bind correctly.
    ever(_langService.activeLanguage, (_) => _loadChecklistForRole(_dashboard.activeRole.value));
  }

  void _loadChecklistForRole(UserRole role) {
    switch (role) {
      case UserRole.outdoorWorker:
        currentChecklist.assignAll([
          ChecklistItem(
            id: 'c1',
            titleKey: 'check_ow_c1_title',
            descriptionKey: 'check_ow_c1_desc',
            icon: Icons.water_drop_outlined,
          ),
          ChecklistItem(
            id: 'c2',
            titleKey: 'check_ow_c2_title',
            descriptionKey: 'check_ow_c2_desc',
            icon: Icons.shield_outlined,
          ),
          ChecklistItem(
            id: 'c3',
            titleKey: 'check_ow_c3_title',
            descriptionKey: 'check_ow_c3_desc',
            icon: Icons.beach_access_outlined,
          ),
          ChecklistItem(
            id: 'c4',
            titleKey: 'check_ow_c4_title',
            descriptionKey: 'check_ow_c4_desc',
            icon: Icons.group_outlined,
          ),
        ]);
        break;

      case UserRole.deliveryRider:
        currentChecklist.assignAll([
          ChecklistItem(
            id: 'r1',
            titleKey: 'check_dr_r1_title',
            descriptionKey: 'check_dr_r1_desc',
            icon: Icons.sports_motorsports_outlined,
          ),
          ChecklistItem(
            id: 'r2',
            titleKey: 'check_dr_r2_title',
            descriptionKey: 'check_dr_r2_desc',
            icon: Icons.air,
          ),
          ChecklistItem(
            id: 'r3',
            titleKey: 'check_dr_r3_title',
            descriptionKey: 'check_dr_r3_desc',
            icon: Icons.local_drink_outlined,
          ),
          ChecklistItem(
            id: 'r4',
            titleKey: 'check_dr_r4_title',
            descriptionKey: 'check_dr_r4_desc',
            icon: Icons.local_parking_outlined,
          ),
        ]);
        break;

      case UserRole.farmer:
        currentChecklist.assignAll([
          ChecklistItem(
            id: 'f1',
            titleKey: 'check_fm_f1_title',
            descriptionKey: 'check_fm_f1_desc',
            icon: Icons.wb_twilight_outlined,
          ),
          ChecklistItem(
            id: 'f2',
            titleKey: 'check_fm_f2_title',
            descriptionKey: 'check_fm_f2_desc',
            icon: Icons.pets_outlined,
          ),
          ChecklistItem(
            id: 'f3',
            titleKey: 'check_fm_f3_title',
            descriptionKey: 'check_fm_f3_desc',
            icon: Icons.roofing_outlined,
          ),
          ChecklistItem(
            id: 'f4',
            titleKey: 'check_fm_f4_title',
            descriptionKey: 'check_fm_f4_desc',
            icon: Icons.grain_outlined,
          ),
        ]);
        break;

      case UserRole.informalResident:
        currentChecklist.assignAll([
          ChecklistItem(
            id: 'i1',
            titleKey: 'check_ir_i1_title',
            descriptionKey: 'check_ir_i1_desc',
            icon: Icons.window_outlined,
          ),
          ChecklistItem(
            id: 'i2',
            titleKey: 'check_ir_i2_title',
            descriptionKey: 'check_ir_i2_desc',
            icon: Icons.wind_power_outlined,
          ),
          ChecklistItem(
            id: 'i3',
            titleKey: 'check_ir_i3_title',
            descriptionKey: 'check_ir_i3_desc',
            icon: Icons.coffee_outlined,
          ),
          ChecklistItem(
            id: 'i4',
            titleKey: 'check_ir_i4_title',
            descriptionKey: 'check_ir_i4_desc',
            icon: Icons.family_restroom_outlined,
          ),
        ]);
        break;

      case UserRole.vulnerable:
        currentChecklist.assignAll([
          ChecklistItem(
            id: 'v1',
            titleKey: 'check_vn_v1_title',
            descriptionKey: 'check_vn_v1_desc',
            icon: Icons.home_outlined,
          ),
          ChecklistItem(
            id: 'v2',
            titleKey: 'check_vn_v2_title',
            descriptionKey: 'check_vn_v2_desc',
            icon: Icons.bathtub_outlined,
          ),
          ChecklistItem(
            id: 'v3',
            titleKey: 'check_vn_v3_title',
            descriptionKey: 'check_vn_v3_desc',
            icon: Icons.alarm_on_outlined,
          ),
          ChecklistItem(
            id: 'v4',
            titleKey: 'check_vn_v4_title',
            descriptionKey: 'check_vn_v4_desc',
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
    final role = _dashboard.activeRole.value.localizedLabel;
    final items = currentChecklist.map((c) => '${c.title}: ${c.description}').join('. ');
    await _tts.speak('$role: $items');
  }

  Future<void> readFirstAidAloud() async {
    await _tts.speak('emergency_first_aid_speech'.tr);
  }
}
