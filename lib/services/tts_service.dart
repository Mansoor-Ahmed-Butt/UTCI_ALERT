import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class TtsService extends GetxService {
  final FlutterTts _tts = FlutterTts();

  final RxBool isSpeaking = false.obs;
  final RxString currentText = ''.obs;
  final RxDouble speechRate = 0.5.obs;
  final RxDouble pitch = 1.0.obs;
  final RxBool isAvailable = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initTts();
  }

  Future<void> _initTts() async {
    try {
      await _tts.setLanguage('en-US');
      await _tts.setSpeechRate(speechRate.value);
      await _tts.setPitch(pitch.value);

      _tts.setStartHandler(() {
        isSpeaking.value = true;
      });

      _tts.setCompletionHandler(() {
        isSpeaking.value = false;
        currentText.value = '';
      });

      _tts.setCancelHandler(() {
        isSpeaking.value = false;
        currentText.value = '';
      });

      _tts.setErrorHandler((msg) {
        debugPrint('TTS Error: $msg');
        isSpeaking.value = false;
        currentText.value = '';
      });
    } catch (e) {
      debugPrint('TTS Initialization warning: $e');
      isAvailable.value = false;
    }
  }

  Future<void> speak(String text) async {
    final clean = text.trim();
    if (clean.isEmpty) return;

    try {
      if (isSpeaking.value && currentText.value == clean) {
        await stop();
        return;
      }

      await _tts.stop();
      currentText.value = clean;
      isSpeaking.value = true;
      await _tts.setSpeechRate(speechRate.value);
      await _tts.setPitch(pitch.value);
      await _tts.speak(clean);
    } catch (e) {
      debugPrint('TTS speak failed: $e');
      isSpeaking.value = false;
      currentText.value = '';
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (_) {}
    isSpeaking.value = false;
    currentText.value = '';
  }

  Future<void> setRate(double rate) async {
    speechRate.value = rate.clamp(0.2, 1.0);
    try {
      await _tts.setSpeechRate(speechRate.value);
    } catch (_) {}
  }

  Future<void> setPitch(double p) async {
    pitch.value = p.clamp(0.5, 2.0);
    try {
      await _tts.setPitch(pitch.value);
    } catch (_) {}
  }

  Future<void> testVoice() async {
    await speak(
      'UTCI Alert notification. Severe heat stress detected. Drink 250 milliliters of water immediately and seek shade.',
    );
  }

  @override
  void onClose() {
    stop();
    super.onClose();
  }
}
