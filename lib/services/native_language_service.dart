import 'package:get/get.dart';
import '../data/models/user_role.dart';

class NativeLanguage {
  final String code;
  final String ttsLocale;
  final String name;
  final String nativeName;
  final String flag;
  final bool isRtl;

  const NativeLanguage({
    required this.code,
    required this.ttsLocale,
    required this.name,
    required this.nativeName,
    required this.flag,
    this.isRtl = false,
  });

  String get displayName => '$flag $nativeName ($name)';
}

class NativeLanguageService extends GetxService {
  static const List<NativeLanguage> supportedLanguages = [
    NativeLanguage(
      code: 'en',
      ttsLocale: 'en-US',
      name: 'English',
      nativeName: 'English',
      flag: '🌐',
      isRtl: false,
    ),
    NativeLanguage(
      code: 'ar',
      ttsLocale: 'ar-SA',
      name: 'Arabic',
      nativeName: 'العربية',
      flag: '🇪🇬',
      isRtl: true,
    ),
    NativeLanguage(
      code: 'ur',
      ttsLocale: 'ur-PK',
      name: 'Urdu',
      nativeName: 'اردو',
      flag: '🇵🇰',
      isRtl: true,
    ),
    NativeLanguage(
      code: 'sw',
      ttsLocale: 'sw-KE',
      name: 'Swahili',
      nativeName: 'Kiswahili',
      flag: '🇰🇪',
      isRtl: false,
    ),
    NativeLanguage(
      code: 'fr',
      ttsLocale: 'fr-FR',
      name: 'French',
      nativeName: 'Français',
      flag: '🇫🇷',
      isRtl: false,
    ),
    NativeLanguage(
      code: 'es',
      ttsLocale: 'es-ES',
      name: 'Spanish',
      nativeName: 'Español',
      flag: '🇪🇸',
      isRtl: false,
    ),
    NativeLanguage(
      code: 'hi',
      ttsLocale: 'hi-IN',
      name: 'Hindi',
      nativeName: 'हिन्दी',
      flag: '🇮🇳',
      isRtl: false,
    ),
  ];

  final Rx<NativeLanguage> activeLanguage = Rx<NativeLanguage>(supportedLanguages.first);
  final RxBool isAutoDetect = true.obs;

  void setLanguage(NativeLanguage language, {bool manual = true}) {
    activeLanguage.value = language;
    if (manual) {
      isAutoDetect.value = false;
    }
  }

  NativeLanguage detectLanguageFromCountry(String countryName, String countryCode) {
    final code = countryCode.trim().toUpperCase();
    final name = countryName.toLowerCase();

    // Arabic
    const arabicCodes = {'EG', 'SA', 'AE', 'DZ', 'TN', 'MA', 'LY', 'SD', 'IQ', 'JO', 'LB', 'OM', 'KW', 'QA', 'BH', 'YE'};
    if (arabicCodes.contains(code) ||
        name.contains('egypt') ||
        name.contains('saudi') ||
        name.contains('emirates') ||
        name.contains('algeria') ||
        name.contains('tunisia') ||
        name.contains('morocco') ||
        name.contains('libya') ||
        name.contains('sudan') ||
        name.contains('iraq')) {
      return supportedLanguages.firstWhere((l) => l.code == 'ar');
    }

    // Urdu
    if (code == 'PK' || name.contains('pakistan')) {
      return supportedLanguages.firstWhere((l) => l.code == 'ur');
    }

    // Hindi
    if (code == 'IN' || name.contains('india')) {
      return supportedLanguages.firstWhere((l) => l.code == 'hi');
    }

    // Swahili
    const swahiliCodes = {'KE', 'TZ', 'UG', 'RW'};
    if (swahiliCodes.contains(code) ||
        name.contains('kenya') ||
        name.contains('tanzania') ||
        name.contains('uganda')) {
      return supportedLanguages.firstWhere((l) => l.code == 'sw');
    }

    // French
    const frenchCodes = {'FR', 'SN', 'CD', 'CI', 'ML', 'GN', 'CM', 'BF', 'NE', 'TG', 'BJ'};
    if (frenchCodes.contains(code) ||
        name.contains('france') ||
        name.contains('senegal') ||
        name.contains('congo') ||
        name.contains('ivory coast') ||
        name.contains('mali') ||
        name.contains('cameroon')) {
      return supportedLanguages.firstWhere((l) => l.code == 'fr');
    }

    // Spanish
    const spanishCodes = {'ES', 'MX', 'CO', 'AR', 'PE', 'VE', 'CL', 'EC', 'GT', 'CU', 'BO', 'DO', 'HN', 'PY', 'SV', 'NI', 'CR', 'PA', 'UY'};
    if (spanishCodes.contains(code) ||
        name.contains('spain') ||
        name.contains('mexico') ||
        name.contains('colombia') ||
        name.contains('argentina')) {
      return supportedLanguages.firstWhere((l) => l.code == 'es');
    }

    return supportedLanguages.firstWhere((l) => l.code == 'en');
  }

  void autoUpdateForLocation(String countryName, String countryCode) {
    if (isAutoDetect.value) {
      final detected = detectLanguageFromCountry(countryName, countryCode);
      activeLanguage.value = detected;
    }
  }

  /// Returns clean, crisp, high-impact native plain-language alert text.
  /// Strictly avoids walls of text.
  String getNativeWarning({
    required String category,
    required UserRole role,
    required double utci,
    NativeLanguage? lang,
  }) {
    final language = lang ?? activeLanguage.value;
    final cat = category.toLowerCase();
    final roleName = role.label;

    switch (language.code) {
      case 'ar':
        if (cat == 'extreme') {
          return '⚠️ خطر حراري شديد (${utci.toStringAsFixed(0)}°C)! لـ $roleName: أوقف العمل المباشر فوراً، اشرب لتر ماء كل ساعة واسترح في أعمق ظل.';
        } else if (cat == 'very_strong') {
          return '⚠️ إجهاد حراري حاد (${utci.toStringAsFixed(0)}°C): نظام 30 دقيقة عمل و30 دقيقة راحة. رطب رقبتك واشرب 250 مل ماء كل 20 دقيقة.';
        } else if (cat == 'strong') {
          return '☀️ حرارة شديدة (${utci.toStringAsFixed(0)}°C): استرح 15 دقيقة كل ساعة واشرب الماء باستمرار قبل الشعور بالعطش.';
        } else {
          return '✅ ظروف مريحة (${utci.toStringAsFixed(0)}°C): درجات حرارة آمنة للأعمال الخارجية والأنشطة المعتادة.';
        }

      case 'ur':
        if (cat == 'extreme') {
          return '⚠️ جان لیوا گرمی کی وارننگ (${utci.toStringAsFixed(0)}°C)! $roleName: کھلی دھوپ میں سخت مشقت فوری روک دیں۔ ہر 15 منٹ بعد پانی پییں اور گہرے سائے میں بیٹھیں۔';
        } else if (cat == 'very_strong') {
          return '⚠️ شدید گرمی کا دباؤ (${utci.toStringAsFixed(0)}°C): 30 منٹ کام اور 30 منٹ سائے میں آرام کریں۔ گردن پر گیلا کپڑا رکھیں اور مسلسل پانی پیئیں۔';
        } else if (cat == 'strong') {
          return '☀️ تیز گرمی کی وارننگ (${utci.toStringAsFixed(0)}°C): ہر گھنٹے 15 منٹ آرام کریں۔ پیاس لگنے کا انتظار نہ کریں، پانی پیتے رہیں۔';
        } else {
          return '✅ خوشگوار اور محفوظ موسم (${utci.toStringAsFixed(0)}°C): معمول کے بیرونی کاموں کے لیے درجہ حرارت بالکل محفوظ ہے۔';
        }

      case 'sw':
        if (cat == 'extreme') {
          return '⚠️ Hatari Kubwa ya Joto (${utci.toStringAsFixed(0)}°C)! Kwa $roleName: Sitisha kazi nzito juani mara moja. Kunywa lita moja ya maji kila saa na pumzika kivulini.';
        } else if (cat == 'very_strong') {
          return '⚠️ Msongo Mkali wa Joto (${utci.toStringAsFixed(0)}°C): Fanya kazi dakika 30 kisha pumzika dakika 30. Weka kitambaa chenye unyevu shingoni.';
        } else if (cat == 'strong') {
          return '☀️ Tahadhari ya Joto (${utci.toStringAsFixed(0)}°C): Pumzika dakika 15 kila saa na unywe maji safi mara kwa mara.';
        } else {
          return '✅ Hali ya Hewa Salama (${utci.toStringAsFixed(0)}°C): Mazingira mazuri kwa kazi za nje na shughuli za kawaida.';
        }

      case 'fr':
        if (cat == 'extreme') {
          return '⚠️ Alerte Chaleur Critique (${utci.toStringAsFixed(0)}°C)! Pour $roleName: Arrêtez tout effort lourd au soleil. Buvez 1L d\'eau/heure et restez à l\'ombre.';
        } else if (cat == 'very_strong') {
          return '⚠️ Stress Thermique Sévère (${utci.toStringAsFixed(0)}°C): Protocole 30 min travail / 30 min repos. Mouillez votre nuque et hydratez-vous.';
        } else if (cat == 'strong') {
          return '☀️ Forte Chaleur (${utci.toStringAsFixed(0)}°C): Prévoyez 15 min de pause à l\'ombre par heure. Buvez régulièrement sans attendre la soif.';
        } else {
          return '✅ Conditions Confortables (${utci.toStringAsFixed(0)}°C): Températures optimales pour les activités et travaux extérieurs.';
        }

      case 'es':
        if (cat == 'extreme') {
          return '⚠️ Alerta Térmica Crítica (${utci.toStringAsFixed(0)}°C)! Para $roleName: Detenga labores pesadas al sol directo. Beba 1L de agua por hora y busque sombra densa.';
        } else if (cat == 'very_strong') {
          return '⚠️ Estrés Térmico Severo (${utci.toStringAsFixed(0)}°C): Ciclo de 30 min trabajo / 30 min descanso. Enfríe cuello y frente con paños húmedos.';
        } else if (cat == 'strong') {
          return '☀️ Precaución por Calor (${utci.toStringAsFixed(0)}°C): Tómese 15 min de reposo bajo sombra cada hora e hidrátese continuamente.';
        } else {
          return '✅ Confort Térmico (${utci.toStringAsFixed(0)}°C): Condiciones climáticas seguras para operaciones normales.';
        }

      case 'hi':
        if (cat == 'extreme') {
          return '⚠️ अत्यधिक खतरनाक गर्मी (${utci.toStringAsFixed(0)}°C)! $roleName: तेज धूप में भारी शारीरिक काम तुरंत रोकें। हर घंटे 1 लीटर पानी पिएं और गहरी छाया में रहें।';
        } else if (cat == 'very_strong') {
          return '⚠️ गंभीर हीट स्ट्रेस (${utci.toStringAsFixed(0)}°C): 30 मिनट काम और 30 मिनट आराम का नियम अपनाएं। गर्दन पर गीला कपड़ा रखें।';
        } else if (cat == 'strong') {
          return '☀️ तेज गर्मी की चेतावनी (${utci.toStringAsFixed(0)}°C): हर घंटे 15 मिनट छाया में आराम करें और प्यास लगने से पहले पानी पिएं।';
        } else {
          return '✅ अनुकूल और सुरक्षित मौसम (${utci.toStringAsFixed(0)}°C): बाहरी गतिविधियों के लिए तापमान बिल्कुल सुरक्षित है।';
        }

      case 'en':
      default:
        if (cat == 'extreme') {
          return '⚠️ Critical Heat Hazard (${utci.toStringAsFixed(0)}°C)! For $roleName: Halt direct sun labor immediately. Drink 1L water/hr and rest in deep shade.';
        } else if (cat == 'very_strong') {
          return '⚠️ Severe Heat Stress (${utci.toStringAsFixed(0)}°C): Follow 30 min work / 30 min shaded rest cycle. Sponge neck with cool water and stay hydrated.';
        } else if (cat == 'strong') {
          return '☀️ Strong Heat Stress (${utci.toStringAsFixed(0)}°C): Take 15-minute shaded breaks every hour and hydrate before feeling thirsty.';
        } else {
          return '✅ Optimal Thermal Comfort (${utci.toStringAsFixed(0)}°C): Safe ambient conditions for outdoor transit, logistics, and field shifts.';
        }
    }
  }
}
