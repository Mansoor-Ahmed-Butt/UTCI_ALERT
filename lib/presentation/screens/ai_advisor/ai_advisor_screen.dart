import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../controllers/ai_advisor_controller.dart';
import '../../controllers/dashboard_controller.dart';
import '../../../services/tts_service.dart';

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
              child: const Icon(Icons.psychology,
                  color: AppColors.accent, size: 22),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI Heat Advisor',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Obx(
                  () => Text(
                    '${dashboard.activeRole.value.label} · ${dashboard.selectedCity.value.name}',
                    style: TextStyle(
                      fontSize: 12,
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
            constraints:
                BoxConstraints(maxWidth: Responsive.contentWidth(context)),
            child: Column(
              children: [
                // Context bar: Live thermal condition
                _buildThermalContextBar(context,
                    dashboard: dashboard, isDark: isDark),

                // Quick Prompt Chips
                _buildPromptChips(context, isDark: isDark),

                // Chat Messages List
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      controller: controller.scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      itemCount: controller.messages.length +
                          (controller.isThinking.value ? 1 : 0),
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

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: color.withValues(alpha: isDark ? 0.14 : 0.08),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              'Live Ground Status: ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            Text(
              '${status?.categoryLabel ?? 'Strong Heat Stress'} (${val.toStringAsFixed(1)}°C UTCI)',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const Spacer(),
            const Icon(Icons.bolt, color: AppColors.accent, size: 16),
            const Text(
              'On-Device AI',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPromptChips(BuildContext context, {required bool isDark}) {
    return Container(
      height: 44,
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
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            backgroundColor:
                isDark ? const Color(0xFF1E232E) : const Color(0xFFF0F2F6),
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
          margin: const EdgeInsets.only(bottom: 12, left: 48),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
              fontSize: 14,
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
        margin: const EdgeInsets.only(bottom: 14, right: 32),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF191D26) : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
          ),
          border: Border.all(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
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
                    Icon(Icons.auto_awesome, size: 15, color: AppColors.accent),
                    SizedBox(width: 6),
                    Text(
                      'UTCI Thermal Copilot',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  final isCurrentlySpeaking = tts.isSpeaking.value &&
                      tts.currentText.value
                          .contains(message.text.substring(0, 20));

                  return InkWell(
                    onTap: () => controller.speakMessage(message.text),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isCurrentlySpeaking
                            ? AppColors.accent
                            : AppColors.accent.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isCurrentlySpeaking
                                ? Icons.volume_up
                                : Icons.volume_up_outlined,
                            size: 14,
                            color: isCurrentlySpeaking
                                ? Colors.black87
                                : AppColors.accent,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isCurrentlySpeaking ? 'Stop' : 'Listen',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isCurrentlySpeaking
                                  ? Colors.black87
                                  : AppColors.accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              message.text,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.5,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.9)
                    : Colors.black87,
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF191D26) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: AppColors.accent),
            ),
            SizedBox(width: 10),
            Text(
              'Synthesizing thermal safety guidance...',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
        color: isDark ? AppColors.darkMode : Colors.white,
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
                hintText:
                    'Ask thermal advisor (e.g. hydration, symptoms, tin roof)...',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
                filled: true,
                fillColor:
                    isDark ? const Color(0xFF1E232E) : const Color(0xFFF2F4F7),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: controller.sendQuery,
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            style: IconButton.styleFrom(backgroundColor: AppColors.accent),
            icon: const Icon(Icons.arrow_upward, color: Colors.black87),
            onPressed: () =>
                controller.sendQuery(controller.textController.text),
          ),
        ],
      ),
    );
  }
}
