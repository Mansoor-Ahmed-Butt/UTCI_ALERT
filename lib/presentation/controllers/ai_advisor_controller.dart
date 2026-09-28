import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/services/ai_heat_advisor_service.dart';
import '../../services/tts_service.dart';
import 'dashboard_controller.dart';

class AiChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;

  const AiChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class AiAdvisorController extends GetxController {
  final AiHeatAdvisorService _aiAdvisor;
  final TtsService _tts;

  AiAdvisorController({
    required AiHeatAdvisorService aiAdvisor,
    required TtsService tts,
  })  : _aiAdvisor = aiAdvisor,
        _tts = tts;

  final RxList<AiChatMessage> messages = <AiChatMessage>[].obs;
  final RxBool isThinking = false.obs;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  DashboardController get _dashboard => Get.find<DashboardController>();

  final List<String> quickPromptChips = const [
    '💧 Hourly hydration plan',
    '⚠️ Heat Exhaustion vs Stroke',
    '🛵 Rider helmet & asphalt heat',
    '🏠 Cool a tin roof without AC',
    '🌾 Safe harvesting schedule',
    '🚨 First aid: worker collapse',
  ];

  @override
  void onInit() {
    super.onInit();
    _initWelcomeMessage();
  }

  void _initWelcomeMessage() {
    final role = _dashboard.activeRole.value.label;
    final city = _dashboard.selectedCity.value.name;
    final utci = _dashboard.status.value?.value.toStringAsFixed(1) ?? '36.5';
    final category = _dashboard.status.value?.categoryLabel ?? 'Strong Heat Stress';

    messages.add(
      AiChatMessage(
        id: 'msg_0',
        text:
            'Hello! I am your **UTCI Thermal Safety Advisor**, co-designed for $role realities in $city.\n\nCurrent Thermal Index: **$category ($utci°C UTCI)**.\n\nAsk me anything regarding hydration, work-rest ratios, heat illness triage, or informal home cooling. Tap the speaker on any response to listen hands-free!',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  Future<void> sendQuery(String query) async {
    final clean = query.trim();
    if (clean.isEmpty || isThinking.value) return;

    textController.clear();

    final userMsg = AiChatMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      text: clean,
      isUser: true,
      timestamp: DateTime.now(),
    );
    messages.add(userMsg);
    _scrollToBottom();

    isThinking.value = true;
    try {
      final reply = await _aiAdvisor.answerQuery(
        query: clean,
        currentStatus: _dashboard.status.value,
        role: _dashboard.activeRole.value,
      );

      final aiMsg = AiChatMessage(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch + 1}',
        text: reply,
        isUser: false,
        timestamp: DateTime.now(),
      );
      messages.add(aiMsg);
      _scrollToBottom();
    } catch (_) {
      messages.add(
        AiChatMessage(
          id: 'msg_${DateTime.now().millisecondsSinceEpoch + 1}',
          text: 'Unable to process query right now. Please check connectivity or try again.',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    } finally {
      isThinking.value = false;
      _scrollToBottom();
    }
  }

  Future<void> speakMessage(String text) async {
    // Strip markdown formatting for cleaner audio speech
    final cleanForTts = text
        .replaceAll('*', '')
        .replaceAll('#', '')
        .replaceAll('•', '')
        .replaceAll('➡️', 'Action:')
        .replaceAll('⚠️', 'Warning:')
        .replaceAll('💧', 'Hydration:')
        .replaceAll('🚨', 'Emergency:');

    await _tts.speak(cleanForTts);
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
