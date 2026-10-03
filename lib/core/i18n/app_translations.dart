// lib/core/i18n/app_translations.dart
// GetX Translations — comprehensive coverage for all static & dynamic UI strings.
// Keys use snake_case across all 7 supported languages.

import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    final dict = <String, Map<String, String>>{
        // ── English ──────────────────────────────────────────────────────────
        'en_US': {
          // Auth Screen
          'app_name': 'UTCI Alert',
          'app_subtitle': 'Know the heat before it knows you',
          'select_profile': 'Select your profile',
          'select_profile_desc':
              'Alerts, rest ratios, and AI tips adapt dynamically to your daily environment',
          'enter_dashboard': 'Enter Thermal Dashboard',
          'sign_in_google': 'Sign in with Google (Firebase)',

          // Roles
          'role_outdoor_worker': 'Outdoor Worker',
          'role_outdoor_worker_desc':
              'Construction, street vendors & field laborers exposed to direct sun',
          'role_delivery_rider': 'Delivery Rider',
          'role_delivery_rider_desc':
              'Motorbike & bicycle couriers facing asphalt heat & helmet buildup',
          'role_farmer': 'Farmer',
          'role_farmer_desc':
              'Agricultural workers managing crop harvesting & livestock in peak heat',
          'role_informal_resident': 'Informal Settlement',
          'role_informal_resident_desc':
              'Residents in high-density areas with corrugated tin roofing & limited shade',
          'role_vulnerable': 'Elderly & Vulnerable',
          'role_vulnerable_desc':
              'Individuals with hypertension, respiratory risks, children & elderly',

          // Main Nav
          'nav_radar': 'Radar',
          'nav_forecast': 'Forecast',
          'nav_ai': 'AI Advisor',
          'nav_toolkit': 'Toolkit',
          'nav_settings': 'Settings',
          'nav_ai_copilot': 'AI Copilot',

          // Dashboard
          'dashboard_title': 'Thermal Dashboard',
          'choose_language': 'Choose Alert & Voice Language',
          'choose_language_desc':
              'Warnings, AI advice, and voice readings will adapt to this tongue.',
          'switch_profile': 'Switch Vulnerability Profile',
          'switch_profile_desc':
              'Calibrates work-rest cycles and hydration targets to your field realities.',
          'city_region': 'City / Region',
          'search_city_hint': 'Search city or region...',
          'gps_location': 'Use GPS Location',
          'refresh': 'Refresh',
          'utci_index': 'UTCI Index',
          'heat_stress': 'Heat Stress',
          'ai_advice': 'AI Advice',
          'read_aloud': 'Read Aloud',
          'safe_work_windows': 'Safe Work Windows',
          'morning_window': 'Morning Window',
          'danger_window': 'Danger Window',
          'evening_window': 'Evening Window',
          'status_safe_moderate': 'Safe / Moderate',
          'status_very_strong': 'Very Strong',
          'status_recommended': 'Recommended',
          'radar_title': 'THERMAL COMFORT RADAR',
          'radar_subtitle': 'Universal Thermal Climate Index (UTCI)',
          'radar_desc':
              'Combines temperature, solar radiation, humidity & wind airflow',
          'voice_label': 'Voice',
          'live_hazard_advisory': 'Live Hazard Advisory',
          'deep_shade_mandatory': 'Deep Shade Mandatory',
          'chip_rest_extreme': '15m Work / 45m Rest',
          'chip_rest_normal': '45m Work / 15m Rest',
          'chip_water_extreme': '1.0L / hour',
          'chip_water_normal': '500–750ml / hour',
          'ai_safety_plan': 'AI Safety Plan',
          'instant_field_protocol': 'Instant Field Protocol',
          'work_rest_label': 'Work / Rest',
          'hydration_label': 'Hydration',
          'field_action_label': 'Field Action',
          'cooling_method_label': 'Cooling Method',
          'air_temp': 'Air Temperature',
          'rel_humidity': 'Relative Humidity',
          'wind_speed': 'Wind Speed',
          'apparent_heat': 'Apparent Heat',
          'hourly_progression': '24-Hour Thermal Progression',
          'hourly_curve': 'Hourly UTCI Curve',

          // City Selector Sheet
          'select_city_title': 'Select City or Region',
          'select_city_sub': 'Worldwide Geocoding & Hyperlocal GPS',
          'use_exact_gps': 'Use Exact GPS Location & Geofence',
          'gps_locating': 'Pinpointing high-accuracy GPS & locality...',
          'gps_detected': 'Auto-detects real city, danger perimeter & native voice',
          'search_worldwide_hint':
              'Search any city worldwide (e.g. Cairo, Riyadh, Lahore, Madrid)...',
          'featured_hubs': 'Featured Global Hubs',
          'search_results': 'Search Results',
          'locations_count': 'locations',
          'no_cities_found': 'No matching cities found. Try another city name.',

          // Settings Screen
          'settings_title': 'Settings & Profile',
          'active_profile': 'Active User Profile',
          'active_profile_desc':
              'Select your profile to automatically adapt alert messaging, tone, and guidance.',
          'voice_tts': 'Voice Engine (TTS)',
          'voice_tts_desc':
              'On-device speech synthesizer. Enables hands-free audio alerts while riding or working.',
          'test_voice': 'Test Voice',
          'speech_speed': 'Speech Speed',
          'voice_pitch': 'Voice Pitch',
          'alert_threshold': 'Alert Trigger Threshold',
          'alert_threshold_desc':
              'Notify with audio and banner when local thermal index exceeds this limit.',
          'about_title': 'About UTCI Alert & Science Basis',
          'about_desc':
              'Intechvia Flutter Internship Programme · Innovation Sprint\nAuthor: Mansoor Ahmed\nVersion: 1.0 Production Edition',
          'scientific_refs': 'Scientific References & Data Sources:',
          'ref_era5_title': 'ERA5-HEAT Global Reanalysis (1974–2023)',
          'ref_era5_desc':
              '50-year 0.25°x0.25° grid bioclimatic heat index reanalysis (Hersbach et al. 2020).',
          'ref_african_title': 'African Urban Heatwaves Study',
          'ref_african_desc':
              'Extreme heat doubling across Alexandria, Algiers, Tunis, Kano, Dakar, Ibadan (Igun et al. 2022).',
          'ref_chews_title': 'CHEWS Early Warning (Nigeria)',
          'ref_chews_desc':
              'Community-Centred Heat Early Warning System benchmark (Adegun et al. 2026).',

          // Guidance Screen
          'guidance_title': 'Protective Toolkit',
          'guidance_for': 'Personalized for',
          'hydration_guard': 'Hydration Guard',
          'hydration_reset': 'Reset',
          'goal_suffix': 'goal',
          'add_glass': '+250ml Glass',
          'add_bottle': '+500ml Bottle',
          'shift_checklist': 'Shift Heat Preparedness',
          'listen': 'Listen',
          'emergency_triage': 'Heatstroke Emergency Triage',
          'heat_exhaustion': 'Heat Exhaustion',
          'heat_exhaustion_s1': '• Cool, pale clammy skin',
          'heat_exhaustion_s2': '• Heavy sweating',
          'heat_exhaustion_s3': '• Dizziness & nausea',
          'heat_exhaustion_action':
              'Action: Move to shade, loosen clothes, sip cool water.',
          'heatstroke_critical': 'Heat Stroke (CRITICAL)',
          'heatstroke_s1': '• Core Temp > 40°C',
          'heatstroke_s2': '• Hot, red skin (dry/sweaty)',
          'heatstroke_s3': '• Confusion or delirium',
          'heatstroke_action':
              'Action: Call 112 / Emergency! Douse with cold water.',
          'cooling_guide': 'Informal Settlement Cooling Hacks',
          'cooling_guide_desc':
              'Zero-electricity techniques co-designed for informal settlement realities',
          'tip_jute_title': 'Damp Jute Window Screen',
          'tip_jute_desc':
              'Hang wet burlap across open windows; air passing through drops 3-5°C.',
          'tip_whitewash_title': 'Whitewash Corrugated Tin Roofs',
          'tip_whitewash_desc':
              'Calcium lime whitewash reflects 75% of solar heat, saving living areas from baking.',
          'tip_flushing_title': 'Night Thermal Flushing',
          'tip_flushing_desc':
              'Open opposing high vents after sunset to purge heat stored in walls and metal sheets.',

          // AI Advisor Screen
          'ai_advisor_title': 'AI Thermal Safety Advisor',
          'ai_thinking': 'Consulting AI Biometeorological Model...',
          'ai_label': 'AI Heat Advisor',
          'ai_hint':
              'Ask thermal safety advice (e.g. hydration, work hours)...',
          'stop': 'Stop',

          // Forecast Screen
          'forecast_title': '7-Day UTCI Forecast',
          'forecast_sub': 'Bioclimatic Projections',
          'hourly_timeline_title': 'Hourly UTCI Timeline (24 Hours)',
          'hourly_timeline_desc': 'Physiological thermal stress calculated per hour',
          'forecast_7day_title': '7-Day Heatwave Risk Radar',
          'forecast_7day_badge': 'ERA5-HEAT Model',
          'forecast_7day_desc': 'Detects extended multi-day heat episodes (3-5 day duration risk)',
          'heatwave_label': 'HEATWAVE',
          'normal_label': 'Normal',
          'high_sweat_barrier': 'High sweat barrier',
          'normal_sweat_rate': 'Normal sweat rate',
          'direct_solar_radiance': 'Direct solar radiance',
          'airflow_suffix': 'airflow',

          // Heat Stress Category Labels
          'heat_stress_no_stress': 'No Heat Stress',
          'heat_stress_moderate': 'Moderate Heat Stress',
          'heat_stress_strong': 'Strong Heat Stress',
          'heat_stress_very_strong': 'Very Strong Heat Stress',
          'heat_stress_extreme': 'Extreme Heat Stress',
          'heat_stress_cold_stress': 'Cold Stress',
          'heat_stress_unknown': 'Unknown',

          // UTCI Gauge
          'utci_equivalent': 'UTCI Equivalent',

          // Weather Descriptions
          'weather_clear_sky': 'Clear Sky',
          'weather_partly_cloudy': 'Partly Cloudy',
          'weather_overcast': 'Overcast',
          'weather_haze_dust': 'Haze / Dust',
          'weather_light_drizzle': 'Light Drizzle',
          'weather_rain_shower': 'Rain Shower',
          'weather_heavy_rain': 'Heavy Rain',
          'weather_thunderstorm': 'Thunderstorm',
          'weather_sunny_clear': 'Sunny / Clear',

          // Geofence Dialog & Badges
          'geofence_alert': 'GEOFENCE ALERT',
          'geofence_safe_perimeter': 'SAFE PERIMETER',
          'geofence_gps_coordinates': 'GPS Coordinates',
          'geofence_radius': 'Geofence Radius',
          'geofence_perimeter_suffix': 'Perimeter',
          'geofence_distance_center': 'Distance to Epicenter',
          'geofence_danger_threshold': 'Danger Threshold',
          'geofence_rescan_btn': 'Re-Scan Location & Perimeter',
          'geofence_standard_perimeter': 'Standard Thermal Perimeter',
          'geofence_standard_summary':
              'Normal thermal boundary. No active heat stress geofence triggers.',
          'geofence_zone_danger': '@city Severe Heat Geofence',
          'geofence_zone_regional': '@city Regional Heatwave',
          'geofence_zone_safe': '@city Safe Thermal Perimeter',
          'geofence_critical_active':
              'CRITICAL GEOFENCE ACTIVE: Your location (@lat, @lon) is within the @radius km danger perimeter where UTCI (@utci°C) exceeds safety threshold (38°C).',
          'geofence_regional_heatwave':
              'Regional heatwave detected (@utci°C UTCI). Distance to focal center: @dist km.',
          'geofence_safe_zone':
              'You are in a safe bioclimatic zone. Local UTCI is @utci°C (well below 38°C danger threshold).',

          // Audio Player Bar & Tooltips
          'voice_readout': 'VOICE READOUT',
          'on_device_audio': 'On-Device Audio',
          'stop_speaking': 'Stop speaking',
          'listen_in_lang': 'Listen in @lang',

          // Forecast Screen Additions
          'temp_label': 'Temp',
          'humidity_label': 'Humidity',
          'max_label': 'Max',
          'min_label': 'Min',
          'danger_badge': 'DANGER',
          'listen_forecast_tooltip': 'Listen to forecast',
          'refresh_forecast_tooltip': 'Refresh forecast',
          'today': 'Today',
          'day_mon': 'Mon',
          'day_tue': 'Tue',
          'day_wed': 'Wed',
          'day_thu': 'Thu',
          'day_fri': 'Fri',
          'day_sat': 'Sat',
          'day_sun': 'Sun',
          'safe_work_rec_peak':
              'Dangerous heat peak expected between @danger. Shift outdoor shifts to morning (@morning) or evening (@evening).',
          'safe_work_rec_default':
              'Conduct heavy field or delivery tasks early morning or late afternoon.',

          // AI Advisor Quick Prompts
          'prompt_hydration': '💧 Hourly hydration plan',
          'prompt_work_rest': '⏱️ Work/rest ratio',
          'prompt_exhaustion_stroke': '⚠️ Exhaustion vs Stroke',
          'prompt_rider_gear': '🛵 Rider helmet & asphalt',
          'prompt_cool_roof': '🏠 Cool roof without AC',
          'prompt_harvesting': '🌾 Safe harvesting shift',

          // Guidance Checklist Items
          'check_ow_c1_title': '2.5L Clean Water Jug Prepared',
          'check_ow_c1_desc':
              'Have cool water accessible within 2 minutes of your work area.',
          'check_ow_c2_title': 'Wide-Brim Hat or Neck Shade',
          'check_ow_c2_desc':
              'Drape a damp cloth under your hardhat or wear a wide brim.',
          'check_ow_c3_title': 'Shade Canopy Identified',
          'check_ow_c3_desc':
              'Locate a covered area with air movement for your 15-min hourly rest.',
          'check_ow_c4_title': 'Buddy System Active',
          'check_ow_c4_desc':
              'Agree with a coworker to monitor each other for slurred speech or dizziness.',

          'check_dr_r1_title': 'Visor Clean & Vent Opened',
          'check_dr_r1_desc':
              'Keep face visor cracked 1-notch to prevent 48°C helmet heat pocket.',
          'check_dr_r2_title': 'Wet Neck Gaiter / Bandana',
          'check_dr_r2_desc':
              'Dampen bandana before heading out for wind-chill convective cooling.',
          'check_dr_r3_title': 'Insulated Water Flask',
          'check_dr_r3_desc':
              'Carry cold water; avoid energy drinks that cause kidney stress.',
          'check_dr_r4_title': 'Shaded Parking at Hubs',
          'check_dr_r4_desc':
              'Park motorbike under trees between pickups to keep seat cool.',

          'check_fm_f1_title': 'Early Sunrise Field Shift',
          'check_fm_f1_desc':
              'Complete ground tilling and harvesting before 10:30 AM.',
          'check_fm_f2_title': 'Livestock Shade & Troughs',
          'check_fm_f2_desc':
              'Verify animal enclosures have deep shade and abundant water.',
          'check_fm_f3_title': 'Loose Cotton Long Sleeves',
          'check_fm_f3_desc':
              'Shield arms against intense UV radiation while allowing airflow.',
          'check_fm_f4_title': 'Midday Field Evacuation',
          'check_fm_f4_desc':
              'Retire from open fields between 11:30 AM and 03:30 PM.',

          'check_ir_i1_title': 'Window Burlap Screen Soaked',
          'check_ir_i1_desc':
              'Wet jute sacks on windward openings drop room temps by 3–4°C.',
          'check_ir_i2_title': 'High Vents Kept Open',
          'check_ir_i2_desc':
              'Let trapped hot air rise and escape through high roof vents.',
          'check_ir_i3_title': 'Community Shade Check',
          'check_ir_i3_desc':
              'Locate nearest public shade tree or cool community shelter.',
          'check_ir_i4_title': 'Drink Boiled & Cooled Water',
          'check_ir_i4_desc':
              'Store safe drinking water in terracotta pots for natural cooling.',

          'check_vn_v1_title': 'Coolest Ground Floor Room',
          'check_vn_v1_desc':
              'Stay in the lowest room of the house where air is coolest.',
          'check_vn_v2_title': 'Cool Water Foot Soak',
          'check_vn_v2_desc':
              'Submerging feet in cool water rapidly lowers core body temperature.',
          'check_vn_v3_title': 'Hourly Water Glass Schedule',
          'check_vn_v3_desc':
              'Sip 200ml every hour even without feeling thirsty.',
          'check_vn_v4_title': 'Emergency Contact Speed Dial',
          'check_vn_v4_desc':
              'Ensure community health worker or neighbor phone is readily accessible.',

          'emergency_first_aid_speech':
              'Heat Stroke Emergency Protocol. Move victim to deep shade immediately. Lay them flat and elevate feet 30 centimeters. Douse body with cold water or wet towels. Call local emergency health services immediately. Do not give fluids if unconscious.',
        },

        // ── Arabic ──────────────────────────────────────────────────────────
        'ar_SA': {
          'app_name': 'تنبيه UTCI',
          'app_subtitle': 'اعرف الحرارة قبل أن تعرفك',
          'select_profile': 'اختر ملفك الشخصي',
          'select_profile_desc':
              'تتكيف التنبيهات ونسب الراحة ونصائح الذكاء الاصطناعي ديناميكياً مع بيئتك اليومية',
          'enter_dashboard': 'دخول لوحة الحرارة',
          'sign_in_google': 'تسجيل الدخول بـ Google',

          // Roles
          'role_outdoor_worker': 'عامل في الهواء الطلق',
          'role_outdoor_worker_desc':
              'عمال البناء والباعة المتجولون والعمال المعرضون للشمس المباشرة',
          'role_delivery_rider': 'سائق توصيل',
          'role_delivery_rider_desc':
              'سائقو الدراجات النارية والهوائية المعرضون لحرارة الأسفلت والخوذة',
          'role_farmer': 'مزارع',
          'role_farmer_desc':
              'عمال الزراعة وحصاد المحاصيل ورعاية الماشية في ذروة الحرارة',
          'role_informal_resident': 'مستوطنة غير رسمية',
          'role_informal_resident_desc':
              'سكان المناطق ذات الأسقف المعدنية ذات الظل المحدود',
          'role_vulnerable': 'كبار السن والفئات المعرضة للخطر',
          'role_vulnerable_desc':
              'الأشخاص المصابون بأمراض مزمنة والأطفال وكبار السن',

          'nav_radar': 'رادار',
          'nav_forecast': 'التوقعات',
          'nav_ai': 'مستشار AI',
          'nav_toolkit': 'الأدوات',
          'nav_settings': 'الإعدادات',
          'nav_ai_copilot': 'مساعد AI',

          'dashboard_title': 'لوحة الحرارة',
          'choose_language': 'اختر لغة التنبيه والصوت',
          'choose_language_desc':
              'ستتكيف التحذيرات ومشورة الذكاء الاصطناعي والقراءات الصوتية مع هذه اللغة.',
          'switch_profile': 'تغيير ملف الضعف',
          'switch_profile_desc':
              'يضبط دورات العمل والراحة وأهداف الترطيب وفق واقعك الميداني.',
          'city_region': 'المدينة / المنطقة',
          'search_city_hint': 'ابحث عن مدينة أو منطقة...',
          'gps_location': 'استخدم موقع GPS',
          'refresh': 'تحديث',
          'utci_index': 'مؤشر UTCI',
          'heat_stress': 'الإجهاد الحراري',
          'ai_advice': 'نصيحة AI',
          'read_aloud': 'قراءة بصوت عالٍ',
          'safe_work_windows': 'نوافذ العمل الآمنة',
          'morning_window': 'نافذة الصباح',
          'danger_window': 'نافذة الخطر',
          'evening_window': 'نافذة المساء',
          'status_safe_moderate': 'آمن / معتدل',
          'status_very_strong': 'شديد جداً',
          'status_recommended': 'موصى به',
          'radar_title': 'رادار الراحة الحرارية',
          'radar_subtitle': 'المؤشر المناخي الحراري الشامل (UTCI)',
          'radar_desc': 'يجمع بين درجات الحرارة والإشعاع الشمسي والرطوبة وسرعة الرياح',
          'voice_label': 'الصوت',
          'live_hazard_advisory': 'استشارة المخاطر الحية',
          'deep_shade_mandatory': 'الظل العميق إلزامي',
          'chip_rest_extreme': '15 دقيقة عمل / 45 دقيقة راحة',
          'chip_rest_normal': '45 دقيقة عمل / 15 دقيقة راحة',
          'chip_water_extreme': '1.0 لتر / ساعة',
          'chip_water_normal': '500–750 مل / ساعة',
          'ai_safety_plan': 'خطة أمان AI',
          'instant_field_protocol': 'بروتوكول ميداني فوري',
          'work_rest_label': 'العمل / الراحة',
          'hydration_label': 'الترطيب',
          'field_action_label': 'الإجراء الميداني',
          'cooling_method_label': 'طريقة التبريد',
          'air_temp': 'درجة حرارة الهواء',
          'rel_humidity': 'الرطوبة النسبية',
          'wind_speed': 'سرعة الرياح',
          'apparent_heat': 'الحرارة المحسوسة',
          'hourly_progression': 'التطور الحراري على مدار 24 ساعة',
          'hourly_curve': 'منحنى UTCI بالساعة',

          // City Selector Sheet
          'select_city_title': 'اختر المدينة أو المنطقة',
          'select_city_sub': 'تحديد المواقع الجغرافي ونظام GPS فائق الدقة',
          'use_exact_gps': 'استخدم موقع GPS الدقيق والسياج الجغرافي',
          'gps_locating': 'جاري تحديد إحداثيات GPS بدقة...',
          'gps_detected': 'يكتشف المدينة الحقيقية ومحيط الخطر والصوت الأصلي تلقائياً',
          'search_worldwide_hint':
              'ابحث عن أي مدينة حول العالم (مثل القاهرة، الرياض، لاهور، مدريد)...',
          'featured_hubs': 'أبرز المراكز العالمية',
          'search_results': 'نتائج البحث',
          'locations_count': 'مواقع',
          'no_cities_found': 'لم يتم العثور على مدن مطابقة. جرب اسم مدينة آخر.',

          'settings_title': 'الإعدادات والملف الشخصي',
          'active_profile': 'الملف الشخصي النشط',
          'active_profile_desc':
              'اختر ملفك لتكييف رسائل التنبيه ونبرتها وإرشاداتها تلقائياً.',
          'voice_tts': 'محرك الصوت (TTS)',
          'voice_tts_desc':
              'مُركِّب الكلام على الجهاز. يتيح التنبيهات الصوتية أثناء القيادة أو العمل.',
          'test_voice': 'اختبار الصوت',
          'speech_speed': 'سرعة الكلام',
          'voice_pitch': 'درجة الصوت',
          'alert_threshold': 'عتبة تفعيل التنبيه',
          'alert_threshold_desc':
              'أرسل إشعاراً صوتياً عندما يتجاوز المؤشر الحراري المحلي هذا الحد.',
          'about_title': 'حول تطبيق UTCI Alert والأساس العلمي',
          'about_desc':
              'برنامج التدريب Intechvia Flutter · سباق الابتكار\nالمؤلف: منصور أحمد\nالإصدار: 1.0 نسخة إنتاج',
          'scientific_refs': 'المراجع العلمية ومصادر البيانات:',
          'ref_era5_title': 'إعادة التحليل العالمي ERA5-HEAT (1974–2023)',
          'ref_era5_desc':
              'تحليل مؤشر الإجهاد الحراري المناخي لـ 50 عاماً بشبكة 0.25°x0.25°.',
          'ref_african_title': 'دراسة موجات الحر الحضرية الأفريقية',
          'ref_african_desc':
              'مضاعفة الحر الشديد عبر الإسكندرية والجزائر وتونس وكانو ودكار.',
          'ref_chews_title': 'نظام الإنذار المبكر المجتمعي CHEWS (نيجيريا)',
          'ref_chews_desc':
              'معيار نظام الإنذار المبكر بالحرارة المرتكز على المجتمع.',

          'guidance_title': 'صندوق أدوات الحماية',
          'guidance_for': 'مخصص لـ',
          'hydration_guard': 'حارس الترطيب',
          'hydration_reset': 'إعادة تعيين',
          'goal_suffix': 'هدف',
          'add_glass': '+250 مل كوب',
          'add_bottle': '+500 مل قارورة',
          'shift_checklist': 'جاهزية الوردية للحرارة',
          'listen': 'استمع',
          'emergency_triage': 'الإسعاف الأولي لضربة الشمس',
          'heat_exhaustion': 'إعياء حراري',
          'heat_exhaustion_s1': '• جلد بارد شاحب رطب',
          'heat_exhaustion_s2': '• تعرق غزير',
          'heat_exhaustion_s3': '• دوخة وغثيان',
          'heat_exhaustion_action':
              'الإجراء: انتقل للظل، خفف الملابس، اشرب ماء بارداً.',
          'heatstroke_critical': 'ضربة شمس (حرجة)',
          'heatstroke_s1': '• درجة حرارة أساسية > 40°C',
          'heatstroke_s2': '• جلد أحمر ساخن',
          'heatstroke_s3': '• تشوش أو هذيان',
          'heatstroke_action': 'الإجراء: اتصل بـ 112! غمّر بالماء البارد.',
          'cooling_guide': 'حيل تبريد المستوطنات',
          'cooling_guide_desc':
              'تقنيات بدون كهرباء مصممة لواقع المستوطنات',
          'tip_jute_title': 'ستارة خيش رطبة للنوافذ',
          'tip_jute_desc':
              'علق خيشاً مبللاً على النوافذ المفتوحة؛ يخفض حرارة الهواء الداخل 3-5 درجات.',
          'tip_whitewash_title': 'طلاء الأسقف المعدنية بالجير الأبيض',
          'tip_whitewash_desc':
              'يعكس الطلاء الكلسي 75% من حرارة الشمس، مما يمنع ارتفاع حرارة المنزل.',
          'tip_flushing_title': 'التهوية الليلية المتقابلة',
          'tip_flushing_desc':
              'افتح النوافذ المتقابلة بعد الغروب لطرد الحرارة المحتبسة بالجدران والأسقف.',

          'ai_advisor_title': 'مستشار السلامة الحرارية بالذكاء الاصطناعي',
          'ai_thinking': 'استشارة نموذج الذكاء الاصطناعي...',
          'ai_label': 'مستشار الحرارة AI',
          'ai_hint': 'اسأل عن نصيحة السلامة الحرارية...',
          'stop': 'إيقاف',
          'forecast_title': 'توقعات 7 أيام UTCI',
          'forecast_sub': 'توقعات المناخ الحيوي',
          'hourly_timeline_title': 'مخطط UTCI بالساعة (24 ساعة)',
          'hourly_timeline_desc': 'الإجهاد الحراري الفيزيولوجي المحسوب لكل ساعة',
          'forecast_7day_title': 'رادار مخاطر الموجة الحارة لـ 7 أيام',
          'forecast_7day_badge': 'نموذج ERA5-HEAT',
          'forecast_7day_desc': 'يكتشف حلقات الحرارة الممتدة متعددة الأيام',
          'heatwave_label': 'موجة حارة',
          'normal_label': 'طبيعي',
          'high_sweat_barrier': 'حاجز عرق مرتفع',
          'normal_sweat_rate': 'معدل عرق طبيعي',
          'direct_solar_radiance': 'إشعاع شمسي مباشر',
          'airflow_suffix': 'تدفق هواء',

          // Heat Stress Category Labels
          'heat_stress_no_stress': 'لا يوجد إجهاد حراري',
          'heat_stress_moderate': 'إجهاد حراري معتدل',
          'heat_stress_strong': 'إجهاد حراري قوي',
          'heat_stress_very_strong': 'إجهاد حراري قوي جداً',
          'heat_stress_extreme': 'إجهاد حراري حرج وأقصى',
          'heat_stress_cold_stress': 'إجهاد البرودة',
          'heat_stress_unknown': 'غير معروف',

          // UTCI Gauge
          'utci_equivalent': 'مكافئ UTCI',

          // Weather Descriptions
          'weather_clear_sky': 'سماء صافية',
          'weather_partly_cloudy': 'غائم جزئياً',
          'weather_overcast': 'غائم كلياً',
          'weather_haze_dust': 'سديم / غبار',
          'weather_light_drizzle': 'رذاذ خفيف',
          'weather_rain_shower': 'زخات مطر',
          'weather_heavy_rain': 'أمطار غزيرة',
          'weather_thunderstorm': 'عاصفة رعدية',
          'weather_sunny_clear': 'مشمس وصافٍ',

          // Geofence Dialog & Badges
          'geofence_alert': 'تنبيه السياج الجغرافي',
          'geofence_safe_perimeter': 'محيط آمن',
          'geofence_gps_coordinates': 'إحداثيات GPS',
          'geofence_radius': 'نصف قطر النطاق',
          'geofence_perimeter_suffix': 'محيط',
          'geofence_distance_center': 'المسافة إلى المركز',
          'geofence_danger_threshold': 'عتبة الخطر',
          'geofence_rescan_btn': 'إعادة مسح الموقع والمحيط',
          'geofence_standard_perimeter': 'المحيط الحراري المعياري',
          'geofence_standard_summary':
              'حدود حرارية طبيعية. لا توجد تنبيهات نشطة للإجهاد الحراري.',
          'geofence_zone_danger': 'سياج الحرارة الشديدة في @city',
          'geofence_zone_regional': 'موجة حارة إقليمية في @city',
          'geofence_zone_safe': 'محيط حراري آمن في @city',
          'geofence_critical_active':
              'سياج جغرافي حرج نشط: موقعك (@lat, @lon) ضمن نطاق الخطر (@radius كم) حيث يتجاوز المؤشر (@utci°C) حد الأمان (38°C).',
          'geofence_regional_heatwave':
              'رصد موجة حارة إقليمية (@utci°C UTCI). المسافة إلى المركز: @dist كم.',
          'geofence_safe_zone':
              'أنت في منطقة مناخية آمنة. مؤشر UTCI المحلي هو @utci°C (أقل بكثير من عتبة الخطر 38°C).',

          // Audio Player Bar & Tooltips
          'voice_readout': 'قراءة صوتية',
          'on_device_audio': 'صوت من الجهاز',
          'stop_speaking': 'إيقاف الصوت',
          'listen_in_lang': 'استمع باللغة @lang',

          // Forecast Screen Additions
          'temp_label': 'الحرارة',
          'humidity_label': 'الرطوبة',
          'max_label': 'أقصى',
          'min_label': 'أدنى',
          'danger_badge': 'خطر',
          'listen_forecast_tooltip': 'استمع إلى التوقعات',
          'refresh_forecast_tooltip': 'تحديث التوقعات',
          'today': 'اليوم',
          'day_mon': 'الإثنين',
          'day_tue': 'الثلاثاء',
          'day_wed': 'الأربعاء',
          'day_thu': 'الخميس',
          'day_fri': 'الجمعة',
          'day_sat': 'السبت',
          'day_sun': 'الأحد',
          'safe_work_rec_peak':
              'ذروة حرارة خطرة متوقعة بين @danger. انقل الورديات الخارجية إلى الصباح (@morning) أو المساء (@evening).',
          'safe_work_rec_default':
              'قم بالمهام الميدانية الشاقة أو التوصيل في الصباح الباكر أو بعد الظهر المتأخر.',

          // AI Advisor Quick Prompts
          'prompt_hydration': '💧 خطة الترطيب كل ساعة',
          'prompt_work_rest': '⏱️ معدل العمل والراحة',
          'prompt_exhaustion_stroke': '⚠️ الإجهاد الحراري مقابل ضربة الشمس',
          'prompt_rider_gear': '🛵 خوذة السائق وحرارة الأسفلت',
          'prompt_cool_roof': '🏠 تبريد السقف بدون مكيف',
          'prompt_harvesting': '🌾 وردية حصاد آمنة',

          // Guidance Checklist Items
          'check_ow_c1_title': 'تجهيز وعاء ماء نظيف سعة ٢٫٥ لتر',
          'check_ow_c1_desc':
              'تأكد من توفر ماء بارد على مسافة لا تزيد عن دقيقتين من موقع عملك.',
          'check_ow_c2_title': 'قبعة عريضة الحواف أو غطاء للرقبة',
          'check_ow_c2_desc':
              'ضع قطعة قماش مبللة تحت خوذتك أو ارتدِ قبعة بحواف عريضة.',
          'check_ow_c3_title': 'تحديد مظلة أو مكان مظلل مسبقاً',
          'check_ow_c3_desc':
              'حدد مكاناً مظللاً مع حركة هواء لأخذ استراحة الـ ١٥ دقيقة كل ساعة.',
          'check_ow_c4_title': 'تفعيل نظام مراقبة الزميل',
          'check_ow_c4_desc':
              'اتفق مع زميل في العمل لمراقبة بعضكما بحثاً عن الدوار أو صعوبة التحدث.',

          'check_dr_r1_title': 'تنظيف حاجب الخوذة وفتح فتحات التهوية',
          'check_dr_r1_desc':
              'اترك حاجب الخوذة مفتوحاً بدرجة واحدة لتجنب احتباس الحرارة الشديد.',
          'check_dr_r2_title': 'ترطيب غطاء الرقبة أو الشال بالماء',
          'check_dr_r2_desc':
              'بلل الشال بالماء قبل الانطلاق للحصول على تبريد هوائي أثناء القيادة.',
          'check_dr_r3_title': 'حمل قارورة ماء معزولة',
          'check_dr_r3_desc':
              'احمل ماء بارداً وتجنب مشروبات الطاقة التي تجهد الكلى.',
          'check_dr_r4_title': 'ركن الدراجة في الظل عند المحطات',
          'check_dr_r4_desc':
              'اركن الدراجة تحت الأشجار بين التوصيلات لمنع سخونة المقعد.',

          'check_fm_f1_title': 'بدء وردية الحقل مع شروق الشمس',
          'check_fm_f1_desc':
              'أنهِ أعمال الحرث والحصاد قبل الساعة ١٠:٣٠ صباحاً.',
          'check_fm_f2_title': 'توفير الظل وأحواض الماء للماشية',
          'check_fm_f2_desc':
              'تأكد من وجود ظل كثيف ومياه وفيرة لجميع الحيوانات في الحظيرة.',
          'check_fm_f3_title': 'ارتداء أكمام قطنية فضفاضة',
          'check_fm_f3_desc':
              'احمِ ذراعيك من الأشعة فوق البنفسجية المباشرة مع السماح بتدفق الهواء.',
          'check_fm_f4_title': 'مغادرة الحقول المفتوحة وقت الظهيرة',
          'check_fm_f4_desc':
              'توقف عن العمل في الحقول المفتوحة بين الساعة ١١:٣٠ صباحاً و ٣:٣٠ عصراً.',

          'check_ir_i1_title': 'ترطيب ستائر الخيش على النوافذ',
          'check_ir_i1_desc':
              'رش أكياس الخيش بالماء على فتحات التهوية لخفض حرارة الغرفة ٣-٤ درجات.',
          'check_ir_i2_title': 'إبقاء فتحات التهوية العلوية مفتوحة',
          'check_ir_i2_desc':
              'دع الهواء الساخن المحتبس يتصاعد ويخرج عبر منافذ السقف العلوية.',
          'check_ir_i3_title': 'التعرف على مناطق الظل المجتمعية',
          'check_ir_i3_desc':
              'حدد أقرب شجرة ظل عامة أو مركز مجتمعي مكيف أو بارد.',
          'check_ir_i4_title': 'شرب الماء المغلي والمبرد في فخار',
          'check_ir_i4_desc':
              'احفظ ماء الشرب النظيف في أوانٍ فخارية لتبريده طبيعياً.',

          'check_vn_v1_title': 'البقاء في أبرد غرفة أرضية',
          'check_vn_v1_desc':
              'الزم الغرفة السفلية في المنزل حيث يكون الهواء أكثر برودة.',
          'check_vn_v2_title': 'نقع القدمين في ماء بارد',
          'check_vn_v2_desc':
              'غمر القدمين في ماء بارد يخفض حرارة الجسم الداخلية سريعاً.',
          'check_vn_v3_title': 'جدول شرب كوب ماء كل ساعة',
          'check_vn_v3_desc':
              'ارتشف ٢٠٠ مل كل ساعة حتى بدون الشعور بالعطش.',
          'check_vn_v4_title': 'تجهيز رقم الطوارئ للاتصال السريع',
          'check_vn_v4_desc':
              'تأكد من سهولة الاتصال بالعامل الصحي المحلي أو الجار القريب.',

          'emergency_first_aid_speech':
              'بروتوكول طوارئ ضربة الشمس: انقل المصاب إلى أعمق ظل فوراً. اجعله يستلقي وارفع قدميه ٣٠ سنتيمتراً. اسكب ماءً بارداً على جسده أو غطه بمناشف مبللة. اتصل بالإسعاف فوراً. لا تعطه سوائل إذا كان فاقداً للوعي.',
        },

        // ── Urdu ────────────────────────────────────────────────────────────
        'ur_PK': {
          'app_name': 'UTCI الرٹ',
          'app_subtitle': 'گرمی کو پہچانیں، محفوظ رہیں',
          'select_profile': 'اپنا پروفائل منتخب کریں',
          'select_profile_desc':
              'الرٹ، آرام کے اوقات اور AI مشورے آپ کے ماحول کے مطابق ڈھل جاتے ہیں',
          'enter_dashboard': 'حرارت ڈیش بورڈ کھولیں',
          'sign_in_google': 'Google سے سائن ان کریں',

          // Roles
          'role_outdoor_worker': 'بیرونی مزدور',
          'role_outdoor_worker_desc':
              'تعمیراتی، سڑک پر کام کرنے والے اور کھلی دھوپ میں مشقت کرنے والے',
          'role_delivery_rider': 'ڈیلیوری رائیڈر',
          'role_delivery_rider_desc':
              'موٹر سائیکل اور سائیکل سوار جو اسفالٹ کی تپش اور ہیلمٹ کی گرمی جھیلتے ہیں',
          'role_farmer': 'کسان',
          'role_farmer_desc':
              'شدید گرمی میں فصلوں کی کٹائی اور مویشیوں کی دیکھ بھال کرنے والے',
          'role_informal_resident': 'کچی آبادی کے مکین',
          'role_informal_resident_desc':
              'ٹن کی چھتوں والے گنجان آباد علاقوں کے مکین جہاں سایہ کم ہوتا ہے',
          'role_vulnerable': 'بزرگ اور حساس افراد',
          'role_vulnerable_desc':
              'بلڈ پریشر، سانس کے امراض میں مبتلا افراد، بچے اور بزرگ',

          'nav_radar': 'ریڈار',
          'nav_forecast': 'پیش گوئی',
          'nav_ai': 'AI مشیر',
          'nav_toolkit': 'ٹول کٹ',
          'nav_settings': 'ترتیبات',
          'nav_ai_copilot': 'AI معاون',

          'dashboard_title': 'حرارت ڈیش بورڈ',
          'choose_language': 'الرٹ اور آواز کی زبان منتخب کریں',
          'choose_language_desc':
              'وارننگز، AI مشورے اور صوتی الرٹس اس زبان کے مطابق تبدیل ہوں گے۔',
          'switch_profile': 'حساسیت پروفائل تبدیل کریں',
          'switch_profile_desc':
              'آپ کے فیلڈ کام کے مطابق آرام کے وقفے اور پانی کے اہداف ایڈجسٹ کرتا ہے۔',
          'city_region': 'شہر / خطہ',
          'search_city_hint': 'شہر یا خطہ تلاش کریں...',
          'gps_location': 'GPS لوکیشن استعمال کریں',
          'refresh': 'تازہ کریں',
          'utci_index': 'UTCI انڈیکس',
          'heat_stress': 'حرارتی دباؤ',
          'ai_advice': 'AI مشورہ',
          'read_aloud': 'آواز میں سنیں',
          'safe_work_windows': 'کام کے محفوظ اوقات',
          'morning_window': 'صبح کا وقت',
          'danger_window': 'خطرے کا وقت',
          'evening_window': 'شام کا وقت',
          'status_safe_moderate': 'محفوظ / معتدل',
          'status_very_strong': 'بہت شدید',
          'status_recommended': 'تجویز کردہ',
          'radar_title': 'تھرمل کمفرٹ ریڈار',
          'radar_subtitle': 'عالمی حیاتیاتی موسمیاتی انڈیکس (UTCI)',
          'radar_desc': 'درجہ حرارت، سورج کی تابکاری، نمی اور ہوا کی رفتار کا مجموعہ',
          'voice_label': 'آواز',
          'live_hazard_advisory': 'براہ راست خطرے کی وارننگ',
          'deep_shade_mandatory': 'گہرا سایہ لازمی ہے',
          'chip_rest_extreme': '15 منٹ کام / 45 منٹ آرام',
          'chip_rest_normal': '45 منٹ کام / 15 منٹ آرام',
          'chip_water_extreme': '1.0 لیٹر / گھنٹہ',
          'chip_water_normal': '500–750 ملی لیٹر / گھنٹہ',
          'ai_safety_plan': 'AI حفاظتی منصوبہ',
          'instant_field_protocol': 'فوری فیلڈ طریقہ کار',
          'work_rest_label': 'کام / آرام',
          'hydration_label': 'پانی کی مقدار',
          'field_action_label': 'فیلڈ اقدام',
          'cooling_method_label': 'ٹھنڈک کا طریقہ',
          'air_temp': 'ہوا کا درجہ حرارت',
          'rel_humidity': 'ہوا میں نمی',
          'wind_speed': 'ہوا کی رفتار',
          'apparent_heat': 'محسوس ہونے والی گرمی',
          'hourly_progression': '24 گھنٹے کی حرارتی پیش رفت',
          'hourly_curve': 'گھنٹہ وار UTCI کریو',

          // City Selector Sheet
          'select_city_title': 'شہر یا خطہ منتخب کریں',
          'select_city_sub': 'عالمی جیوکوڈنگ اور ہائپر لوکل GPS نظام',
          'use_exact_gps': 'درست GPS لوکیشن اور جیو فینس استعمال کریں',
          'gps_locating': 'ہائی ایکوریسی GPS اور علاقہ معلوم کیا جا رہا ہے...',
          'gps_detected': 'حقیقی شہر، خطرے کا دائرہ اور مقامی آواز خودکار طور پر سیٹ کرتا ہے',
          'search_worldwide_hint':
              'دنیا کا کوئی بھی شہر تلاش کریں (جیسے لاہور، قاہرہ، ریاض، میڈرڈ)...',
          'featured_hubs': 'نمایاں عالمی مراکز',
          'search_results': 'تلاش کے نتائج',
          'locations_count': 'مقامات',
          'no_cities_found': 'کوئی شہر نہیں ملا۔ دوسرا نام تلاش کریں۔',

          'settings_title': 'ترتیبات اور پروفائل',
          'active_profile': 'فعال صارف پروفائل',
          'active_profile_desc':
              'الرٹس کے لہجے اور رہنمائی کو اپنے مطابق ڈھالنے کے لیے پروفائل منتخب کریں۔',
          'voice_tts': 'وائس انجن (TTS)',
          'voice_tts_desc':
              'ڈیوائس پر کام کرنے والا اسپیچ سنتیسائزر۔ بائیک یا کام کے دوران آواز سنیں۔',
          'test_voice': 'آواز چیک کریں',
          'speech_speed': 'بولنے کی رفتار',
          'voice_pitch': 'آواز کی پچ',
          'alert_threshold': 'الرٹ ٹرگر تھریشولڈ',
          'alert_threshold_desc':
              'مقامی انڈیکس حد سے بڑھے تو آڈیو اور بینر سے فوری آگاہ کریں۔',
          'about_title': 'UTCI Alert اور سائنسی بنیاد کے بارے میں',
          'about_desc':
              'انٹیکویا فلٹر انٹرنشپ پروگرام · انوویشن اسپرنٹ\nمصنف: منصور احمد\nورژن: 1.0 پروڈکشن ایڈیشن',
          'scientific_refs': 'سائنسی مراجع اور ڈیٹا سورسز:',
          'ref_era5_title': 'ERA5-HEAT عالمی ری اینالیسس (1974–2023)',
          'ref_era5_desc':
              '50 سالہ 0.25°x0.25° گرڈ بائیو کلائمیٹک ہیٹ انڈیکس ڈیٹا بیس۔',
          'ref_african_title': 'شہری ہیٹ ویوز کا مطالعہ',
          'ref_african_desc':
              'اسکندریہ، الجزائر، تیونس، کانو، اور ڈاکار میں شدید گرمی میں اضافہ۔',
          'ref_chews_title': 'کمیونٹی ہیٹ ارلی وارننگ (نائجیریا)',
          'ref_chews_desc':
              'کمیونٹی پر مبنی ہیٹ ارلی وارننگ سسٹم کا بینچ مارک۔',

          'guidance_title': 'حفاظتی ٹول کٹ',
          'guidance_for': 'خصوصی رہنمائی برائے',
          'hydration_guard': 'ہائیڈریشن گارڈ',
          'hydration_reset': 'دوبارہ شروع',
          'goal_suffix': 'ہدف',
          'add_glass': '+250ml گلاس',
          'add_bottle': '+500ml بوتل',
          'shift_checklist': 'گرمی سے نمٹنے کی تیاری',
          'listen': 'سنیں',
          'emergency_triage': 'ہیٹ اسٹروک ایمرجنسی طبی امداد',
          'heat_exhaustion': 'گرمی سے بے حالی',
          'heat_exhaustion_s1': '• ٹھنڈی، پیلی، چپچپی جلد',
          'heat_exhaustion_s2': '• بہت زیادہ پسینہ',
          'heat_exhaustion_s3': '• چکر اور متلی',
          'heat_exhaustion_action':
              'اقدام: سایے میں جائیں، کپڑے ڈھیلے کریں، ٹھنڈا پانی پیئیں۔',
          'heatstroke_critical': 'ہیٹ اسٹروک (انتہائی خطرناک)',
          'heatstroke_s1': '• جسمانی درجہ حرارت > 40°C',
          'heatstroke_s2': '• گرم، سرخ جلد',
          'heatstroke_s3': '• الجھن یا بے ہوشی',
          'heatstroke_action': 'اقدام: 115 پر کال کریں! ٹھنڈے پانی سے نہلائیں۔',
          'cooling_guide': 'بستیوں کے لیے ٹھنڈک کے طریقے',
          'cooling_guide_desc':
              'بغیر بجلی کی ٹیکنیک جو کچی بستیوں کے لیے ڈیزائن کی گئی ہے',
          'tip_jute_title': 'کھڑکی پر گیلا ٹاٹ کا پردہ',
          'tip_jute_desc':
              'کھلی کھڑکیوں پر گیلا بوری کا کپڑا لٹکائیں؛ گزرنے والی ہوا 3 سے 5 ڈگری ٹھنڈی ہو جاتی ہے۔',
          'tip_whitewash_title': 'ٹن کی چھتوں پر چونے کا لیپ',
          'tip_whitewash_desc':
              'سفید چونے کا لیپ 75 فیصد دھوپ واپس منعکس کرتا ہے، جس سے کمرہ تندور بننے سے بچتا ہے۔',
          'tip_flushing_title': 'رات کے وقت کراس وینٹیلیشن',
          'tip_flushing_desc':
              'غروب آفتاب کے بعد مخالف روشن دان کھولیں تاکہ دیواروں میں قید گرمی باہر نکل جائے۔',

          'ai_advisor_title': 'AI حرارتی سلامتی مشیر',
          'ai_thinking': 'AI بائیو-میٹرولوجیکل ماڈل سے مشورہ...',
          'ai_label': 'AI حرارت مشیر',
          'ai_hint': 'حرارتی سلامتی کے بارے میں پوچھیں...',
          'stop': 'روکیں',
          'forecast_title': '7 روزہ UTCI پیش گوئی',
          'forecast_sub': 'حیاتیاتی موسمیاتی تخمینہ',
          'hourly_timeline_title': 'گھنٹہ وار UTCI ٹائم لائن (24 گھنٹے)',
          'hourly_timeline_desc': 'ہر گھنٹے کا جسمانی حرارتی دباؤ',
          'forecast_7day_title': '7 روزہ ہیٹ ویو رسک ریڈار',
          'forecast_7day_badge': 'ERA5-HEAT ماڈل',
          'forecast_7day_desc': 'کئی دن کی طویل گرمی کی لہروں کا پتہ لگاتا ہے',
          'heatwave_label': 'گرمی کی لہر',
          'normal_label': 'معمول',
          'high_sweat_barrier': 'پسینے کی زیادہ رکاوٹ',
          'normal_sweat_rate': 'پسینے کی معمول کی شرح',
          'direct_solar_radiance': 'براہ راست شمسی تابکاری',
          'airflow_suffix': 'ہوا کا بہاؤ',

          // Heat Stress Category Labels
          'heat_stress_no_stress': 'گرمی کا کوئی دباؤ نہیں',
          'heat_stress_moderate': 'معتدل گرمی کا دباؤ',
          'heat_stress_strong': 'تیز گرمی کا دباؤ',
          'heat_stress_very_strong': 'بہت شدید گرمی کا دباؤ',
          'heat_stress_extreme': 'انتہائی خطرناک گرمی کا دباؤ',
          'heat_stress_cold_stress': 'سردی کا دباؤ',
          'heat_stress_unknown': 'نامعلوم',

          // UTCI Gauge
          'utci_equivalent': 'یو ٹی سی آئی مساوی',

          // Weather Descriptions
          'weather_clear_sky': 'صاف آسمان',
          'weather_partly_cloudy': 'جزوی طور پر ابر آلود',
          'weather_overcast': 'مکمل ابر آلود',
          'weather_haze_dust': 'دھند / غبار',
          'weather_light_drizzle': 'ہلکی بونداباندی',
          'weather_rain_shower': 'بارش کی پھوار',
          'weather_heavy_rain': 'تیز بارش',
          'weather_thunderstorm': 'گرج چمک کے ساتھ طوفان',
          'weather_sunny_clear': 'دھوپ / صاف',

          // Geofence Dialog & Badges
          'geofence_alert': 'جغرافیائی الرٹ',
          'geofence_safe_perimeter': 'محفوظ حدود',
          'geofence_gps_coordinates': 'جی پی ایس کوآرڈینیٹس',
          'geofence_radius': 'حدود کا رداس',
          'geofence_perimeter_suffix': 'احاطہ',
          'geofence_distance_center': 'مرکز سے فاصلہ',
          'geofence_danger_threshold': 'خطرے کی حد',
          'geofence_rescan_btn': 'مقام اور حدود کو دوبارہ اسکین کریں',
          'geofence_standard_perimeter': 'معیاری تھرمل حدود',
          'geofence_standard_summary':
              'معمول کی تھرمل حدود۔ گرمی کا کوئی انتباہ فعال نہیں ہے۔',
          'geofence_zone_danger': '@city شدید گرمی کی حدود',
          'geofence_zone_regional': '@city علاقائی گرمی کی لہر',
          'geofence_zone_safe': '@city محفوظ تھرمل حدود',
          'geofence_critical_active':
              'اہم انتباہ فعال: آپ کا مقام (@lat, @lon) خطرناک حدود (@radius کلومیٹر) میں ہے جہاں UTCI (@utci°C) حد سے زیادہ ہے۔',
          'geofence_regional_heatwave':
              'علاقائی گرمی کی لہر درج (@utci°C UTCI)۔ مرکز سے فاصلہ: @dist کلومیٹر۔',
          'geofence_safe_zone':
              'آپ محفوظ زون میں ہیں۔ مقامی درجہ حرارت @utci°C خطرے کی حد سے بہت کم ہے۔',

          // Audio Player Bar & Tooltips
          'voice_readout': 'صوتی معلومات',
          'on_device_audio': 'ڈیوائس آڈیو',
          'stop_speaking': 'آواز بند کریں',
          'listen_in_lang': '@lang میں سنیں',

          // Forecast Screen Additions
          'temp_label': 'درجہ حرارت',
          'humidity_label': 'نمی',
          'max_label': 'زیادہ سے زیادہ',
          'min_label': 'کم سے کم',
          'danger_badge': 'خطرہ',
          'listen_forecast_tooltip': 'پیش گوئی سنیں',
          'refresh_forecast_tooltip': 'پیش گوئی تازہ کریں',
          'today': 'آج',
          'day_mon': 'پیر',
          'day_tue': 'منگل',
          'day_wed': 'بدھ',
          'day_thu': 'جمعرات',
          'day_fri': 'جمعہ',
          'day_sat': 'ہفتہ',
          'day_sun': 'اتوار',
          'safe_work_rec_peak':
              '@danger کے درمیان خطرناک گرمی کی توقع ہے۔ بیرونی کام صبح (@morning) یا شام (@evening) میں کریں۔',
          'safe_work_rec_default':
              'سخت فیلڈ یا ڈیلیوری کے کام صبح سویرے یا شام کو انجام دیں۔',

          // AI Advisor Quick Prompts
          'prompt_hydration': '💧 ہر گھنٹے پانی کا منصوبہ',
          'prompt_work_rest': '⏱️ کام اور آرام کا تناسب',
          'prompt_exhaustion_stroke': '⚠️ ہیٹ ایگزاسشن بمقابلہ ہیٹ اسٹروک',
          'prompt_rider_gear': '🛵 رائیڈر کا ہیلمٹ اور سڑک کی تپش',
          'prompt_cool_roof': '🏠 بغیر اے سی چھت ٹھنڈی رکھنا',
          'prompt_harvesting': '🌾 فصل کی کٹائی کے محفوظ اوقات',

          // Guidance Checklist Items
          'check_ow_c1_title': '2.5 لیٹر صاف پانی کا برتن تیار رکھیں',
          'check_ow_c1_desc':
              'کام کی جگہ سے 2 منٹ کے فاصلے پر ٹھنڈا پانی موجود ہونا چاہیے۔',
          'check_ow_c2_title': 'چوڑی ٹوپی یا گردن پر کپڑا',
          'check_ow_c2_desc':
              'ہیلمٹ کے نیچے گیلا کپڑا رکھیں یا دھوپ سے بچاؤ والی ٹوپی پہنیں۔',
          'check_ow_c3_title': 'سائے کا انتظام پہلے سے تلاش کریں',
          'check_ow_c3_desc':
              'ہر گھنٹے بعد 15 منٹ آرام کے لیے ہوادار سائے کی جگہ منتخب کریں۔',
          'check_ow_c4_title': 'ساتھی کی نگرانی کا نظام',
          'check_ow_c4_desc':
              'اپنے ساتھی کے ساتھ مل کر کام کریں تاکہ چکر آنے یا متلی پر فوراً مدد مل سکے۔',

          'check_dr_r1_title': 'ہیلمٹ کا شیشہ اور وینٹ کھولیں',
          'check_dr_r1_desc':
              'ہیلمٹ کے اندر شدید گرمی سے بچنے کے لیے شیشہ ایک درجہ کھلا رکھیں۔',
          'check_dr_r2_title': 'گردن پر گیلا رومال یا کپڑا',
          'check_dr_r2_desc':
              'سفر شروع کرنے سے پہلے رومال گیلا کر لیں تاکہ ہوا سے ٹھنڈک ملے۔',
          'check_dr_r3_title': 'ٹھنڈے پانی کی بوتل ساتھ رکھیں',
          'check_dr_r3_desc':
              'ٹھنڈا پانی پیئیں، انرجی ڈرنکس سے پرہیز کریں جو گردوں پر دباؤ ڈالتی ہیں۔',
          'check_dr_r4_title': 'موٹر سائیکل سائے میں پارک کریں',
          'check_dr_r4_desc':
              'آرڈر لینے کے دوران موٹر سائیکل درخت یا شیڈ کے نیچے کھڑی کریں۔',

          'check_fm_f1_title': 'صبح سویرے کام مکمل کریں',
          'check_fm_f1_desc':
              'کھیتوں کی کٹائی اور ہل چلانے کا کام صبح 10:30 بجے سے پہلے ختم کریں۔',
          'check_fm_f2_title': 'مویشیوں کے لیے سایہ اور پانی',
          'check_fm_f2_desc':
              'جانوروں کے باڑوں میں گہرا سایہ اور وافر پانی کا انتظام یقینی بنائیں۔',
          'check_fm_f3_title': 'ڈھیلے سوتی پورے آستین والے کپڑے',
          'check_fm_f3_desc':
              'دھوپ کی تیز شعاعوں سے بازوؤں کو بچائیں اور ہوا کا گزر برقرار رکھیں۔',
          'check_fm_f4_title': 'دوپہر کے وقت کھلے کھیت سے واپسی',
          'check_fm_f4_desc':
              'صبح 11:30 سے سہ پہر 3:30 تک کھلے کھیت میں سخت مشقت نہ کریں۔',

          'check_ir_i1_title': 'کھڑکیوں پر گیلے ٹاٹ یا بوریاں لٹکائیں',
          'check_ir_i1_desc':
              'کھڑکیوں پر گیلی بوریوں سے آنے والی ہوا کا درجہ حرارت 3 سے 4 ڈگری کم ہو جاتا ہے۔',
          'check_ir_i2_title': 'چھت کے اونچے وینٹی لیٹرز کھلے رکھیں',
          'check_ir_i2_desc':
              'گرم ہوا اوپر اٹھ کر وینٹی لیٹر سے باہر نکل سکے گی۔',
          'check_ir_i3_title': 'علاقے کے ٹھنڈے سائے کی معلومات',
          'check_ir_i3_desc':
              'قریبی بڑے درخت یا کمیونٹی شیڈ کی جگہ کا علم رکھیں۔',
          'check_ir_i4_title': 'مٹکے کا ٹھنڈا پانی استعمال کریں',
          'check_ir_i4_desc':
              'قدرتی ٹھنڈک اور صحت کے لیے پانی مٹی کے برتنوں میں محفوظ کریں۔',

          'check_vn_v1_title': 'گھر کے سب سے ٹھنڈے نچلے کمرے میں رہیں',
          'check_vn_v1_desc':
              'گھر کے گراؤنڈ فلور والے کمرے میں وقت گزاریں جہاں گرمی کم ہو۔',
          'check_vn_v2_title': 'ٹھنڈے پانی میں پاؤں ڈبونا',
          'check_vn_v2_desc':
              'پاؤں کو ٹھنڈے پانی میں رکھنے سے جسم کا اندرونی درجہ حرارت تیزی سے گرتا ہے۔',
          'check_vn_v3_title': 'ہر گھنٹے ایک گلاس پانی کا شیڈول',
          'check_vn_v3_desc':
              'پیاس نہ بھی ہو تب بھی ہر گھنٹے بعد ایک گلاس پانی ضرور پیئیں۔',
          'check_vn_v4_title': 'ہنگامی فون نمبر تیار رکھیں',
          'check_vn_v4_desc':
              'قریبی ڈاکٹر، ہیلتھ ورکر یا پڑوسی کا نمبر فوری رسائی میں رکھیں۔',

          'emergency_first_aid_speech':
              'ہیٹ اسٹروک ایمرجنسی پروٹوکول: مریض کو فوری گہرے سائے میں منتقل کریں۔ سیدھا لٹائیں اور پاؤں 30 سینٹی میٹر اونچے کریں۔ جسم پر ٹھنڈا پانی ڈالیں یا گیلے تولیے رکھیں۔ فوری ایمرجنسی سروسز کو کال کریں۔ بے ہوشی کی حالت میں پانی نہ پلائیں۔',
        },

        // ── Swahili ──────────────────────────────────────────────────────────
        'sw_KE': {
          'app_name': 'UTCI Arifa',
          'app_subtitle': 'Jua joto kabla halijui wewe',
          'select_profile': 'Chagua wasifu wako',
          'select_profile_desc':
              'Arifa, ratiba za kupumzika, na vidokezo vya AI vinavyobadilika kulingana na mazingira yako',
          'enter_dashboard': 'Ingia Dashibodi ya Joto',
          'sign_in_google': 'Ingia kwa Google',

          // Roles
          'role_outdoor_worker': 'Mfanyakazi wa Nje',
          'role_outdoor_worker_desc':
              'Wafanyakazi wa ujenzi, wachuuzi na vibarua juani',
          'role_delivery_rider': 'Mwendesha Pikipiki',
          'role_delivery_rider_desc':
              'Wajumbe wa pikipiki na baiskeli wanaokabiliwa na joto la lami',
          'role_farmer': 'Mkulima',
          'role_farmer_desc':
              'Wafanyakazi wa kilimo wanaovuna mazao na mifugo kwenye joto kali',
          'role_informal_resident': 'Mkazi wa Makazi Duni',
          'role_informal_resident_desc':
              'Wakazi katika maeneo yenye paa za mabati na kivuli kidogo',
          'role_vulnerable': 'Wazee & Walio Hatarini',
          'role_vulnerable_desc':
              'Watu walio na shinikizo la damu, matatizo ya kupumua, watoto na wazee',

          'nav_radar': 'Rada',
          'nav_forecast': 'Utabiri',
          'nav_ai': 'Mshauri AI',
          'nav_toolkit': 'Zana',
          'nav_settings': 'Mipangilio',
          'nav_ai_copilot': 'Msaidizi AI',

          'dashboard_title': 'Dashibodi ya Joto',
          'choose_language': 'Chagua Lugha ya Arifa na Sauti',
          'choose_language_desc':
              'Maonyo, ushauri wa AI na usomaji wa sauti vitabadilika kwa lugha hii.',
          'switch_profile': 'Badilisha Wasifu wa Hatari',
          'switch_profile_desc':
              'Inabainisha mzunguko wa kazi-mapumziko na malengo ya maji kulingana na hali yako.',
          'city_region': 'Mji / Mkoa',
          'search_city_hint': 'Tafuta mji au mkoa...',
          'gps_location': 'Tumia Mahali pa GPS',
          'refresh': 'Onyesha Upya',
          'utci_index': 'Kiwango cha UTCI',
          'heat_stress': 'Msongo wa Joto',
          'ai_advice': 'Ushauri wa AI',
          'read_aloud': 'Soma kwa Sauti',
          'safe_work_windows': 'Nyakati Salama za Kufanya Kazi',
          'morning_window': 'Wakati wa Asubuhi',
          'danger_window': 'Wakati wa Hatari',
          'evening_window': 'Wakati wa Jioni',
          'status_safe_moderate': 'Salama / Wastani',
          'status_very_strong': 'Kali Sana',
          'status_recommended': 'Inapendekezwa',
          'radar_title': 'RADA YA STAREHE YA JOTO',
          'radar_subtitle': 'Kiwango cha Kimataifa cha Hali ya Hewa (UTCI)',
          'radar_desc': 'Inachanganya joto, mionzi ya jua, unyevu na upepo',
          'voice_label': 'Sauti',
          'live_hazard_advisory': 'Tahadhari ya Hatari Moja kwa Moja',
          'deep_shade_mandatory': 'Kivuli Kikubwa ni Lazima',
          'chip_rest_extreme': 'Dakika 15 Kazi / 45 Mapumziko',
          'chip_rest_normal': 'Dakika 45 Kazi / 15 Mapumziko',
          'chip_water_extreme': 'Lita 1.0 / saa',
          'chip_water_normal': '500–750ml / saa',
          'ai_safety_plan': 'Mpango wa Usalama wa AI',
          'instant_field_protocol': 'Mwongozo wa Papo Hapo wa Eneo',
          'work_rest_label': 'Kazi / Mapumziko',
          'hydration_label': 'Unyevu wa Maji',
          'field_action_label': 'Hatua ya Eneo',
          'cooling_method_label': 'Njia ya Kupoa',
          'air_temp': 'Joto la Hewa',
          'rel_humidity': 'Unyevu Husika',
          'wind_speed': 'Kasi ya Upepo',
          'apparent_heat': 'Joto Linalohisiwa',
          'hourly_progression': 'Mwenendo wa Joto wa Saa 24',
          'hourly_curve': 'Mstari wa Saa wa UTCI',

          // City Selector Sheet
          'select_city_title': 'Chagua Mji au Mkoa',
          'select_city_sub': 'Upimaji wa Kijiografia na GPS Sahihi',
          'use_exact_gps': 'Tumia Mahali Halisi pa GPS & Geofence',
          'gps_locating': 'Inatafuta GPS na eneo kwa usahihi wa juu...',
          'gps_detected': 'Inatambua mji halisi, eneo la hatari na sauti ya asili',
          'search_worldwide_hint':
              'Tafuta mji wowote duniani (mfano Cairo, Riyadh, Nairobi, Madrid)...',
          'featured_hubs': 'Vituo Maarufu Duniani',
          'search_results': 'Matokeo ya Utafutaji',
          'locations_count': 'maeneo',
          'no_cities_found': 'Hakuna miji iliyopatikana. Jaribu jina lingine.',

          'settings_title': 'Mipangilio & Wasifu',
          'active_profile': 'Wasifu wa Mtumiaji Uliowashwa',
          'active_profile_desc':
              'Chagua wasifu wako ili kubadilisha kiotomatiki ujumbe wa arifa, sauti, na mwongozo.',
          'voice_tts': 'Injini ya Sauti (TTS)',
          'voice_tts_desc':
              'Kizalisha sauti kwenye kifaa. Inaruhusu arifa za sauti bila mikono.',
          'test_voice': 'Jaribu Sauti',
          'speech_speed': 'Kasi ya Usemi',
          'voice_pitch': 'Mwinuko wa Sauti',
          'alert_threshold': 'Kiwango cha Kutoa Arifa',
          'alert_threshold_desc':
              'Toa arifa ya sauti joto la ndani linapozidi kikomo hiki.',
          'about_title': 'Kuhusu UTCI Alert & Msingi wa Kisayansi',
          'about_desc':
              'Programu ya Intechvia Flutter Internship · Innovation Sprint\nMwandishi: Mansoor Ahmed\nToleo: 1.0 Uzalishaji',
          'scientific_refs': 'Marejeleo ya Kisayansi & Vyanzo vya Data:',
          'ref_era5_title': 'Uchambuzi wa Kimataifa wa ERA5-HEAT (1974–2023)',
          'ref_era5_desc':
              'Uchambuzi wa miaka 50 wa kiwango cha joto cha kibayolojia cha 0.25°x0.25°.',
          'ref_african_title': 'Utafiti wa Mawimbi ya Joto Mijini Afrika',
          'ref_african_desc':
              'Ongezeko maradufu la joto kali kote Alexandria, Algiers, Tunis, Kano, Dakar.',
          'ref_chews_title': 'Tahadhari ya Mapema ya Jamii CHEWS (Nigeria)',
          'ref_chews_desc':
              'Kigezo cha mfumo wa tahadhari ya joto unaozingatia jamii.',

          'guidance_title': 'Sanduku la Ulinzi',
          'guidance_for': 'Imebinafsishwa kwa',
          'hydration_guard': 'Mlinda Unyevu',
          'hydration_reset': 'Weka Upya',
          'goal_suffix': 'lengo',
          'add_glass': '+250ml Glasi',
          'add_bottle': '+500ml Chupa',
          'shift_checklist': 'Utayari wa Zamu kwa Joto',
          'listen': 'Sikiliza',
          'emergency_triage': 'Huduma ya Dharura ya Kiharusi cha Joto',
          'heat_exhaustion': 'Uchovu wa Joto',
          'heat_exhaustion_s1': '• Ngozi baridi, rangi ya kawaida, yenye unyevu',
          'heat_exhaustion_s2': '• Kutoka jasho jingi',
          'heat_exhaustion_s3': '• Kizunguzungu na kichefuchefu',
          'heat_exhaustion_action':
              'Hatua: Nenda kivulini, legeza nguo, kunywa maji baridi.',
          'heatstroke_critical': 'Kiharusi cha Joto (HATARI)',
          'heatstroke_s1': '• Joto la mwili > 40°C',
          'heatstroke_s2': '• Ngozi nyekundu, moto',
          'heatstroke_s3': '• Mkanganyiko au kuzungumza upuuzi',
          'heatstroke_action': 'Hatua: Piga simu 112! Mwagika maji baridi.',
          'cooling_guide': 'Mbinu za Kupoa kwa Makazi Duni',
          'cooling_guide_desc':
              'Mbinu zisizo na umeme zilizoundwa kwa uhalisia wa makazi duni',
          'tip_jute_title': 'Pazia la Gunia Bichi Dirishani',
          'tip_jute_desc':
              'Tundika gunia lenye unyevu dirishani; hewa inayoingia hupoa kwa nyuzi 3-5°C.',
          'tip_whitewash_title': 'Kupaka Chokaa Paa za Mabati',
          'tip_whitewash_desc':
              'Chokaa nyeupe hurudisha asilimia 75 ya joto la jua, kuzuia nyumba kuwa jiko.',
          'tip_flushing_title': 'Kuingiza Hewa Usiku',
          'tip_flushing_desc':
              'Fungua madirisha mkabala jua linapozama ili kutoa joto lililohifadhiwa kuta na bati.',

          'ai_advisor_title': 'Mshauri wa Usalama wa Joto wa AI',
          'ai_thinking': 'Kushauriana na Mfano wa AI...',
          'ai_label': 'Mshauri wa Joto AI',
          'ai_hint': 'Uliza ushauri wa usalama wa joto...',
          'stop': 'Simama',
          'forecast_title': 'Utabiri wa Siku 7 UTCI',
          'forecast_sub': 'Makadirio ya Kibayolojia',
          'hourly_timeline_title': 'Ratiba ya UTCI kwa Saa (Saa 24)',
          'hourly_timeline_desc': 'Msongo wa joto wa kisaikolojia uliohesabiwa kwa kila saa',
          'forecast_7day_title': 'Rada ya Hatari ya Wimbi la Joto la Siku 7',
          'forecast_7day_badge': 'Mfano ERA5-HEAT',
          'forecast_7day_desc': 'Hugundua vipindi vya joto vya siku nyingi',
          'heatwave_label': 'WIMBI LA JOTO',
          'normal_label': 'Kawaida',
          'high_sweat_barrier': 'Kizuizi cha jasho nyingi',
          'normal_sweat_rate': 'Kiwango cha kawaida cha jasho',
          'direct_solar_radiance': 'Mwanga wa jua wa moja kwa moja',
          'airflow_suffix': 'mtiririko wa hewa',

          // Heat Stress Category Labels
          'heat_stress_no_stress': 'Hakuna Msongo wa Joto',
          'heat_stress_moderate': 'Msongo wa Joto wa Wastani',
          'heat_stress_strong': 'Msongo Mkubwa wa Joto',
          'heat_stress_very_strong': 'Msongo Mkali Sana wa Joto',
          'heat_stress_extreme': 'Msongo Uliokithiri wa Joto',
          'heat_stress_cold_stress': 'Msongo wa Baridi',
          'heat_stress_unknown': 'Haijulikani',

          // UTCI Gauge
          'utci_equivalent': 'Kipimo Sawa cha UTCI',

          // Weather Descriptions
          'weather_clear_sky': 'Bawaba Safi',
          'weather_partly_cloudy': 'Mawingu Kiasi',
          'weather_overcast': 'Mawingu Mazito',
          'weather_haze_dust': 'Ukungu / Vumbi',
          'weather_light_drizzle': 'Manyunyu Mepesi',
          'weather_rain_shower': 'Mvua ya Vipindi',
          'weather_heavy_rain': 'Mvua Kubwa',
          'weather_thunderstorm': 'Dhoruba ya Radi',
          'weather_sunny_clear': 'Jua Kali / Safi',

          // Geofence Dialog & Badges
          'geofence_alert': 'TAHADHARI YA ENEO',
          'geofence_safe_perimeter': 'ENEO SALAMA',
          'geofence_gps_coordinates': 'Kuratibu za GPS',
          'geofence_radius': 'Kipenyo cha Eneo',
          'geofence_perimeter_suffix': 'Mzingo',
          'geofence_distance_center': 'Umbali hadi Kituo',
          'geofence_danger_threshold': 'Kiwango cha Hatari',
          'geofence_rescan_btn': 'Chunguza Tena Eneo na Mzingo',
          'geofence_standard_perimeter': 'Mzingo wa Kawaida wa Joto',
          'geofence_standard_summary':
              'Mipaka ya kawaida ya joto. Hakuna tahadhari ya joto inayotumika.',
          'geofence_zone_danger': 'Eneo la Joto Kali @city',
          'geofence_zone_regional': 'Wimbi la Joto la Kikanda @city',
          'geofence_zone_safe': 'Mzingo Salama wa Joto @city',
          'geofence_critical_active':
              'TAHADHARI INAFANYA KAZI: Eneo lako (@lat, @lon) lipo ndani ya hatari ya km @radius ambapo UTCI (@utci°C) inazidi kiwango cha usalama.',
          'geofence_regional_heatwave':
              'Wimbi la joto la kikanda limegunduliwa (@utci°C UTCI). Umbali hadi kituo: km @dist.',
          'geofence_safe_zone':
              'Uko katika eneo salama la hali ya hewa. UTCI ya hapa ni @utci°C (chini ya kiwango cha hatari 38°C).',

          // Audio Player Bar & Tooltips
          'voice_readout': 'USOMAJI WA SAUTI',
          'on_device_audio': 'Sauti ya Kifaa',
          'stop_speaking': 'Acha kuongea',
          'listen_in_lang': 'Sikiliza kwa @lang',

          // Forecast Screen Additions
          'temp_label': 'Joto',
          'humidity_label': 'Unyevu',
          'max_label': 'Kiwango cha Juu',
          'min_label': 'Kiwango cha Chini',
          'danger_badge': 'HATARI',
          'listen_forecast_tooltip': 'Sikiliza utabiri',
          'refresh_forecast_tooltip': 'Onyesha upya utabiri',
          'today': 'Leo',
          'day_mon': 'Jtatu',
          'day_tue': 'Jnne',
          'day_wed': 'Jtano',
          'day_thu': 'Alh',
          'day_fri': 'Ijumaa',
          'day_sat': 'Jmosi',
          'day_sun': 'Jpili',
          'safe_work_rec_peak':
              'Kiwango cha juu cha joto kinatarajiwa kati ya @danger. Hamisha kazi za nje asubuhi (@morning) au jioni (@evening).',
          'safe_work_rec_default':
              'Fanya kazi nzito za shambani au za uwasilishaji asubuhi na mapema au alasiri.',

          // AI Advisor Quick Prompts
          'prompt_hydration': '💧 Mpango wa maji kila saa',
          'prompt_work_rest': '⏱️ Uwiano wa kazi na mapumziko',
          'prompt_exhaustion_stroke': '⚠️ Uchovu vs Kiharusi cha Joto',
          'prompt_rider_gear': '🛵 Kofia ya mpanda pikipiki na lami',
          'prompt_cool_roof': '🏠 Paa yenye ubaridi bila AC',
          'prompt_harvesting': '🌾 Zamu salama ya kuvuna',

          // Guidance Checklist Items
          'check_ow_c1_title': 'Tengeneza Chupa ya Maji ya Lita 2.5',
          'check_ow_c1_desc':
              'Hakikisha maji safi ya baridi yapo ndani ya dakika 2 kutoka eneo lako la kazi.',
          'check_ow_c2_title': 'Kofia Pana au Kinga ya Shingo',
          'check_ow_c2_desc':
              'Tandika kitambaa chenye unyevu chini ya kofia ngumu au vaa kofia pana.',
          'check_ow_c3_title': 'Kivuli Kilichotambuliwa',
          'check_ow_c3_desc':
              'Tafuta eneo lenye kivuli na hewa safi kwa ajili ya mapumziko ya dakika 15 kila saa.',
          'check_ow_c4_title': 'Mfumo wa Kuchungana Kazini',
          'check_ow_c4_desc':
              'Kubaliana na mfanyakazi mwenzako kuchungana dalili za kizunguzungu au kuchanganyikiwa.',

          'check_dr_r1_title': 'Safi Kioo na Fungua Matundu ya Kofia',
          'check_dr_r1_desc':
              'Acha kioo kikiwa wazi kidogo ili kuzuia joto la 48°C ndani ya kofia.',
          'check_dr_r2_title': 'Kitambaa Chenye Unyevu Shingoni',
          'check_dr_r2_desc':
              'Loweka kitambaa kabla ya kuanza safari kwa ajili ya upepo wa kupoza.',
          'check_dr_r3_title': 'Chupa ya Maji Yenye Bima ya Joto',
          'check_dr_r3_desc':
              'Beba maji baridi; epuka vinywaji vya kuongeza nguvu vinavyochosha figo.',
          'check_dr_r4_title': 'Kuegesha Pikipiki Kwenye Kivuli',
          'check_dr_r4_desc':
              'Egesha chini ya miti unapongoja oda ili kiti kisiwe moto.',

          'check_fm_f1_title': 'Zamu ya Alfajiri Shambani',
          'check_fm_f1_desc':
              'Maliza shughuli za kulima na kuvuna kabla ya saa 4:30 asubuhi.',
          'check_fm_f2_title': 'Kivuli na Maji ya Mifugo',
          'check_fm_f2_desc':
              'Hakikisha mabanda ya mifugo yana kivuli kizito na maji tele.',
          'check_fm_f3_title': 'Nguo za Pamba Mikono Mirefu',
          'check_fm_f3_desc':
              'Kinga mikono yako dhidi ya mionzi mikali ya jua huku hewa ikipita.',
          'check_fm_f4_title': 'Kuondoka Shambani Wakati wa Adhuhuri',
          'check_fm_f4_desc':
              'Ondoka mashambani wazi kati ya saa 5:30 asubuhi na saa 9:30 alasiri.',

          'check_ir_i1_title': 'Pazia la Gunia Bichi Dirishani',
          'check_ir_i1_desc':
              'Maji kwenye magunia ya madirishani hupunguza joto la chumba kwa nyuzi 3-4°C.',
          'check_ir_i2_title': 'Matundu ya Juu ya Paa Wazi',
          'check_ir_i2_desc':
              'Ruhusu hewa moto ipande na kutoka nje kupitia matundu ya paa.',
          'check_ir_i3_title': 'Kivuli cha Jamii',
          'check_ir_i3_desc':
              'Jua eneo la mti mkubwa wa kivuli au kituo cha jamii kilicho baridi.',
          'check_ir_i4_title': 'Kunywa Maji Yaliyochemshwa Katika Mtungi',
          'check_ir_i4_desc':
              'Hifadhi maji safi ya kunywa kwenye mtungi wa udongo ili yapoe kiasili.',

          'check_vn_v1_title': 'Chumba cha Chini Chenye Baridi',
          'check_vn_v1_desc':
              'Kaa katika chumba cha chini kabisa cha nyumba ambapo hewa ni baridi zaidi.',
          'check_vn_v2_title': 'Kuloweka Miguu Kwenye Maji Baridi',
          'check_vn_v2_desc':
              'Kuweka miguu kwenye maji baridi hupunguza haraka joto la ndani la mwili.',
          'check_vn_v3_title': 'Ratiba ya Glasi ya Maji Kila Saa',
          'check_vn_v3_desc':
              'Kunywa 200ml kila saa hata bila kuhisi kiu.',
          'check_vn_v4_title': 'Nambari ya Dharura Karibu',
          'check_vn_v4_desc':
              'Hakikisha nambari ya mhudumu wa afya au jirani inapatikana kwa urahisi.',

          'emergency_first_aid_speech':
              'Mwongozo wa Dharura wa Kiharusi cha Joto: Mhamishe mgonjwa kwenye kivuli kizito mara moja. Mlaze chini na inua miguu sentimita 30. Mwagie maji baridi mwilini au tumia vitambaa vyenye unyevu. Piga simu ya dharura haraka. Usimpe vinywaji akiwa amezirai.',
        },

        // ── French ───────────────────────────────────────────────────────────
        'fr_FR': {
          'app_name': 'UTCI Alerte',
          'app_subtitle': "Connaissez la chaleur avant qu'elle vous connaisse",
          'select_profile': 'Sélectionnez votre profil',
          'select_profile_desc':
              "Les alertes, ratios de repos et conseils IA s'adaptent dynamiquement à votre environnement",
          'enter_dashboard': 'Accéder au Tableau de Bord Thermique',
          'sign_in_google': 'Se connecter avec Google',

          // Roles
          'role_outdoor_worker': 'Travailleur Extérieur',
          'role_outdoor_worker_desc':
              'Ouvriers du BTP, marchands ambulants et travailleurs en plein soleil',
          'role_delivery_rider': 'Livreur',
          'role_delivery_rider_desc':
              'Coursiers moto et vélo exposés à la chaleur du bitume et au casque',
          'role_farmer': 'Agriculteur',
          'role_farmer_desc':
              'Exploitants et ouvriers agricoles lors des récoltes en pleine chaleur',
          'role_informal_resident': 'Habitat Informel',
          'role_informal_resident_desc':
              'Habitants de zones denses sous toits en tôle ondulée et ombre limitée',
          'role_vulnerable': 'Personnes Vulnérables',
          'role_vulnerable_desc':
              'Personnes âgées, enfants ou avec risques cardiorespiratoires',

          'nav_radar': 'Radar',
          'nav_forecast': 'Prévisions',
          'nav_ai': 'Conseiller IA',
          'nav_toolkit': 'Trousse',
          'nav_settings': 'Paramètres',
          'nav_ai_copilot': 'Copilote IA',

          'dashboard_title': 'Tableau de Bord Thermique',
          'choose_language': "Choisir la Langue d'Alerte et Vocale",
          'choose_language_desc':
              "Les avertissements, conseils IA et lectures vocales s'adapteront à cette langue.",
          'switch_profile': 'Changer de Profil de Vulnérabilité',
          'switch_profile_desc':
              'Calibre les cycles travail-repos et les objectifs d\'hydratation à vos réalités terrain.',
          'city_region': 'Ville / Région',
          'search_city_hint': 'Rechercher une ville ou région...',
          'gps_location': 'Utiliser la Position GPS',
          'refresh': 'Actualiser',
          'utci_index': 'Indice UTCI',
          'heat_stress': 'Stress Thermique',
          'ai_advice': 'Conseil IA',
          'read_aloud': 'Lire à Voix Haute',
          'safe_work_windows': 'Plages de Travail Sûres',
          'morning_window': 'Plage Matinale',
          'danger_window': 'Plage Dangereuse',
          'evening_window': 'Plage Soirée',
          'status_safe_moderate': 'Sûr / Modéré',
          'status_very_strong': 'Très Fort',
          'status_recommended': 'Recommandé',
          'radar_title': 'RADAR DE CONFORT THERMIQUE',
          'radar_subtitle': 'Indice Climatique Thermique Universel (UTCI)',
          'radar_desc':
              'Combine température, rayonnement solaire, humidité et vitesse du vent',
          'voice_label': 'Voix',
          'live_hazard_advisory': 'Avis de Danger en Direct',
          'deep_shade_mandatory': 'Ombre Dense Obligatoire',
          'chip_rest_extreme': '15m Travail / 45m Repos',
          'chip_rest_normal': '45m Travail / 15m Repos',
          'chip_water_extreme': '1,0L / heure',
          'chip_water_normal': '500–750ml / heure',
          'ai_safety_plan': 'Plan de Sécurité IA',
          'instant_field_protocol': 'Protocole Terrain Immédiat',
          'work_rest_label': 'Travail / Repos',
          'hydration_label': 'Hydratation',
          'field_action_label': 'Action Terrain',
          'cooling_method_label': 'Méthode de Rafraîchissement',
          'air_temp': 'Température de l\'Air',
          'rel_humidity': 'Humidité Relative',
          'wind_speed': 'Vitesse du Vent',
          'apparent_heat': 'Chaleur Ressentie',
          'hourly_progression': 'Progression Thermique sur 24h',
          'hourly_curve': 'Courbe UTCI Horaire',

          // City Selector Sheet
          'select_city_title': 'Sélectionner Ville ou Région',
          'select_city_sub': 'Géocodage Mondial & GPS Hyperlocal',
          'use_exact_gps': 'Utiliser Position GPS & Périmètre Virtuel',
          'gps_locating': 'Localisation GPS de haute précision en cours...',
          'gps_detected': 'Détecte la ville réelle, le périmètre de danger et la voix',
          'search_worldwide_hint':
              'Rechercher une ville dans le monde (ex: Paris, Dakar, Le Caire, Madrid)...',
          'featured_hubs': 'Centres Mondiaux Vedettes',
          'search_results': 'Résultats de Recherche',
          'locations_count': 'lieux',
          'no_cities_found': 'Aucune ville trouvée. Essayez un autre nom.',

          'settings_title': 'Paramètres & Profil',
          'active_profile': 'Profil Utilisateur Actif',
          'active_profile_desc':
              'Sélectionnez votre profil pour adapter automatiquement les alertes et conseils.',
          'voice_tts': 'Moteur Vocal (TTS)',
          'voice_tts_desc':
              'Synthétiseur de parole sur appareil. Permet des alertes mains libres.',
          'test_voice': 'Tester la Voix',
          'speech_speed': 'Vitesse de Parole',
          'voice_pitch': 'Tonalité Vocale',
          'alert_threshold': "Seuil de Déclenchement d'Alerte",
          'alert_threshold_desc':
              'Notifier par audio quand l\'indice thermique local dépasse cette limite.',
          'about_title': 'À Propos de UTCI Alert & Base Scientifique',
          'about_desc':
              "Programme de Stage Intechvia Flutter · Sprint d'Innovation\nAuteur: Mansoor Ahmed\nVersion: 1.0 Édition Production",
          'scientific_refs': 'Références Scientifiques & Sources de Données:',
          'ref_era5_title': 'Réanalyse Mondiale ERA5-HEAT (1974–2023)',
          'ref_era5_desc':
              'Réanalyse de 50 ans d\'indice thermique bioclimatique à grille 0.25°x0.25°.',
          'ref_african_title': 'Étude des Vagues de Chaleur Urbaines en Afrique',
          'ref_african_desc':
              'Doublement de la chaleur extrême à Alexandrie, Alger, Tunis, Kano, Dakar.',
          'ref_chews_title': 'Alerte Précoce Communautaire CHEWS (Nigeria)',
          'ref_chews_desc':
              'Système d\'alerte précoce canicule centré sur la communauté.',

          'guidance_title': 'Trousse de Protection',
          'guidance_for': 'Personnalisé pour',
          'hydration_guard': "Garde d'Hydratation",
          'hydration_reset': 'Réinitialiser',
          'goal_suffix': 'objectif',
          'add_glass': '+250ml Verre',
          'add_bottle': '+500ml Bouteille',
          'shift_checklist': 'Préparation Chaleur du Quart',
          'listen': 'Écouter',
          'emergency_triage': 'Triage d\'Urgence Insolation',
          'heat_exhaustion': 'Épuisement par la Chaleur',
          'heat_exhaustion_s1': '• Peau froide, pâle et moite',
          'heat_exhaustion_s2': '• Transpiration abondante',
          'heat_exhaustion_s3': '• Vertiges et nausées',
          'heat_exhaustion_action':
              "Action: Aller à l'ombre, desserrer les vêtements, boire de l'eau fraîche.",
          'heatstroke_critical': 'Coup de Chaleur (CRITIQUE)',
          'heatstroke_s1': '• Température centrale > 40°C',
          'heatstroke_s2': '• Peau rouge et chaude',
          'heatstroke_s3': '• Confusion ou délire',
          'heatstroke_action': 'Action: Appelez le 15/112! Arrosez d\'eau froide.',
          'cooling_guide': 'Astuces de Rafraîchissement en Bidonville',
          'cooling_guide_desc':
              'Techniques sans électricité co-conçues pour les réalités des bidonvilles',
          'tip_jute_title': 'Écran de Fenêtre en Toile de Jute Humide',
          'tip_jute_desc':
              'Accrochez de la toile humide aux fenêtres; l\'air traversant baisse de 3 à 5°C.',
          'tip_whitewash_title': 'Badigeon de Chaux sur Toits en Tôle',
          'tip_whitewash_desc':
              'La chaux blanche réfléchit 75% du rayonnement solaire et évite l\'effet fournaise.',
          'tip_flushing_title': 'Ventilation Traversante Nocturne',
          'tip_flushing_desc':
              'Ouvrez les ouvertures opposées après le coucher du soleil pour purger la chaleur.',

          'ai_advisor_title': 'Conseiller IA Sécurité Thermique',
          'ai_thinking': 'Consultation du Modèle IA Biométéorologique...',
          'ai_label': 'Conseiller Chaleur IA',
          'ai_hint': 'Demandez des conseils de sécurité thermique...',
          'stop': 'Arrêter',
          'forecast_title': 'Prévisions UTCI sur 7 Jours',
          'forecast_sub': 'Projections Bioclimatiques',
          'hourly_timeline_title': 'Chronologie UTCI Horaire (24 Heures)',
          'hourly_timeline_desc': 'Stress thermique physiologique calculé par heure',
          'forecast_7day_title': 'Radar Risque de Canicule sur 7 Jours',
          'forecast_7day_badge': 'Modèle ERA5-HEAT',
          'forecast_7day_desc': 'Détecte les épisodes de chaleur prolongés sur plusieurs jours',
          'heatwave_label': 'CANICULE',
          'normal_label': 'Normal',
          'high_sweat_barrier': 'Barrière de transpiration élevée',
          'normal_sweat_rate': 'Taux de transpiration normal',
          'direct_solar_radiance': 'Rayonnement solaire direct',
          'airflow_suffix': "flux d'air",

          // Heat Stress Category Labels
          'heat_stress_no_stress': 'Aucun Stress Thermique',
          'heat_stress_moderate': 'Stress Thermique Modéré',
          'heat_stress_strong': 'Fort Stress Thermique',
          'heat_stress_very_strong': 'Très Fort Stress Thermique',
          'heat_stress_extreme': 'Stress Thermique Extrême',
          'heat_stress_cold_stress': 'Stress Lié au Froid',
          'heat_stress_unknown': 'Inconnu',

          // UTCI Gauge
          'utci_equivalent': 'Équivalent UTCI',

          // Weather Descriptions
          'weather_clear_sky': 'Ciel Dégagé',
          'weather_partly_cloudy': 'Partiellement Nuageux',
          'weather_overcast': 'Couvert',
          'weather_haze_dust': 'Brume / Poussière',
          'weather_light_drizzle': 'Bruine Légère',
          'weather_rain_shower': 'Averses de Pluie',
          'weather_heavy_rain': 'Pluie Forte',
          'weather_thunderstorm': 'Orage',
          'weather_sunny_clear': 'Ensoleillé / Clair',

          // Geofence Dialog & Badges
          'geofence_alert': 'ALERTE GÉOREPÉRAGE',
          'geofence_safe_perimeter': 'PÉRIMÈTRE SÉCURISÉ',
          'geofence_gps_coordinates': 'Coordonnées GPS',
          'geofence_radius': 'Rayon de Géorepérage',
          'geofence_perimeter_suffix': 'Périmètre',
          'geofence_distance_center': 'Distance à l\'Épicentre',
          'geofence_danger_threshold': 'Seuil de Danger',
          'geofence_rescan_btn': 'Réanalyser le Périmètre et la Position',
          'geofence_standard_perimeter': 'Périmètre Thermique Standard',
          'geofence_standard_summary':
              'Limite thermique normale. Aucun déclencheur d\'alerte actif.',
          'geofence_zone_danger': 'Géorepérage Chaleur Sévère @city',
          'geofence_zone_regional': 'Vague de Chaleur Régionale @city',
          'geofence_zone_safe': 'Périmètre Thermique Sûr @city',
          'geofence_critical_active':
              'GÉOREPÉRAGE CRITIQUE ACTIF: Votre position (@lat, @lon) est dans le périmètre à risque de @radius km où l\'UTCI (@utci°C) dépasse le seuil (38°C).',
          'geofence_regional_heatwave':
              'Vague de chaleur régionale détectée (@utci°C UTCI). Distance au centre: @dist km.',
          'geofence_safe_zone':
              'Vous êtes dans une zone biométéorologique sûre. L\'UTCI local est de @utci°C (bien en-dessous du seuil de 38°C).',

          // Audio Player Bar & Tooltips
          'voice_readout': 'LECTURE VOCALE',
          'on_device_audio': 'Audio Embarqué',
          'stop_speaking': 'Arrêter la voix',
          'listen_in_lang': 'Écouter en @lang',

          // Forecast Screen Additions
          'temp_label': 'Temp',
          'humidity_label': 'Humidité',
          'max_label': 'Max',
          'min_label': 'Min',
          'danger_badge': 'DANGER',
          'listen_forecast_tooltip': 'Écouter les prévisions',
          'refresh_forecast_tooltip': 'Actualiser les prévisions',
          'today': 'Aujourd\'hui',
          'day_mon': 'Lun',
          'day_tue': 'Mar',
          'day_wed': 'Mer',
          'day_thu': 'Jeu',
          'day_fri': 'Ven',
          'day_sat': 'Sam',
          'day_sun': 'Dim',
          'safe_work_rec_peak':
              'Pic de chaleur dangereux attendu entre @danger. Décalez le travail extérieur au matin (@morning) ou au soir (@evening).',
          'safe_work_rec_default':
              'Effectuez les tâches lourdes ou livraisons tôt le matin ou en fin d\'après-midi.',

          // AI Advisor Quick Prompts
          'prompt_hydration': '💧 Plan d\'hydratation horaire',
          'prompt_work_rest': '⏱️ Ratio travail/repos',
          'prompt_exhaustion_stroke': '⚠️ Épuisement vs Coup de chaleur',
          'prompt_rider_gear': '🛵 Casque du motard et asphalte',
          'prompt_cool_roof': '🏠 Toit frais sans climatiseur',
          'prompt_harvesting': '🌾 Heures sûres pour la récolte',

          // Guidance Checklist Items
          'check_ow_c1_title': 'Bidon d\'Eau Propre de 2.5L Préparé',
          'check_ow_c1_desc':
              'Avoir de l\'eau fraîche accessible en moins de 2 minutes de votre zone de travail.',
          'check_ow_c2_title': 'Chapeau à Large Bord ou Protège-Nuque',
          'check_ow_c2_desc':
              'Draper un tissu humide sous le casque de chantier ou porter un chapeau à large bord.',
          'check_ow_c3_title': 'Zone Ombragée Identifiée',
          'check_ow_c3_desc':
              'Repérer un abri aéré pour vos pauses de 15 minutes chaque heure.',
          'check_ow_c4_title': 'Système de Surveillance Mutuelle',
          'check_ow_c4_desc':
              'S\'accorder avec un collègue pour surveiller l\'apparition d\'étourdissements ou de propos confus.',

          'check_dr_r1_title': 'Visière Nettoyée et Aération Ouverte',
          'check_dr_r1_desc':
              'Garder la visière entrouverte d\'un cran pour éviter la poche de chaleur à 48°C dans le casque.',
          'check_dr_r2_title': 'Tour de Cou ou Bandana Humide',
          'check_dr_r2_desc':
              'Mouiller le bandana avant le trajet pour un rafraîchissement par convection du vent.',
          'check_dr_r3_title': 'Gourde Isotherme d\'Eau Fraîche',
          'check_dr_r3_desc':
              'Transporter de l\'eau fraîche; éviter les boissons énergisantes qui surchargent les reins.',
          'check_dr_r4_title': 'Stationnement à l\'Ombre aux Hubs',
          'check_dr_r4_desc':
              'Garer la moto sous les arbres entre les courses pour garder la selle fraîche.',

          'check_fm_f1_title': 'Session de Travail Dès l\'Aube',
          'check_fm_f1_desc':
              'Achever les travaux de labour et de récolte avant 10h30.',
          'check_fm_f2_title': 'Abris et Abreuvoirs pour le Bétail',
          'check_fm_f2_desc':
              'Vérifier que les enclos ont une ombre dense et de l\'eau abondante.',
          'check_fm_f3_title': 'Manches Longues en Coton Léger',
          'check_fm_f3_desc':
              'Protéger les bras du rayonnement UV intense tout en assurant la circulation de l\'air.',
          'check_fm_f4_title': 'Évacuation des Champs Ouverts à Midi',
          'check_fm_f4_desc':
              'Quitter les champs ouverts entre 11h30 et 15h30.',

          'check_ir_i1_title': 'Écrans de Fenêtre en Toile de Jute Humide',
          'check_ir_i1_desc':
              'Humidifier la toile de jute aux ouvertures baisse la température de 3 à 4°C.',
          'check_ir_i2_title': 'Aérations Hautes Laissées Ouvertes',
          'check_ir_i2_desc':
              'Laisser l\'air chaud emprisonné monter et s\'échapper par les ouvertures hautes.',
          'check_ir_i3_title': 'Repérage de l\'Ombre Communautaire',
          'check_ir_i3_desc':
              'Localiser le grand arbre ou l\'abri communautaire frais le plus proche.',
          'check_ir_i4_title': 'Boire de l\'Eau Rafraîchie en Jarre d\'Argile',
          'check_ir_i4_desc':
              'Conserver l\'eau potable dans des récipients en terre cuite pour un froid naturel.',

          'check_vn_v1_title': 'Pièce la Plus Fraîche au Rez-de-Chaussée',
          'check_vn_v1_desc':
              'Rester dans la pièce la plus basse de la maison où l\'air est le plus frais.',
          'check_vn_v2_title': 'Bain de Pieds d\'Eau Fraîche',
          'check_vn_v2_desc':
              'Plonger les pieds dans l\'eau fraîche abaisse rapidement la température interne.',
          'check_vn_v3_title': 'Verre d\'Eau Régulier Toutes les Heures',
          'check_vn_v3_desc':
              'Boire 200ml chaque heure même en l\'absence de sensation de soif.',
          'check_vn_v4_title': 'Numéro d\'Urgence Accessible Immédiatement',
          'check_vn_v4_desc':
              'S\'assurer d\'avoir le contact de l\'agent de santé ou d\'un voisin sous la main.',

          'emergency_first_aid_speech':
              'Protocole d\'urgence coup de chaleur: Déplacez la victime à l\'ombre profonde immédiatement. Allongez-la à plat et surélevez les pieds de 30 centimètres. Arrosez son corps d\'eau fraîche ou drapez de linges humides. Appelez les secours d\'urgence immédiatement. Ne donnez pas de liquide si la personne est inconsciente.',
        },

        // ── Spanish ───────────────────────────────────────────────────────────
        'es_ES': {
          'app_name': 'UTCI Alerta',
          'app_subtitle': 'Conoce el calor antes de que te conozca',
          'select_profile': 'Selecciona tu perfil',
          'select_profile_desc':
              'Las alertas, ratios de descanso y consejos de IA se adaptan dinámicamente a tu entorno',
          'enter_dashboard': 'Acceder al Panel Térmico',
          'sign_in_google': 'Iniciar sesión con Google',

          // Roles
          'role_outdoor_worker': 'Trabajador al Aire Libre',
          'role_outdoor_worker_desc':
              'Construcción, vendedores ambulantes y jornaleros expuestos al sol directo',
          'role_delivery_rider': 'Repartidor',
          'role_delivery_rider_desc':
              'Mensajeros en moto y bicicleta frente al calor del asfalto y casco',
          'role_farmer': 'Agricultor',
          'role_farmer_desc':
              'Trabajadores agrícolas cosechando y cuidando ganado en horas pico',
          'role_informal_resident': 'Asentamiento Informal',
          'role_informal_resident_desc':
              'Residentes en áreas densas con techos de chapa y poca sombra',
          'role_vulnerable': 'Adultos Mayores y Vulnerables',
          'role_vulnerable_desc':
              'Personas con hipertensión, riesgos respiratorios, niños y ancianos',

          'nav_radar': 'Radar',
          'nav_forecast': 'Pronóstico',
          'nav_ai': 'Asesor IA',
          'nav_toolkit': 'Kit',
          'nav_settings': 'Ajustes',
          'nav_ai_copilot': 'Copiloto IA',

          'dashboard_title': 'Panel Térmico',
          'choose_language': 'Elegir Idioma de Alerta y Voz',
          'choose_language_desc':
              'Las advertencias, consejos de IA y lecturas de voz se adaptarán a este idioma.',
          'switch_profile': 'Cambiar Perfil de Vulnerabilidad',
          'switch_profile_desc':
              'Calibra los ciclos trabajo-descanso y objetivos de hidratación a tu realidad.',
          'city_region': 'Ciudad / Región',
          'search_city_hint': 'Buscar ciudad o región...',
          'gps_location': 'Usar Ubicación GPS',
          'refresh': 'Actualizar',
          'utci_index': 'Índice UTCI',
          'heat_stress': 'Estrés Térmico',
          'ai_advice': 'Consejo IA',
          'read_aloud': 'Leer en Voz Alta',
          'safe_work_windows': 'Ventanas de Trabajo Seguras',
          'morning_window': 'Ventana Matutina',
          'danger_window': 'Ventana de Peligro',
          'evening_window': 'Ventana Vespertina',
          'status_safe_moderate': 'Seguro / Moderado',
          'status_very_strong': 'Muy Fuerte',
          'status_recommended': 'Recomendado',
          'radar_title': 'RADAR DE CONFORT TÉRMICO',
          'radar_subtitle': 'Índice Climático Térmico Universal (UTCI)',
          'radar_desc':
              'Combina temperatura, radiación solar, humedad y flujo de viento',
          'voice_label': 'Voz',
          'live_hazard_advisory': 'Aviso de Peligro en Vivo',
          'deep_shade_mandatory': 'Sombra Densa Obligatoria',
          'chip_rest_extreme': '15m Trabajo / 45m Descanso',
          'chip_rest_normal': '45m Trabajo / 15m Descanso',
          'chip_water_extreme': '1.0L / hora',
          'chip_water_normal': '500–750ml / hora',
          'ai_safety_plan': 'Plan de Seguridad IA',
          'instant_field_protocol': 'Protocolo de Campo Instantáneo',
          'work_rest_label': 'Trabajo / Descanso',
          'hydration_label': 'Hidratación',
          'field_action_label': 'Acción de Campo',
          'cooling_method_label': 'Método de Enfriamiento',
          'air_temp': 'Temperatura del Aire',
          'rel_humidity': 'Humedad Relativa',
          'wind_speed': 'Velocidad del Viento',
          'apparent_heat': 'Calor Aparente',
          'hourly_progression': 'Progresión Térmica de 24 Horas',
          'hourly_curve': 'Curva Horaria UTCI',

          // City Selector Sheet
          'select_city_title': 'Seleccionar Ciudad o Región',
          'select_city_sub': 'Geocodificación Mundial y GPS Hiperlocal',
          'use_exact_gps': 'Usar Ubicación GPS Exacta y Geovalla',
          'gps_locating': 'Localizando GPS de alta precisión y localidad...',
          'gps_detected': 'Detecta ciudad real, perímetro de peligro y voz nativa',
          'search_worldwide_hint':
              'Buscar cualquier ciudad del mundo (ej: Madrid, Bogotá, Buenos Aires)...',
          'featured_hubs': 'Centros Globales Destacados',
          'search_results': 'Resultados de Búsqueda',
          'locations_count': 'ubicaciones',
          'no_cities_found': 'No se encontraron ciudades. Prueba con otro nombre.',

          'settings_title': 'Ajustes & Perfil',
          'active_profile': 'Perfil de Usuario Activo',
          'active_profile_desc':
              'Selecciona tu perfil para adaptar automáticamente las alertas y orientación.',
          'voice_tts': 'Motor de Voz (TTS)',
          'voice_tts_desc':
              'Sintetizador de voz en el dispositivo. Habilita alertas de manos libres.',
          'test_voice': 'Probar Voz',
          'speech_speed': 'Velocidad de Voz',
          'voice_pitch': 'Tono de Voz',
          'alert_threshold': 'Umbral de Activación de Alerta',
          'alert_threshold_desc':
              'Notificar con audio cuando el índice térmico local supere este límite.',
          'about_title': 'Acerca de UTCI Alert & Base Científica',
          'about_desc':
              'Programa de Prácticas Intechvia Flutter · Sprint de Innovación\nAutor: Mansoor Ahmed\nVersión: 1.0 Edición Producción',
          'scientific_refs': 'Referencias Científicas & Fuentes de Datos:',
          'ref_era5_title': 'Reanálisis Global ERA5-HEAT (1974–2023)',
          'ref_era5_desc':
              'Reanálisis de 50 años del índice térmico bioclimático en cuadrícula de 0.25°x0.25°.',
          'ref_african_title': 'Estudio de Olas de Calor Urbanas en África',
          'ref_african_desc':
              'Duplicación del calor extremo en Alejandría, Argel, Túnez, Kano y Dakar.',
          'ref_chews_title': 'Alerta Temprana Comunitaria CHEWS (Nigeria)',
          'ref_chews_desc':
              'Punto de referencia del sistema comunitario de alerta temprana ante el calor.',

          'guidance_title': 'Kit de Protección',
          'guidance_for': 'Personalizado para',
          'hydration_guard': 'Guardián de Hidratación',
          'hydration_reset': 'Reiniciar',
          'goal_suffix': 'meta',
          'add_glass': '+250ml Vaso',
          'add_bottle': '+500ml Botella',
          'shift_checklist': 'Preparación de Turno para el Calor',
          'listen': 'Escuchar',
          'emergency_triage': 'Triaje de Emergencia por Golpe de Calor',
          'heat_exhaustion': 'Agotamiento por Calor',
          'heat_exhaustion_s1': '• Piel fría, pálida y sudorosa',
          'heat_exhaustion_s2': '• Sudoración intensa',
          'heat_exhaustion_s3': '• Mareos y náuseas',
          'heat_exhaustion_action':
              'Acción: Ir a la sombra, aflojar ropa, tomar agua fresca.',
          'heatstroke_critical': 'Golpe de Calor (CRÍTICO)',
          'heatstroke_s1': '• Temperatura central > 40°C',
          'heatstroke_s2': '• Piel caliente y roja',
          'heatstroke_s3': '• Confusión o delirio',
          'heatstroke_action': 'Acción: ¡Llama al 112! Refrigera con agua fría.',
          'cooling_guide': 'Trucos de Enfriamiento en Asentamientos',
          'cooling_guide_desc':
              'Técnicas sin electricidad co-diseñadas para realidades de asentamientos informales',
          'tip_jute_title': 'Cortina de Yute Húmedo en Ventanas',
          'tip_jute_desc':
              'Cuelga arpillera húmeda en ventanas abiertas; el aire baja entre 3 y 5°C.',
          'tip_whitewash_title': 'Encalado en Techos de Chapa Galvanizada',
          'tip_whitewash_desc':
              'El encalado blanco refleja el 75% del calor solar, evitando el horno interior.',
          'tip_flushing_title': 'Ventilación Cruzada Nocturna',
          'tip_flushing_desc':
              'Abre ventanas opuestas al atardecer para purgar el calor acumulado en paredes.',

          'ai_advisor_title': 'Asesor IA de Seguridad Térmica',
          'ai_thinking': 'Consultando Modelo Biometeorológico de IA...',
          'ai_label': 'Asesor de Calor IA',
          'ai_hint': 'Pregunta sobre seguridad térmica...',
          'stop': 'Detener',
          'forecast_title': 'Pronóstico UTCI de 7 Días',
          'forecast_sub': 'Proyecciones Bioclimáticas',
          'hourly_timeline_title': 'Línea de Tiempo UTCI Horaria (24 Horas)',
          'hourly_timeline_desc': 'Estrés térmico fisiológico calculado por hora',
          'forecast_7day_title': 'Radar de Riesgo de Ola de Calor de 7 Días',
          'forecast_7day_badge': 'Modelo ERA5-HEAT',
          'forecast_7day_desc': 'Detecta episodios de calor extendidos de varios días',
          'heatwave_label': 'OLA DE CALOR',
          'normal_label': 'Normal',
          'high_sweat_barrier': 'Alta barrera de sudor',
          'normal_sweat_rate': 'Tasa normal de sudor',
          'direct_solar_radiance': 'Radiancia solar directa',
          'airflow_suffix': 'flujo de aire',

          // Heat Stress Category Labels
          'heat_stress_no_stress': 'Sin Estrés Térmico',
          'heat_stress_moderate': 'Estrés Térmico Moderado',
          'heat_stress_strong': 'Estrés Térmico Fuerte',
          'heat_stress_very_strong': 'Estrés Térmico Muy Fuerte',
          'heat_stress_extreme': 'Estrés Térmico Extremo',
          'heat_stress_cold_stress': 'Estrés por Frío',
          'heat_stress_unknown': 'Desconocido',

          // UTCI Gauge
          'utci_equivalent': 'Equivalente UTCI',

          // Weather Descriptions
          'weather_clear_sky': 'Cielo Despejado',
          'weather_partly_cloudy': 'Parcialmente Nublado',
          'weather_overcast': 'Nublado',
          'weather_haze_dust': 'Bruma / Polvo',
          'weather_light_drizzle': 'Llovizna Ligera',
          'weather_rain_shower': 'Chubascos',
          'weather_heavy_rain': 'Lluvia Fuerte',
          'weather_thunderstorm': 'Tormenta Eléctrica',
          'weather_sunny_clear': 'Soleado / Despejado',

          // Geofence Dialog & Badges
          'geofence_alert': 'ALERTA DE GEOCERCA',
          'geofence_safe_perimeter': 'PERÍMETRO SEGURO',
          'geofence_gps_coordinates': 'Coordenadas GPS',
          'geofence_radius': 'Radio de Geocerca',
          'geofence_perimeter_suffix': 'Perímetro',
          'geofence_distance_center': 'Distancia al Epicentro',
          'geofence_danger_threshold': 'Umbral de Peligro',
          'geofence_rescan_btn': 'Reescanear Ubicación y Perímetro',
          'geofence_standard_perimeter': 'Perímetro Térmico Estándar',
          'geofence_standard_summary':
              'Límite térmico normal. Sin alertas activas de estrés térmico.',
          'geofence_zone_danger': 'Geocerca de Calor Severo en @city',
          'geofence_zone_regional': 'Ola de Calor Regional en @city',
          'geofence_zone_safe': 'Perímetro Térmico Seguro en @city',
          'geofence_critical_active':
              'GEOCERCA CRÍTICA ACTIVA: Su ubicación (@lat, @lon) está en el perímetro de peligro de @radius km donde el UTCI (@utci°C) supera el límite de seguridad (38°C).',
          'geofence_regional_heatwave':
              'Ola de calor regional detectada (@utci°C UTCI). Distancia al centro: @dist km.',
          'geofence_safe_zone':
              'Está en una zona bioclimática segura. El UTCI local es de @utci°C (muy por debajo del umbral de peligro de 38°C).',

          // Audio Player Bar & Tooltips
          'voice_readout': 'LECTURA DE VOZ',
          'on_device_audio': 'Audio en Dispositivo',
          'stop_speaking': 'Detener voz',
          'listen_in_lang': 'Escuchar en @lang',

          // Forecast Screen Additions
          'temp_label': 'Temp',
          'humidity_label': 'Humedad',
          'max_label': 'Máx',
          'min_label': 'Mín',
          'danger_badge': 'PELIGRO',
          'listen_forecast_tooltip': 'Escuchar pronóstico',
          'refresh_forecast_tooltip': 'Actualizar pronóstico',
          'today': 'Hoy',
          'day_mon': 'Lun',
          'day_tue': 'Mar',
          'day_wed': 'Mié',
          'day_thu': 'Jue',
          'day_fri': 'Vie',
          'day_sat': 'Sáb',
          'day_sun': 'Dom',
          'safe_work_rec_peak':
              'Pico de calor peligroso previsto entre @danger. Cambie las labores al aire libre a la mañana (@morning) o tarde (@evening).',
          'safe_work_rec_default':
              'Realice las tareas pesadas de campo o entrega temprano en la mañana o al atardecer.',

          // AI Advisor Quick Prompts
          'prompt_hydration': '💧 Plan de hidratación por hora',
          'prompt_work_rest': '⏱️ Proporción trabajo/descanso',
          'prompt_exhaustion_stroke': '⚠️ Agotamiento vs Golpe de calor',
          'prompt_rider_gear': '🛵 Casco del repartidor y asfalto',
          'prompt_cool_roof': '🏠 Techo fresco sin aire acondicionado',
          'prompt_harvesting': '🌾 Turno seguro de cosecha',

          // Guidance Checklist Items
          'check_ow_c1_title': 'Garrafa de Agua Limpia de 2.5L Lista',
          'check_ow_c1_desc':
              'Tener agua fresca accesible a menos de 2 minutos de su área de trabajo.',
          'check_ow_c2_title': 'Sombrero de Ala Ancha o Cubrenuca',
          'check_ow_c2_desc':
              'Coloque un paño húmedo bajo su casco o use sombrero de ala ancha.',
          'check_ow_c3_title': 'Zona de Sombra Previamente Identificada',
          'check_ow_c3_desc':
              'Ubique un espacio techado con brisa para sus descansos de 15 minutos cada hora.',
          'check_ow_c4_title': 'Sistema de Monitoreo entre Compañeros',
          'check_ow_c4_desc':
              'Acuerde con un compañero vigilarse mutuamente por mareos o confusión.',

          'check_dr_r1_title': 'Visera Limpia y Conducto de Ventilación Abierto',
          'check_dr_r1_desc':
              'Mantenga la visera abierta un punto para evitar una bolsa de calor de 48°C.',
          'check_dr_r2_title': 'Braga de Cuello o Pañuelo Húmedo',
          'check_dr_r2_desc':
              'Humedezca el pañuelo antes de salir para refrigeración convectiva con el viento.',
          'check_dr_r3_title': 'Termo con Agua Fresca',
          'check_dr_r3_desc':
              'Lleve agua fría; evite bebidas energéticas que sobrecargan los riñones.',
          'check_dr_r4_title': 'Estacionamiento Bajo Sombra en los Centros',
          'check_dr_r4_desc':
              'Estacione la moto bajo árboles entre entregas para mantener el asiento fresco.',

          'check_fm_f1_title': 'Turno de Campo desde el Amanecer',
          'check_fm_f1_desc':
              'Complete el arado y cosecha de cultivos antes de las 10:30 AM.',
          'check_fm_f2_title': 'Sombra y Bebederos para Animales',
          'check_fm_f2_desc':
              'Verifique que los corrales tengan sombra densa y agua abundante.',
          'check_fm_f3_title': 'Manga Larga de Algodón Holgada',
          'check_fm_f3_desc':
              'Proteja los brazos de la intensa radiación solar permitiendo ventilación.',
          'check_fm_f4_title': 'Salida del Campo Abierto al Mediodía',
          'check_fm_f4_desc':
              'Retírese de los campos abiertos entre las 11:30 AM y las 3:30 PM.',

          'check_ir_i1_title': 'Cortinas de Arpillera Húmeda en Ventanas',
          'check_ir_i1_desc':
              'Mojar sacos de yute en las entradas baja la temperatura interior entre 3 y 4°C.',
          'check_ir_i2_title': 'Ventilaciones Altas Abiertas',
          'check_ir_i2_desc':
              'Permita que el aire caliente atrapado suba y salga por las rendijas superiores.',
          'check_ir_i3_title': 'Localizar la Sombra Comunitaria',
          'check_ir_i3_desc':
              'Ubique el árbol de sombra pública o refugio comunitario más cercano.',
          'check_ir_i4_title': 'Beber Agua Enfriada en Vasija de Barro',
          'check_ir_i4_desc':
              'Guarde el agua hervida en ollas de barro para un enfriamiento natural.',

          'check_vn_v1_title': 'Permanecer en la Habitación Más Baja y Fresca',
          'check_vn_v1_desc':
              'Quédese en el piso inferior de la casa donde el aire es más fresco.',
          'check_vn_v2_title': 'Baño de Pies con Agua Fresca',
          'check_vn_v2_desc':
              'Sumergir los pies en agua fresca reduce rápidamente la temperatura interna.',
          'check_vn_v3_title': 'Vaso de Agua Cada Hora Programado',
          'check_vn_v3_desc':
              'Tome 200ml cada hora incluso sin tener sensación de sed.',
          'check_vn_v4_title': 'Contacto de Emergencia en Marcación Rápida',
          'check_vn_v4_desc':
              'Tenga a mano el teléfono del centro de salud o de un vecino cercano.',

          'emergency_first_aid_speech':
              'Protocolo de Emergencia por Golpe de Calor: Mueva a la persona a la sombra más densa de inmediato. Acuéstela boca arriba y eleve los pies 30 centímetros. Moje su cuerpo con agua fresca o paños húmedos. Llame a emergencias de inmediato. No suministre líquidos si está inconsciente.',
        },

        // ── Hindi ────────────────────────────────────────────────────────────
        'hi_IN': {
          'app_name': 'UTCI अलर्ट',
          'app_subtitle': 'गर्मी को पहचानें, सुरक्षित रहें',
          'select_profile': 'अपनी प्रोफ़ाइल चुनें',
          'select_profile_desc':
              'अलर्ट, आराम के अनुपात और AI सुझाव आपके दैनिक वातावरण के अनुसार बदलते हैं',
          'enter_dashboard': 'थर्मल डैशबोर्ड में प्रवेश करें',
          'sign_in_google': 'Google से साइन इन करें',

          // Roles
          'role_outdoor_worker': 'आउटडोर कार्यकर्ता',
          'role_outdoor_worker_desc':
              'निर्माण, सड़क विक्रेता और धूप में काम करने वाले मजदूर',
          'role_delivery_rider': 'डिलीवरी राइडर',
          'role_delivery_rider_desc':
              'मोटरसाइकिल और साइकिल कूरियर जो डामर की गर्मी का सामना करते हैं',
          'role_farmer': 'किसान',
          'role_farmer_desc':
              'तीव्र गर्मी में फसल कटाई और मवेशियों की देखभाल करने वाले',
          'role_informal_resident': 'अनौपचारिक बस्ती',
          'role_informal_resident_desc':
              'टिन की छतों वाले घने क्षेत्रों के निवासी जहां छाया सीमित है',
          'role_vulnerable': 'वरिष्ठ और संवेदनशील',
          'role_vulnerable_desc':
              'उच्च रक्तचाप, श्वसन जोखिम वाले लोग, बच्चे और बुजुर्ग',

          'nav_radar': 'रडार',
          'nav_forecast': 'पूर्वानुमान',
          'nav_ai': 'AI सलाहकार',
          'nav_toolkit': 'टूलकिट',
          'nav_settings': 'सेटिंग्स',
          'nav_ai_copilot': 'AI सहायक',

          'dashboard_title': 'थर्मल डैशबोर्ड',
          'choose_language': 'अलर्ट और आवाज़ की भाषा चुनें',
          'choose_language_desc':
              'चेतावनियाँ, AI सलाह और आवाज़ पठन इस भाषा में ढल जाएंगे।',
          'switch_profile': 'संवेदनशीलता प्रोफ़ाइल बदलें',
          'switch_profile_desc':
              'आपकी फ़ील्ड वास्तविकता के अनुसार काम-आराम चक्र और हाइड्रेशन लक्ष्य निर्धारित करता है।',
          'city_region': 'शहर / क्षेत्र',
          'search_city_hint': 'शहर या क्षेत्र खोजें...',
          'gps_location': 'GPS स्थान उपयोग करें',
          'refresh': 'रीफ्रेश करें',
          'utci_index': 'UTCI सूचकांक',
          'heat_stress': 'ताप तनाव',
          'ai_advice': 'AI सलाह',
          'read_aloud': 'ज़ोर से पढ़ें',
          'safe_work_windows': 'सुरक्षित कार्य समय',
          'morning_window': 'सुबह का समय',
          'danger_window': 'खतरे का समय',
          'evening_window': 'शाम का समय',
          'status_safe_moderate': 'सुरक्षित / मध्यम',
          'status_very_strong': 'बहुत तीव्र',
          'status_recommended': 'अनुशंसित',
          'radar_title': 'थर्मल कम्फर्ट रडार',
          'radar_subtitle': 'सार्वभौमिक थर्मल जलवायु सूचकांक (UTCI)',
          'radar_desc': 'तापमान, सौर विकिरण, आर्द्रता और हवा की गति को जोड़ता है',
          'voice_label': 'आवाज़',
          'live_hazard_advisory': 'लाइव खतरा परामर्श',
          'deep_shade_mandatory': 'गहरी छाया अनिवार्य है',
          'chip_rest_extreme': '15 मिनट काम / 45 मिनट आराम',
          'chip_rest_normal': '45 मिनट काम / 15 मिनट आराम',
          'chip_water_extreme': '1.0 लीटर / घंटा',
          'chip_water_normal': '500–750 मिली / घंटा',
          'ai_safety_plan': 'AI सुरक्षा योजना',
          'instant_field_protocol': 'तत्काल फ़ील्ड प्रोटोकॉल',
          'work_rest_label': 'काम / आराम',
          'hydration_label': 'हाइड्रेशन',
          'field_action_label': 'फ़ील्ड कार्रवाई',
          'cooling_method_label': 'शीतलन विधि',
          'air_temp': 'हवा का तापमान',
          'rel_humidity': 'सापेक्ष आर्द्रता',
          'wind_speed': 'हवा की गति',
          'apparent_heat': 'महसूस होने वाली गर्मी',
          'hourly_progression': '24-घंटे थर्मल प्रगति',
          'hourly_curve': 'प्रति घंटा UTCI वक्र',

          // City Selector Sheet
          'select_city_title': 'शहर या क्षेत्र चुनें',
          'select_city_sub': 'विश्वव्यापी जियोकोडिंग और हाइपरलोकल GPS',
          'use_exact_gps': 'सटीक GPS स्थान और जियोफ़ेंस उपयोग करें',
          'gps_locating': 'सटीक GPS और इलाका खोजा जा रहा है...',
          'gps_detected': 'असली शहर, खतरे का दायरा और स्थानीय आवाज़ स्वतः तय करता है',
          'search_worldwide_hint':
              'दुनिया का कोई भी शहर खोजें (जैसे दिल्ली, मुंबई, काहिरा, रियाद)...',
          'featured_hubs': 'प्रमुख वैश्विक केंद्र',
          'search_results': 'खोज परिणाम',
          'locations_count': 'स्थान',
          'no_cities_found': 'कोई शहर नहीं मिला। दूसरा नाम आज़माएं।',

          'settings_title': 'सेटिंग्स और प्रोफ़ाइल',
          'active_profile': 'सक्रिय उपयोगकर्ता प्रोफ़ाइल',
          'active_profile_desc':
              'अलर्ट संदेश, स्वर और मार्गदर्शन को स्वचालित रूप से अनुकूलित करने के लिए अपनी प्रोफ़ाइल चुनें।',
          'voice_tts': 'वॉयस इंजन (TTS)',
          'voice_tts_desc':
              'ऑन-डिवाइस स्पीच सिंथेसाइज़र। सवारी या काम के दौरान हैंड्स-फ़्री अलर्ट सक्षम करता है।',
          'test_voice': 'आवाज़ आज़माएं',
          'speech_speed': 'बोलने की गति',
          'voice_pitch': 'आवाज़ की पिच',
          'alert_threshold': 'अलर्ट ट्रिगर सीमा',
          'alert_threshold_desc':
              'जब स्थानीय तापीय सूचकांक इस सीमा से अधिक हो तो ऑडियो और बैनर से सूचित करें।',
          'about_title': 'UTCI Alert और वैज्ञानिक आधार के बारे में',
          'about_desc':
              'Intechvia Flutter इंटर्नशिप प्रोग्राम · इनोवेशन स्प्रिंट\nलेखक: मनसूर अहमद\nसंस्करण: 1.0 प्रोडक्शन एडिशन',
          'scientific_refs': 'वैज्ञानिक संदर्भ और डेटा स्रोत:',
          'ref_era5_title': 'ERA5-HEAT वैश्विक पुनर्विश्लेषण (1974–2023)',
          'ref_era5_desc':
              '50-वर्षीय 0.25°x0.25° ग्रिड बायोक्लाइमैटिक हीट इंडेक्स पुनर्विश्लेषण।',
          'ref_african_title': 'शहरी हीटवेव अध्ययन',
          'ref_african_desc':
              'अलेक्जेंड्रिया, अल्जियर्स, ट्यूनिस, कानो, डकार में अत्यधिक गर्मी की वृद्धि।',
          'ref_chews_title': 'सामुदायिक पूर्व चेतावनी CHEWS (नाइजीरिया)',
          'ref_chews_desc':
              'समुदाय-केंद्रित हीट पूर्व चेतावनी प्रणाली का बेंचमार्क।',

          'guidance_title': 'सुरक्षा टूलकिट',
          'guidance_for': 'के लिए व्यक्तिगत',
          'hydration_guard': 'हाइड्रेशन गार्ड',
          'hydration_reset': 'रीसेट',
          'goal_suffix': 'लक्ष्य',
          'add_glass': '+250ml गिलास',
          'add_bottle': '+500ml बोतल',
          'shift_checklist': 'शिफ्ट गर्मी तैयारी',
          'listen': 'सुनें',
          'emergency_triage': 'हीटस्ट्रोक आपातकालीन ट्रायज',
          'heat_exhaustion': 'गर्मी से थकावट',
          'heat_exhaustion_s1': '• ठंडी, पीली, चिपचिपी त्वचा',
          'heat_exhaustion_s2': '• अत्यधिक पसीना',
          'heat_exhaustion_s3': '• चक्कर और मतली',
          'heat_exhaustion_action':
              'कार्रवाई: छाया में जाएं, कपड़े ढीले करें, ठंडा पानी पिएं।',
          'heatstroke_critical': 'हीट स्ट्रोक (गंभीर)',
          'heatstroke_s1': '• शारीरिक तापमान > 40°C',
          'heatstroke_s2': '• गर्म, लाल त्वचा',
          'heatstroke_s3': '• भ्रम या प्रलाप',
          'heatstroke_action': 'कार्रवाई: 112 पर कॉल करें! ठंडे पानी से नहलाएं।',
          'cooling_guide': 'अनौपचारिक बस्तियों के लिए शीतलन युक्तियाँ',
          'cooling_guide_desc':
              'बिना बिजली की तकनीकें जो अनौपचारिक बस्तियों की वास्तविकता के लिए डिज़ाइन की गई हैं',
          'tip_jute_title': 'खिड़की पर गीली बोरी का पर्दा',
          'tip_jute_desc':
              'खुली खिड़कियों पर गीला जूट लटकाएं; अंदर आने वाली हवा 3-5°C ठंडी हो जाती है।',
          'tip_whitewash_title': 'टिन की छतों पर चूने की सफेदी',
          'tip_whitewash_desc':
              'सफेद चूना 75% सौर गर्मी को परावर्तित करता है, जिससे छत भट्टी नहीं बनती।',
          'tip_flushing_title': 'रात का क्रॉस वेंटिलेशन',
          'tip_flushing_desc':
              'सूर्यास्त के बाद आमने-सामने की खिड़कियां खोलें ताकि दीवारों में फंसी गर्मी निकल जाए।',

          'ai_advisor_title': 'AI थर्मल सुरक्षा सलाहकार',
          'ai_thinking': 'AI बायोमेटियोरोलॉजिकल मॉडल से परामर्श...',
          'ai_label': 'AI हीट सलाहकार',
          'ai_hint': 'थर्मल सुरक्षा सलाह पूछें...',
          'stop': 'रोकें',
          'forecast_title': '7-दिन UTCI पूर्वानुमान',
          'forecast_sub': 'बायोक्लाइमैटिक अनुमान',
          'hourly_timeline_title': 'घंटेवार UTCI टाइमलाइन (24 घंटे)',
          'hourly_timeline_desc': 'प्रति घंटे शारीरिक ताप तनाव की गणना',
          'forecast_7day_title': '7-दिन ताप लहर जोखिम रडार',
          'forecast_7day_badge': 'ERA5-HEAT मॉडल',
          'forecast_7day_desc': 'कई दिनों की विस्तारित गर्मी की लहरों का पता लगाता है',
          'heatwave_label': 'ताप लहर',
          'normal_label': 'सामान्य',
          'high_sweat_barrier': 'उच्च पसीना अवरोध',
          'normal_sweat_rate': 'सामान्य पसीना दर',
          'direct_solar_radiance': 'प्रत्यक्ष सौर विकिरण',
          'airflow_suffix': 'वायु प्रवाह',

          // Heat Stress Category Labels
          'heat_stress_no_stress': 'कोई हीट स्ट्रेस नहीं',
          'heat_stress_moderate': 'मध्यम हीट स्ट्रेस',
          'heat_stress_strong': 'तीव्र हीट स्ट्रेस',
          'heat_stress_very_strong': 'अत्यधिक तीव्र हीट स्ट्रेस',
          'heat_stress_extreme': 'अत्यंत गंभीर हीट स्ट्रेस',
          'heat_stress_cold_stress': 'कोल्ड स्ट्रेस',
          'heat_stress_unknown': 'अज्ञात',

          // UTCI Gauge
          'utci_equivalent': 'UTCI समतुल्य',

          // Weather Descriptions
          'weather_clear_sky': 'साफ आसमान',
          'weather_partly_cloudy': 'आंशिक रूप से बादल',
          'weather_overcast': 'बादल छाए रहेंगे',
          'weather_haze_dust': 'धुंध / धूल',
          'weather_light_drizzle': 'हल्की बूंदाबांदी',
          'weather_rain_shower': 'बारिश की फुहारें',
          'weather_heavy_rain': 'भारी बारिश',
          'weather_thunderstorm': 'गरज के साथ आंधी',
          'weather_sunny_clear': 'धूप / साफ',

          // Geofence Dialog & Badges
          'geofence_alert': 'जियोफेंस चेतावनी',
          'geofence_safe_perimeter': 'सुरक्षित क्षेत्र',
          'geofence_gps_coordinates': 'जीपीएस निर्देशांक',
          'geofence_radius': 'जियोफेंस दायरा',
          'geofence_perimeter_suffix': 'परिधि',
          'geofence_distance_center': 'केंद्र से दूरी',
          'geofence_danger_threshold': 'खतरे की सीमा',
          'geofence_rescan_btn': 'स्थान और परिधि को पुनः स्कैन करें',
          'geofence_standard_perimeter': 'मानक थर्मल परिधि',
          'geofence_standard_summary':
              'सामान्य थर्मल सीमा। कोई सक्रिय हीट स्ट्रेस चेतावनी नहीं।',
          'geofence_zone_danger': '@city गंभीर गर्मी जियोफेंस',
          'geofence_zone_regional': '@city क्षेत्रीय लू (हीटवेव)',
          'geofence_zone_safe': '@city सुरक्षित थर्मल परिधि',
          'geofence_critical_active':
              'महत्वपूर्ण जियोफेंस सक्रिय: आपका स्थान (@lat, @lon) @radius किमी खतरे के दायरे में है जहां UTCI (@utci°C) सुरक्षा सीमा (38°C) से अधिक है।',
          'geofence_regional_heatwave':
              'क्षेत्रीय हीटवेव दर्ज (@utci°C UTCI)। केंद्र से दूरी: @dist किमी।',
          'geofence_safe_zone':
              'आप एक सुरक्षित क्षेत्र में हैं। स्थानीय UTCI @utci°C है (38°C खतरे की सीमा से काफी नीचे)।',

          // Audio Player Bar & Tooltips
          'voice_readout': 'आवाज से सुनें',
          'on_device_audio': 'ऑन-डिवाइस ऑडियो',
          'stop_speaking': 'आवाज रोकें',
          'listen_in_lang': '@lang में सुनें',

          // Forecast Screen Additions
          'temp_label': 'तापमान',
          'humidity_label': 'नमी',
          'max_label': 'अधिकतम',
          'min_label': 'न्यूनतम',
          'danger_badge': 'खतरा',
          'listen_forecast_tooltip': 'पूर्वानुमान सुनें',
          'refresh_forecast_tooltip': 'पूर्वानुमान रीफ्रेश करें',
          'today': 'आज',
          'day_mon': 'सोम',
          'day_tue': 'मंगल',
          'day_wed': 'बुध',
          'day_thu': 'गुरु',
          'day_fri': 'शुक्र',
          'day_sat': 'शनि',
          'day_sun': 'रवि',
          'safe_work_rec_peak':
              '@danger के बीच खतरनाक गर्मी का अनुमान है। बाहरी काम को सुबह (@morning) या शाम (@evening) में स्थानांतरित करें।',
          'safe_work_rec_default':
              'भारी काम या डिलीवरी का काम सुबह जल्दी या देर शाम को करें।',

          // AI Advisor Quick Prompts
          'prompt_hydration': '💧 प्रति घंटे पानी पीने की योजना',
          'prompt_work_rest': '⏱️ कार्य और आराम का अनुपात',
          'prompt_exhaustion_stroke': '⚠️ हीट थकावट बनाम हीट स्ट्रोक',
          'prompt_rider_gear': '🛵 राइडर हेलमेट और सड़क की गर्मी',
          'prompt_cool_roof': '🏠 बिना एसी छत को ठंडा रखना',
          'prompt_harvesting': '🌾 सुरक्षित फसल कटाई की शिफ्ट',

          // Guidance Checklist Items
          'check_ow_c1_title': '2.5L साफ पानी की बोतल तैयार रखें',
          'check_ow_c1_desc':
              'कार्य क्षेत्र से 2 मिनट की दूरी पर ठंडा पानी उपलब्ध रखें।',
          'check_ow_c2_title': 'चौड़ी टोपी या गर्दन का कपड़ा',
          'check_ow_c2_desc':
              'हेलमेट के नीचे गीला कपड़ा रखें या चौड़ी किनारी वाली टोपी पहनें।',
          'check_ow_c3_title': 'छायादार जगह पहले से पहचानें',
          'check_ow_c3_desc':
              'हर घंटे 15 मिनट के आराम के लिए हवादार छायादार जगह चुनें।',
          'check_ow_c4_title': 'साथी की निगरानी प्रणाली सक्रिय रखें',
          'check_ow_c4_desc':
              'साथी मजदूर के साथ एक-दूसरे की निगरानी करें ताकि चक्कर आने पर मदद मिल सके।',

          'check_dr_r1_title': 'हेलमेट का वाइज़र और वेंट खोलें',
          'check_dr_r1_desc':
              'हेलमेट के अंदर 48°C की अत्यधिक गर्मी से बचने के लिए वाइज़र थोड़ा खुला रखें।',
          'check_dr_r2_title': 'गर्दन पर गीला कपड़ा या रुमाल',
          'check_dr_r2_desc':
              'सफर शुरू करने से पहले रुमाल गीला करें ताकि हवा से ठंडक मिले।',
          'check_dr_r3_title': 'ठंडे पानी की बोतल साथ रखें',
          'check_dr_r3_desc':
              'ठंडा पानी पिएं; एनर्जी ड्रिंक्स से बचें जो किडनी पर दबाव डालते हैं।',
          'check_dr_r4_title': 'हब पर छाया में बाइक पार्क करें',
          'check_dr_r4_desc':
              'डिलीवरी के बीच बाइक को पेड़ों की छाया में रखें ताकि सीट ठंडी रहे।',

          'check_fm_f1_title': 'सूर्योदय के साथ खेत की शिफ्ट शुरू करें',
          'check_fm_f1_desc':
              'जुताई और फसल कटाई का काम सुबह 10:30 बजे से पहले पूरा करें।',
          'check_fm_f2_title': 'मवेशियों के लिए छाया और पानी',
          'check_fm_f2_desc':
              'पशुओं के बाड़े में घनी छाया और प्रचुर पानी की व्यवस्था सुनिश्चित करें।',
          'check_fm_f3_title': 'ढीले सूती पूरी आस्तीन के कपड़े',
          'check_fm_f3_desc':
              'तेज धूप से बाहों को बचाएं और हवा का संचार बनाए रखें।',
          'check_fm_f4_title': 'दोपहर में खुले खेतों से वापसी',
          'check_fm_f4_desc':
              'सुबह 11:30 से दोपहर 3:30 के बीच खुले खेतों में भारी काम न करें।',

          'check_ir_i1_title': 'खिड़कियों पर गीली बोरी का पर्दा लगाएं',
          'check_ir_i1_desc':
              'खिड़कियों पर गीली बोरी लटकाने से कमरे का तापमान 3-4°C तक गिर जाता है।',
          'check_ir_i2_title': 'छत के ऊंचे वेंटिलेटर खुले रखें',
          'check_ir_i2_desc':
              'फंसी हुई गर्म हवा को ऊपर उठकर बाहर निकलने दें।',
          'check_ir_i3_title': 'सामुदायिक छायादार जगह की जानकारी रखें',
          'check_ir_i3_desc':
              'निकटतम बड़े छायादार पेड़ या ठंडे सामुदायिक केंद्र का पता रखें।',
          'check_ir_i4_title': 'मटके का ठंडा पानी पिएं',
          'check_ir_i4_desc':
              'प्राकृतिक ठंडक के लिए पीने का पानी मिट्टी के मटके में रखें।',

          'check_vn_v1_title': 'घर के सबसे ठंडे निचले कमरे में रहें',
          'check_vn_v1_desc':
              'घर के सबसे निचले तल वाले कमरे में रहें जहां हवा ठंडी होती है।',
          'check_vn_v2_title': 'ठंडे पानी में पैर डुबोना',
          'check_vn_v2_desc':
              'पैरों को ठंडे पानी में रखने से शरीर का तापमान तेजी से सामान्य होता है।',
          'check_vn_v3_title': 'हर घंटे एक गिलास पानी का नियम',
          'check_vn_v3_desc':
              'प्यास न लगने पर भी हर घंटे 200 मिली पानी पिएं।',
          'check_vn_v4_title': 'आपातकालीन संपर्क नंबर पास रखें',
          'check_vn_v4_desc':
              'स्वास्थ्य कार्यकर्ता या पड़ोसी का फोन नंबर हमेशा तैयार रखें।',

          'emergency_first_aid_speech':
              'हीट स्ट्रोक आपातकालीन प्रोटोकॉल: पीड़ित को तुरंत घनी छाया में ले जाएं। उन्हें सीधा लिटाएं और पैरों को 30 सेंटीमीटर ऊपर उठाएं। शरीर पर ठंडा पानी डालें या गीला कपड़ा लपेटें। तुरंत आपातकालीन सेवा को कॉल करें। यदि व्यक्ति बेहोश है तो कोई तरल पदार्थ न पिलाएं।',
        },
      };
    dict['en'] = dict['en_US']!;
    dict['ar'] = dict['ar_SA']!;
    dict['ur'] = dict['ur_PK']!;
    dict['sw'] = dict['sw_KE']!;
    dict['fr'] = dict['fr_FR']!;
    dict['es'] = dict['es_ES']!;
    dict['hi'] = dict['hi_IN']!;
    return dict;
  }
}
