import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Owns FCM end-to-end: getting the token, and reacting when a push
/// arrives or is tapped, in ALL THREE app states. Reads `category`
/// and `suggestion` — both fields the backend's notify.js sends in
/// its data payload (suggestion is the AI-generated safety tip).
///
/// TTS uses `flutter_tts` — on-device, free, fully offline. Deliberate
/// choice for this app's users (outdoor workers, low-connectivity
/// areas): a cloud TTS API sounds more natural but costs per character
/// and needs internet, which conflicts with the app working offline.
class NotificationService {
  final FlutterTts _tts = FlutterTts();

  /// Set by main.dart when the app was cold-launched by tapping a
  /// notification while fully terminated. AuthController reads this
  /// once (alongside its cached-user check) to fast-redirect to Home
  /// — checked there rather than via GetMaterialApp's initialRoute so
  /// that AuthBinding still runs first and registers every dependency
  /// HomeController needs.
  static bool hadTerminatedLaunchAlert = false;

  bool get _isFirebaseReady => Firebase.apps.isNotEmpty;

  Future<String?> getToken() async {
    if (!_isFirebaseReady) return null;
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (_) {
      return null;
    }
  }

  Future<void> requestPermission() async {
    if (!_isFirebaseReady) return;
    try {
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    } catch (_) {}
  }

  /// Call once at app start (after Hive/Firebase init, before runApp).
  /// Covers the app being fully killed and relaunched via a notification tap.
  Future<void> handleTerminatedLaunch({
    required void Function(String category, String? suggestion) onAlert,
  }) async {
    if (!_isFirebaseReady) return;
    try {
      final message = await FirebaseMessaging.instance.getInitialMessage();
      if (message == null) return; // opened normally, not via a notification tap
      _emit(message, onAlert);
    } catch (_) {}
  }

  /// Call once, after the app is running. Covers foreground + backgrounded.
  void listen({required void Function(String category, String? suggestion) onAlert}) {
    if (!_isFirebaseReady) return;
    try {
      FirebaseMessaging.onMessage.listen((message) => _emit(message, onAlert));
      FirebaseMessaging.onMessageOpenedApp.listen((message) => _emit(message, onAlert));
    } catch (_) {}
  }

  void _emit(RemoteMessage message, void Function(String, String?) onAlert) {
    final category = message.data['category'];
    final suggestion = message.data['suggestion'];
    if (category == null) return;
    onAlert(category, suggestion);
    _speak(message.notification?.body, suggestion);
  }

  Future<void> _speak(String? body, String? suggestion) async {
    final text = [body, suggestion].where((s) => s != null && s.isNotEmpty).join('. ');
    if (text.isEmpty) return;
    await _tts.speak(text); // reads the alert AND the AI safety tip together
  }
}

/// Top-level background handler — required by firebase_messaging for
/// data-only pushes received while the app is fully backgrounded.
/// Must be a top-level (or static) function, registered in main.dart
/// via FirebaseMessaging.onBackgroundMessage before runApp().
/// The @pragma keeps this reachable from the separate background
/// isolate Android spins up for it in release/profile builds — Flutter's
/// tree shaker can otherwise strip it since nothing else calls it directly.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Intentionally minimal: heavy work (TTS, navigation) only happens
  // once the user brings the app to foreground/taps the notification,
  // handled by NotificationService.listen / handleTerminatedLaunch.
}
