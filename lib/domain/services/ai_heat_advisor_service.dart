import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/user_role.dart';
import '../../data/models/utci_status_model.dart';
import '../../data/models/weather_models.dart';
import '../../services/native_language_service.dart';

class DynamicAdviceResult {
  final String headline;
  final String workRestCycle;
  final String hydrationGoal;
  final String profileAction;
  final String coolingMethod;
  final String warningSign;

  const DynamicAdviceResult({
    required this.headline,
    required this.workRestCycle,
    required this.hydrationGoal,
    required this.profileAction,
    required this.coolingMethod,
    required this.warningSign,
  });

  String toSpeechString() {
    return '$headline. Work-rest cycle: $workRestCycle. Hydration: $hydrationGoal. Action: $profileAction.';
  }
}

class AiHeatAdvisorService {
  final Dio _dio;

  AiHeatAdvisorService([Dio? dio])
      : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 12),
                receiveTimeout: const Duration(seconds: 15),
              ),
            );

  DynamicAdviceResult generateDynamicAdvice({
    required UtciStatusModel status,
    required UserRole role,
    CurrentWeatherData? weather,
    NativeLanguage? language,
  }) {
    final cat = status.category.toLowerCase();
    final utci = status.value;
    final langCode = language?.code ?? 'en';

    if (langCode == 'ar') {
      return _buildArabicAdvice(cat, utci, role);
    } else if (langCode == 'ur') {
      return _buildUrduAdvice(cat, utci, role);
    } else if (langCode == 'sw') {
      return _buildSwahiliAdvice(cat, utci, role);
    } else if (langCode == 'fr') {
      return _buildFrenchAdvice(cat, utci, role);
    } else if (langCode == 'es') {
      return _buildSpanishAdvice(cat, utci, role);
    } else if (langCode == 'hi') {
      return _buildHindiAdvice(cat, utci, role);
    }

    switch (cat) {
      case 'extreme':
        return _buildExtremeAdvice(utci, role);
      case 'very_strong':
        return _buildVeryStrongAdvice(utci, role);
      case 'strong':
        return _buildStrongAdvice(utci, role);
      case 'moderate':
        return _buildModerateAdvice(utci, role);
      default:
        return _buildComfortAdvice(utci, role);
    }
  }

  DynamicAdviceResult _buildExtremeAdvice(double utci, UserRole role) {
    return const DynamicAdviceResult(
      headline: 'CRITICAL HAZARD: Stop Direct Sun Labor',
      workRestCycle: 'Max 15 min light activity / 45 min deep shade',
      hydrationGoal: '1.0 to 1.2 Liters per hour with electrolytes',
      profileAction: 'Shift to shaded staging areas. Buddy monitor continuously.',
      coolingMethod: 'Drape wet towel over back of neck and wrists.',
      warningSign: 'Confusion, absence of sweating with hot dry skin.',
    );
  }

  DynamicAdviceResult _buildVeryStrongAdvice(double utci, UserRole role) {
    return const DynamicAdviceResult(
      headline: 'SEVERE HEAT STRESS: Work-Rest Protocol Active',
      workRestCycle: '30 minutes work / 30 minutes shaded rest (NIOSH)',
      hydrationGoal: '800ml to 1.0 Liter cool water per hour',
      profileAction: 'Rotate high-exertion duties among crew members.',
      coolingMethod: 'Sponge neck and forearms with cool water regularly.',
      warningSign: 'Throbbing headache, sudden goosebumps or clammy skin.',
    );
  }

  DynamicAdviceResult _buildStrongAdvice(double utci, UserRole role) {
    return const DynamicAdviceResult(
      headline: 'STRONG HEAT STRESS: Safety Precautions Active',
      workRestCycle: '45 minutes work / 15 minutes shaded canopy break',
      hydrationGoal: '500ml to 750ml water per hour',
      profileAction: 'Schedule heavy physical tasks before 11:00 or after 16:30.',
      coolingMethod: 'Wear UV-protective sunglasses and breathable light fabrics.',
      warningSign: 'Mild dizziness, fatigue, persistent excessive thirst.',
    );
  }

  DynamicAdviceResult _buildModerateAdvice(double utci, UserRole role) {
    return const DynamicAdviceResult(
      headline: 'MODERATE HEAT: Standard Safety Protocol',
      workRestCycle: 'Standard workflow with 10-min hourly hydration break',
      hydrationGoal: '350ml to 500ml water per hour',
      profileAction: 'Stay mindful of direct sunlight angle during midday.',
      coolingMethod: 'Stay in natural shade when taking work pauses.',
      warningSign: 'General dehydration or dry throat.',
    );
  }

  DynamicAdviceResult _buildComfortAdvice(double utci, UserRole role) {
    return const DynamicAdviceResult(
      headline: 'THERMAL COMFORT: Optimal Working Conditions',
      workRestCycle: 'Normal operating hours without heat restrictions',
      hydrationGoal: 'Standard daily hydration (2.0 to 2.5 Liters total)',
      profileAction: 'Great time for outdoor logistics and field tasks.',
      coolingMethod: 'Ambient natural cooling.',
      warningSign: 'No significant heat hazard detected.',
    );
  }

  // --- NATIVE TRANSLATIONS FOR DASHBOARD PLAN TILES ---
  DynamicAdviceResult _buildArabicAdvice(String cat, double utci, UserRole role) {
    if (cat == 'extreme' || cat == 'very_strong') {
      return const DynamicAdviceResult(
        headline: 'تحذير حرج: خطة السلامة الحرارية الميدانية',
        workRestCycle: '١٥ دقيقة عمل / ٤٥ دقيقة راحة في الظل العميق',
        hydrationGoal: '١٫٠ إلى ١٫٢ لتر ماء في الساعة مع أملاح معدنية',
        profileAction: 'نقل العمل للظل فوراً وتطبيق نظام المراقبة الثنائية',
        coolingMethod: 'تبليل منشفة بالماء البارد ووضعها خلف الرقبة والمعصمين',
        warningSign: 'التشوش الذهني أو توقف التعرق أو الدوار الشديد',
      );
    }
    return const DynamicAdviceResult(
      headline: 'إرشادات السلامة الحرارية الوقائية',
      workRestCycle: '٤٥ دقيقة عمل / ١٥ دقيقة استراحة في الظل',
      hydrationGoal: 'نصف لتر إلى ٧٥٠ مل ماء كل ساعة بانتظام',
      profileAction: 'تأجيل الأعمال الثقيلة للصباح الباكر أو بعد العصر',
      coolingMethod: 'ارتداء ملابس قطنية خفيفة وقبعة واسعة',
      warningSign: 'الصداع، التعب السريع، أو جفاف الفم',
    );
  }

  DynamicAdviceResult _buildUrduAdvice(String cat, double utci, UserRole role) {
    if (cat == 'extreme' || cat == 'very_strong') {
      return const DynamicAdviceResult(
        headline: 'شدید گرمی: ہنگامی حفاظتی پروٹوکول',
        workRestCycle: '15 منٹ کام / 45 منٹ گہرے سائے میں آرام',
        hydrationGoal: 'ہر گھنٹے 1 لیٹر پانی نمکیات/او آر ایس کے ساتھ پییں',
        profileAction: 'کھلی دھوپ میں کام بند کریں اور ایک دوسرے کی نگرانی کریں',
        coolingMethod: 'گردن، ماتھے اور بازوؤں پر گیلا ٹھنڈا کپڑا رکھیں',
        warningSign: 'چکر آنا، پسینہ رک جانا، یا شدید متلی',
      );
    }
    return const DynamicAdviceResult(
      headline: 'گرمی سے بچاؤ کی ہدایات',
      workRestCycle: '45 منٹ کام / 15 منٹ سائے میں وقفہ',
      hydrationGoal: 'ہر گھنٹے کم از کم 500 سے 750 ملی لیٹر پانی پییں',
      profileAction: 'بھاری کام صبح جلدی یا شام کے وقت نمٹائیں',
      coolingMethod: 'ہلکے سوتی کپڑے اور سر پر ٹوپی کا استعمال کریں',
      warningSign: 'ہلکا سر درد، سستی، یا گلا خشک ہونا',
    );
  }

  DynamicAdviceResult _buildSwahiliAdvice(String cat, double utci, UserRole role) {
    return const DynamicAdviceResult(
      headline: 'Mpango wa Usalama wa Joto Kali',
      workRestCycle: 'Dakika 20 kazi / Dakika 40 kupumzika kivulini',
      hydrationGoal: 'Kunywa lita 1 ya maji safi kila saa',
      profileAction: 'Hamishia shughuli zote maeneo yenye vivuli',
      coolingMethod: 'Loweka kitambaa shingoni na usoni kupunguza joto',
      warningSign: 'Kizunguzungu, kiu kali, au uchovu wa ghafla',
    );
  }

  DynamicAdviceResult _buildFrenchAdvice(String cat, double utci, UserRole role) {
    return const DynamicAdviceResult(
      headline: 'Plan d\'Action Stress Thermique',
      workRestCycle: '20 min de travail / 40 min de repos à l\'ombre',
      hydrationGoal: '1.0 Litre d\'eau fraîche par heure avec électrolytes',
      profileAction: 'Déplacer les tâches physiques lourdes sous abri ombragé',
      coolingMethod: 'Appliquer un linge mouillé sur la nuque et les avant-bras',
      warningSign: 'Confusion, peau rouge et sèche, étourdissements',
    );
  }

  DynamicAdviceResult _buildSpanishAdvice(String cat, double utci, UserRole role) {
    return const DynamicAdviceResult(
      headline: 'Plan de Protección contra el Calor',
      workRestCycle: '20 min de trabajo / 40 min de descanso bajo sombra',
      hydrationGoal: '1.0 Litro de agua fresca por hora con sales minerales',
      profileAction: 'Reprogramar tareas pesadas hacia horas de menor radiación',
      coolingMethod: 'Paño húmedo en la nuca y muñecas para enfriamiento rápido',
      warningSign: 'Mareos, desorientación o cese repentino del sudor',
    );
  }

  DynamicAdviceResult _buildHindiAdvice(String cat, double utci, UserRole role) {
    if (cat == 'extreme' || cat == 'very_strong') {
      return const DynamicAdviceResult(
        headline: 'गंभीर गर्मी: आपातकालीन सुरक्षा प्रोटोकॉल',
        workRestCycle: '15 मिनट काम / 45 मिनट गहरी छाया में आराम',
        hydrationGoal: 'प्रति घंटे 1 से 1.2 लीटर पानी ओआरएस के साथ पिएं',
        profileAction: 'खुली धूप में काम बंद करें, साथी की निगरानी करें',
        coolingMethod: 'गर्दन, माथे और कलाई पर ठंडा गीला कपड़ा रखें',
        warningSign: 'चक्कर आना, पसीना रुकना या तेज सिरदर्द',
      );
    }
    return const DynamicAdviceResult(
      headline: 'गर्मी से बचाव के उपाय',
      workRestCycle: '45 मिनट काम / 15 मिनट छाया में आराम',
      hydrationGoal: 'हर घंटे 500 से 750 मिली लीटर पानी पिएं',
      profileAction: 'भारी काम सुबह जल्दी या शाम को करें',
      coolingMethod: 'हल्के सूती कपड़े पहनें और सिर को ढकें',
      warningSign: 'हल्का सिरदर्द, थकान या गला सूखना',
    );
  }

  /// AI Chat copilot: calls live Google Gemini model when API key is provided,
  /// with dynamic contextual fallback when offline or demo key.
  Future<String> answerQuery({
    required String query,
    required UtciStatusModel? currentStatus,
    required UserRole role,
    String cityName = 'Current Location',
    String countryName = '',
    NativeLanguage? nativeLanguage,
  }) async {
    final apiKey = AppConstants.geminiApiKey.trim();
    final isRealKey = apiKey.isNotEmpty &&
        !apiKey.contains('RandomKey') &&
        !apiKey.contains('ReplaceWithRealKey') &&
        apiKey.startsWith('AIza');

    final language = nativeLanguage ??
        const NativeLanguage(
          code: 'en',
          ttsLocale: 'en-US',
          name: 'English',
          nativeName: 'English',
          flag: '🌐',
        );

    if (isRealKey) {
      try {
        final geminiResponse = await _callGeminiApi(
          apiKey: apiKey,
          query: query,
          status: currentStatus,
          role: role,
          cityName: cityName,
          countryName: countryName,
          language: language,
        );
        if (geminiResponse != null && geminiResponse.trim().isNotEmpty) {
          return geminiResponse.trim();
        }
      } catch (e) {
        debugPrint('Gemini API call failed: $e. Falling back to local intelligence.');
      }
    }

    // Dynamic, concise response generator tailored to query, role, and native language
    return _generateContextualLocalResponse(
      query: query,
      currentStatus: currentStatus,
      role: role,
      cityName: cityName,
      language: language,
      isAiKeyMissing: !isRealKey,
    );
  }

  Future<String?> _callGeminiApi({
    required String apiKey,
    required String query,
    required UtciStatusModel? status,
    required UserRole role,
    required String cityName,
    required String countryName,
    required NativeLanguage language,
  }) async {
    final utci = status?.value.toStringAsFixed(1) ?? '36.5';
    final category = status?.categoryLabel ?? 'Strong Heat Stress';

    final prompt = '''
You are the Biometeorological & Thermal Safety AI Copilot for the UTCI Alert mobile app.
Live User Context:
- Role: ${role.label} (${role.description})
- Location: $cityName, $countryName
- Thermal Index: $utci°C UTCI ($category)
- Native Language: ${language.name} (${language.nativeName}, code: ${language.code})

User Query:
"$query"

CRITICAL INSTRUCTIONS:
1. Respond in ${language.name} (${language.nativeName}) unless the user asked in English.
2. NO NASTY WALLS OF TEXT! Workers need concise, clean, bulleted steps.
3. Maximum 90–120 words.
4. Bold key actions and numbers (hydration volume in ml/L, rest minutes).
5. Provide actionable, practical advice for outdoor shifts and informal housing.
''';

    final url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey';

    final response = await _dio.post(
      url,
      data: {
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ],
        'generationConfig': {
          'temperature': 0.35,
          'maxOutputTokens': 350,
        },
      },
    );

    if (response.statusCode == 200 && response.data != null) {
      final candidates = response.data['candidates'] as List?;
      if (candidates != null && candidates.isNotEmpty) {
        final content = candidates.first['content'] as Map?;
        final parts = content?['parts'] as List?;
        if (parts != null && parts.isNotEmpty) {
          return parts.first['text'] as String?;
        }
      }
    }
    return null;
  }

  String _generateContextualLocalResponse({
    required String query,
    required UtciStatusModel? currentStatus,
    required UserRole role,
    required String cityName,
    required NativeLanguage language,
    required bool isAiKeyMissing,
  }) {
    final utciVal = currentStatus?.value ?? 36.0;
    final category = currentStatus?.categoryLabel ?? 'Strong Heat Stress';

    if (language.code == 'ar') {
      return '''💧 **إرشادات الأمان الحراري لـ ${role.localizedLabel} في $cityName**
المؤشر الحراري الحالي: **$category (${utciVal.toStringAsFixed(1)}°C UTCI)**

• **الترطيب الفوري:** اشرب **٢٥٠ مل ماء كل ١٥-٢٠ دقيقة** (لتر كامل في الساعة). أضف رشة ملح خفيفة لتجنب هبوط الصوديوم.
• **دورة العمل والراحة:** التزم بـ **١٥ دقيقة عمل / ٤٥ دقيقة راحة في الظل** في درجات الحرارة المرتفعة.
• **التبريد الذاتي:** بلل الرقبة والساعدين بالماء، وانزع الخوذة فور التوقف.
• **إشارة الخطر:** التوقف المفاجئ عن التعرق أو الشعور بالدوار يتطلب إسعافاً طبياً فورياً.''';
    }

    if (language.code == 'ur') {
      return '''💧 **${role.localizedLabel} کے لیے تھرمل سیفٹی پلان ($cityName)**
موجودہ درجہ حرارت انڈیکس: **$category (${utciVal.toStringAsFixed(1)}°C UTCI)**

• **پانی کا فوری ہدف:** ہر **15 سے 20 منٹ بعد ایک گلاس پانی** (فی گھنٹہ 1 لیٹر) پییں۔ لیموں پانی یا چٹکی نمک شامل کریں۔
• **کام اور آرام کا شیڈول:** تیز دھوپ میں **15 منٹ کام اور 45 منٹ گہرے سائے میں آرام** کریں۔
• **جسم کو ٹھنڈا رکھنا:** گردن پر گیلا تولیہ رکھیں، سر ڈھانپیں، اور ساتھی ورکرز کا خیال رکھیں۔
• **خطرے کی گھنٹی:** چکر آنا، شدید سر درد یا متلی ہو تو کام فوراً بند کر دیں۔''';
    }

    if (language.code == 'sw') {
      return '''💧 **Mwongozo wa Usalama wa Joto kwa ${role.localizedLabel} ($cityName)**
Kiwango cha Sasa: **$category (${utciVal.toStringAsFixed(1)}°C UTCI)**

• **Unywaji Maji:** Kunywa glasi 1 ya maji kila dakika 20 (Lita 1 kwa saa).
• **Kazi na Mapumziko:** Fanya kazi dakika 20, pumzika dakika 40 kwenye kivuli kizito.
• **Kupunguza Joto:** Loweka kitambaa kwenye maji baridi na weka shingoni.
• **Dalili ya Hatari:** Kizunguzungu au ngozi kavu bila jasho inahitaji msaada wa haraka.''';
    }

    if (language.code == 'fr') {
      return '''💧 **Protocole Sécurité Chaleur pour ${role.localizedLabel} ($cityName)**
Indice Thermique Actuel: **$category (${utciVal.toStringAsFixed(1)}°C UTCI)**

• **Hydratation:** Buvez **250ml d'eau toutes les 20 minutes** (1L par heure). Ajoutez une pincée d'électrolytes.
• **Cycle Travail-Repos:** 20 min de travail / 40 min de pause à l'ombre fraîche.
• **Refroidissement:** Mouillez la nuque et les poignets avec un linge humide.
• **Signes d'Alerte:** Étourdissements ou confusion = évacuation médicale immédiate.''';
    }

    if (language.code == 'es') {
      return '''💧 **Plan de Seguridad Térmica para ${role.localizedLabel} ($cityName)**
Estrés Térmico: **$category (${utciVal.toStringAsFixed(1)}°C UTCI)**

• **Hidratación:** Beba **250ml de agua cada 15-20 minutos** (1L por hora con sales minerales).
• **Ciclo Trabajo-Sombra:** 20 min de esfuerzo / 40 min de descanso bajo sombra densa.
• **Técnica de Alivio:** Paño húmedo en nuca y frente; retire casco al frenar.
• **Alerta Roja:** Piel seca y caliente o mareos requieren auxilio urgente.''';
    }

    if (language.code == 'hi') {
      return '''💧 **${role.localizedLabel} के लिए थर्मल सुरक्षा योजना ($cityName)**
वर्तमान ताप सूचकांक: **$category (${utciVal.toStringAsFixed(1)}°C UTCI)**

• **जलयोजन लक्ष्य:** हर **15-20 मिनट में एक गिलास पानी** पिएं (प्रति घंटे ~1 लीटर)। नींबू पानी या हल्का नमक मिलाएं।
• **काम-आराम चक्र:** तेज धूप में **20 मिनट काम / 40 मिनट गहरी छाया में आराम** करें।
• **शरीर को ठंडा रखें:** गर्दन और कलाई पर ठंडा गीला कपड़ा रखें।
• **खतरे का संकेत:** चक्कर आना, पसीना रुकना या भ्रम होने पर तुरंत चिकित्सा सहायता लें।''';
    }

    final q = query.toLowerCase();

    if (q.contains('roof') || q.contains('tin') || q.contains('informal') || q.contains('house')) {
      return '''🏠 **Passive Cooling for Tin & Informal Homes ($cityName)**
• **Evaporative Screens:** Hang wet burlap or jute sacks across windows to drop inflow air by 3–5°C.
• **Night Purge:** Keep vents open from 20:00 to 07:00 to flush stored radiant metal heat.
• **Roof Whitewash:** Painting corrugated metal with lime whitewash reflects up to 75% of solar radiation.''';
    }

    if (q.contains('hydration') || q.contains('water') || q.contains('drink')) {
      return '''💧 **Hourly Hydration Protocol for ${role.localizedLabel} ($cityName)**
Current Index: **$category (${utciVal.toStringAsFixed(1)}°C UTCI)**
• **Volume Target:** Drink **250ml (1 glass) of water every 15–20 minutes** (~1.0 Liter/hr).
• **Electrolytes:** Add a pinch of salt or lemon water during heavy sweating to prevent salt depletion.
• **Avoid Dehydrators:** Avoid high-sugar energy drinks and excessive caffeine.''';
    }

    // Default concise English
    return '''💡 **Thermal Safety Action Plan for ${role.localizedLabel}**
Current Ground Condition: **$category (${utciVal.toStringAsFixed(1)}°C UTCI)** in $cityName.

• **Hydration Target:** Drink **250ml clean water every 15–20 minutes** (~1.0 Liter/hr). Avoid energy drinks.
• **Work-Rest Ratio:** Under elevated UTCI, implement **20 min work / 40 min shaded rest** cycles.
• **Field Cooling:** Keep wrists and back of neck dampened with cool water.
• **Red Flag Warning:** Confusion, stumbling, or cessation of sweating indicates emergency heat stroke.''';
  }
}
