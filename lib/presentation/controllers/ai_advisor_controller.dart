import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/services/ai_heat_advisor_service.dart';
import '../../services/native_language_service.dart';
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
  final NativeLanguageService _langService;

  AiAdvisorController({
    required AiHeatAdvisorService aiAdvisor,
    required TtsService tts,
    NativeLanguageService? langService,
  })  : _aiAdvisor = aiAdvisor,
        _tts = tts,
        _langService = langService ?? Get.find<NativeLanguageService>();

  final RxList<AiChatMessage> messages = <AiChatMessage>[].obs;
  final RxBool isThinking = false.obs;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  DashboardController get _dashboard => Get.find<DashboardController>();
  NativeLanguage get activeLanguage => _langService.activeLanguage.value;

  final List<String> quickPromptChips = const [
    '💧 Hourly hydration plan',
    '⏱️ Work/rest ratio',
    '⚠️ Exhaustion vs Stroke',
    '🛵 Rider helmet & asphalt',
    '🏠 Cool roof without AC',
    '🌾 Safe harvesting shift',
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
    final lang = _langService.activeLanguage.value;

    String welcomeText;
    if (lang.code == 'ar') {
      welcomeText =
          'أهلاً بك! أنا **مستشارك للسلامة الحرارية الذكي** لمهام $role في $city.\n\nالمؤشر الميداني: **$category ($utci°C UTCI)**.\n\nاسألني عن خطة شرب الماء، فترات الراحة، الإسعافات الأولية، أو تبريد المنازل. اضغط على أيقونة الصوت للاستماع بلغتك الأم!';
    } else if (lang.code == 'ur') {
      welcomeText =
          'خوش آمدید! میں $city میں $role کے لیے آپ کا **تھرمل سیفٹی اے آئی ایڈوائزر** ہوں۔\n\nموجودہ حرارت: **$category ($utci°C UTCI)**۔\n\nپانی کی مقدار، کام کے وقفوں، یا ہیٹ اسٹروک سے بچاؤ کے بارے میں کچھ بھی پوچھیں۔ سنہری آواز کے لیے اسپیکر بٹن دبائیں!';
    } else if (lang.code == 'sw') {
      welcomeText =
          'Habari! Mimi ni **Mshauri wako wa Usalama wa Joto (AI)** kwa ajili ya $role huko $city.\n\nHali ya Sasa: **$category ($utci°C UTCI)**.\n\nUliza kuhusu unywaji maji, muda wa kupumzika, au huduma ya kwanza. Bonyeza spika kusikiliza kwa sauti ya asili!';
    } else if (lang.code == 'fr') {
      welcomeText =
          'Bonjour! Je suis votre **Conseiller Sécurité Thermique IA** pour les réalités de $role à $city.\n\nIndice Actuel: **$category ($utci°C UTCI)**.\n\nPosez vos questions sur l\'hydratation, les pauses et les premiers secours. Touchez le haut-parleur pour écouter vocalement!';
    } else if (lang.code == 'es') {
      welcomeText =
          '¡Hola! Soy tu **Asesor de Seguridad Térmica IA** para $role en $city.\n\nCondición Actual: **$category ($utci°C UTCI)**.\n\nPregúntame sobre hidratación, rotación de descansos o primeros auxilios. ¡Toca el altavoz para escuchar en tu idioma!';
    } else {
      welcomeText =
          'Hello! I am your **UTCI Thermal Safety Copilot**, specialized for $role in $city.\n\nCurrent Thermal Index: **$category ($utci°C UTCI)**.\n\nAsk me about hydration goals, work-rest cycles, or heat illness triage. Tap the speaker to listen hands-free in your native voice!';
    }

    messages.add(
      AiChatMessage(
        id: 'msg_0',
        text: welcomeText,
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
        cityName: _dashboard.selectedCity.value.name,
        countryName: _dashboard.selectedCity.value.country,
        nativeLanguage: _langService.activeLanguage.value,
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
          text: 'Unable to process query right now. Please check network connectivity or try again.',
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

    await _tts.speak(
      cleanForTts,
      languageCode: _langService.activeLanguage.value.ttsLocale,
    );
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
