import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../services/tts_service.dart';
import '../../controllers/ai_advisor_controller.dart';
import '../../controllers/dashboard_controller.dart';

class AiAdvisorScreen extends GetView<AiAdvisorController> {
  const AiAdvisorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dashboard = Get.find<DashboardController>();
    final tts = Get.find<TtsService>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.psychology, color: AppColors.accent, size: 22),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI Thermal Safety Advisor',
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
                ),
                Obx(
                  () => Text(
                    '${dashboard.activeRole.value.label} · ${dashboard.selectedCity.value.name}',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Responsive.contentWidth(context)),
            child: Column(
              children: [
                // Context bar: Live thermal condition & Active Language
                _buildThermalContextBar(context, dashboard: dashboard, isDark: isDark),

                // Quick Prompt Chips
                _buildPromptChips(context, isDark: isDark),

                // Chat Messages List
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      controller: controller.scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      itemCount: controller.messages.length + (controller.isThinking.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == controller.messages.length) {
                          return _buildThinkingBubble(context, isDark: isDark);
                        }
                        final msg = controller.messages[index];
                        return _buildChatBubble(
                          context,
                          message: msg,
                          isDark: isDark,
                          tts: tts,
                        );
                      },
                    );
                  }),
                ),

                // Input Bar
                _buildInputBar(context, isDark: isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThermalContextBar(
    BuildContext context, {
    required DashboardController dashboard,
    required bool isDark,
  }) {
    return Obx(() {
      final status = dashboard.status.value;
      final val = status?.value ?? 34.0;
      final cat = status?.category ?? 'strong';
      final color = AppColors.statusColor(cat);
      final lang = dashboard.nativeLanguage.value;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        color: color.withValues(alpha: isDark ? 0.14 : 0.08),
        child: Row(
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 7),
            Text(
              '${status?.categoryLabel ?? 'Strong Heat Stress'} (${val.toStringAsFixed(1)}°C)',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E2430) : const Color(0xFFE2E6EE),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(lang.flag, style: const TextStyle(fontSize: 11)),
                  const SizedBox(width: 4),
                  Text(
                    lang.nativeName,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPromptChips(BuildContext context, {required bool isDark}) {
    return Container(
      height: 42,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.quickPromptChips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final prompt = controller.quickPromptChips[index];
          return ActionChip(
            label: Text(
              prompt,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            backgroundColor: isDark ? const Color(0xFF1B202A) : const Color(0xFFF0F2F6),
            side: BorderSide(
              color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
            ),
            onPressed: () => controller.sendQuery(prompt),
          );
        },
      ),
    );
  }

  Widget _buildChatBubble(
    BuildContext context, {
    required AiChatMessage message,
    required bool isDark,
    required TtsService tts,
  }) {
    if (message.isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10, left: 48),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: const BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: Text(
            message.text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    // AI message
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, right: 30),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF171B23) : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          border: Border.all(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.auto_awesome, size: 14, color: AppColors.accent),
                    SizedBox(width: 5),
                    Text(
                      'AI Heat Advisor',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  final isCurrentlySpeaking =
                      tts.isSpeaking.value && tts.currentText.value.contains(message.text.substring(0, 15));

                  return InkWell(
                    onTap: () => controller.speakMessage(message.text),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isCurrentlySpeaking
                            ? AppColors.accent
                            : AppColors.accent.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isCurrentlySpeaking ? Icons.volume_up : Icons.volume_up_outlined,
                            size: 13,
                            color: isCurrentlySpeaking ? Colors.black87 : AppColors.accent,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isCurrentlySpeaking ? 'Stop' : 'Listen',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                              color: isCurrentlySpeaking ? Colors.black87 : AppColors.accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              message.text,
              style: TextStyle(
                fontSize: 13,
                height: 1.45,
                color: isDark ? Colors.white.withValues(alpha: 0.92) : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThinkingBubble(BuildContext context, {required bool isDark}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF171B23) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 13,
              height: 13,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.accent),
            ),
            SizedBox(width: 9),
            Text(
              'Consulting AI Biometeorological Model...',
              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar(BuildContext context, {required bool isDark}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF12161E) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.textController,
              decoration: InputDecoration(
                hintText: 'Ask thermal safety advice (e.g. hydration, work hours)...',
                hintStyle: TextStyle(
                  fontSize: 12.5,
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
                filled: true,
                fillColor: isDark ? const Color(0xFF1B202A) : const Color(0xFFF1F3F6),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: controller.sendQuery,
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            style: IconButton.styleFrom(
              backgroundColor: AppColors.accent,
              padding: const EdgeInsets.all(10),
            ),
            icon: const Icon(Icons.arrow_upward, color: Colors.black87, size: 20),
            onPressed: () => controller.sendQuery(controller.textController.text),
          ),
        ],
      ),
    );
  }
}
