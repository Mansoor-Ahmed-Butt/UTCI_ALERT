import '../../data/models/user_role.dart';
import '../../data/models/utci_status_model.dart';
import '../../data/models/weather_models.dart';

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
    return '$headline. Work-rest cycle: $workRestCycle. Hydration: $hydrationGoal. Action: $profileAction. Warning: $warningSign';
  }
}

class AiHeatAdvisorService {
  DynamicAdviceResult generateDynamicAdvice({
    required UtciStatusModel status,
    required UserRole role,
    CurrentWeatherData? weather,
  }) {
    final cat = status.category.toLowerCase();
    final utci = status.value;

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
    switch (role) {
      case UserRole.outdoorWorker:
        return const DynamicAdviceResult(
          headline: 'CRITICAL HAZARD: Stop Direct Heavy Labor',
          workRestCycle: 'Cease heavy labor. Max 15 min light activity / 45 min deep shade',
          hydrationGoal: '1.0 to 1.2 Liters per hour with electrolytes or mineral pinch',
          profileAction: 'Move scaffolding/mixing stations beneath shade tarps. Do not work alone.',
          coolingMethod: 'Soak cotton shirt and drape wet towel over the back of the neck.',
          warningSign: 'Confusion, absence of sweating with hot dry skin, or stumbling.',
        );
      case UserRole.deliveryRider:
        return const DynamicAdviceResult(
          headline: 'ROAD ASPHALT RADIANCE CRITICAL (>55°C)',
          workRestCycle: 'Take 20-min mandatory shaded breaks every 45 minutes of transit',
          hydrationGoal: 'Drink 300ml chilled water or coconut water at every drop-off',
          profileAction: 'Unstrap and remove helmet immediately at stoplights and deliveries.',
          coolingMethod: 'Wet bandana inside helmet vents; avoid idling near hot exhaust pipes.',
          warningSign: 'Tunnel vision, dizziness when dismounting bike, throbbing headache.',
        );
      case UserRole.farmer:
        return const DynamicAdviceResult(
          headline: 'SEVERE AGRICULTURAL HEAT HAZARD',
          workRestCycle: 'Halt all open-field harvesting and plowing until after 17:30',
          hydrationGoal: 'Drink 1.0 Liter/hr; ensure constant water troughs for livestock',
          profileAction: 'Move cattle/goats to shaded tree lines or thatched shelters.',
          coolingMethod: 'Rest in earthen or thick-walled storage buildings during midday.',
          warningSign: 'Rapid pulse, dark brown urine, muscle spasms in calves/abdomen.',
        );
      case UserRole.informalResident:
        return const DynamicAdviceResult(
          headline: 'UNBEARABLE INDOOR METALLIC HEAT',
          workRestCycle: 'Evacuate corrugated tin-roof rooms between 11:30 and 16:30',
          hydrationGoal: 'Keep small water clay jugs (Zeer pots) accessible to children and elderly',
          profileAction: 'Gather under community shade trees or shaded communal courtyards.',
          coolingMethod: 'Hang damp jute/burlap sacks across doorways to humidify and cool airflow.',
          warningSign: 'Lethargy in infants or elderly family members, rapid shallow breathing.',
        );
      case UserRole.vulnerable:
        return const DynamicAdviceResult(
          headline: 'HIGH-RISK HEALTH THREAT',
          workRestCycle: 'Absolute bed rest in the coolest ground-level room available',
          hydrationGoal: 'Frequent small sips of water (150ml every 20 min) even without thirst',
          profileAction: 'Avoid enclosed spaces with direct solar exposure. Keep medications cool.',
          coolingMethod: 'Place feet in a basin of cool tap water; apply damp washcloth to neck.',
          warningSign: 'Chest pressure, shortness of breath, sudden disorientation.',
        );
    }
  }

  DynamicAdviceResult _buildVeryStrongAdvice(double utci, UserRole role) {
    switch (role) {
      case UserRole.outdoorWorker:
        return const DynamicAdviceResult(
          headline: 'VERY STRONG HEAT STRESS: Work-Rest Protocol Active',
          workRestCycle: '30 minutes work / 30 minutes shaded rest (OSHA/NIOSH ratio)',
          hydrationGoal: '800ml to 1.0 Liter of cool water per hour',
          profileAction: 'Rotate high-exertion tasks among crew members. Monitor buddy responsiveness.',
          coolingMethod: 'Sponge forearms and neck with cool water during rest periods.',
          warningSign: 'Heavy sweating followed by sudden goosebumps or cold clammy skin.',
        );
      case UserRole.deliveryRider:
        return const DynamicAdviceResult(
          headline: 'HIGH HELMET HEAT LOAD: Asphalt Thermal Trap',
          workRestCycle: '15-min rest every 60 minutes in air-conditioned or shaded depots',
          hydrationGoal: 'Replenish 750ml water per hour; avoid sugary energy drinks',
          profileAction: 'Keep visor slightly cracked for air circulation during low-speed transit.',
          coolingMethod: 'Keep a frozen gel pack or wet microfiber cloth inside bike carrier.',
          warningSign: 'Throbbing temples, nausea, sluggish braking reflex.',
        );
      case UserRole.farmer:
        return const DynamicAdviceResult(
          headline: 'FIELD EXPOSURE ELEVATED: Shift to Barn Tasks',
          workRestCycle: '40 minutes field work / 20 minutes rest under dense foliage',
          hydrationGoal: 'Drink oral rehydration salts or salted lemon water regularly',
          profileAction: 'Wear broad-brimmed straw hats and loose light-colored cotton garments.',
          coolingMethod: 'Wet hat rim with cool well water before stepping into sunshine.',
          warningSign: 'Heat cramps in legs, extreme fatigue, dizziness upon standing.',
        );
      case UserRole.informalResident:
        return const DynamicAdviceResult(
          headline: 'CORRUGATED ROOF HEAT PEAK',
          workRestCycle: 'Open opposing windows and vents to encourage cross-draft breezes',
          hydrationGoal: 'Encourage children to drink water every 30 minutes',
          profileAction: 'Sprinkle cool water on exterior roof sheets if water supplies allow.',
          coolingMethod: 'Set up battery or USB fans behind moist hanging cloth screens.',
          warningSign: 'Drowsiness, dry lips, crying with no tears in young children.',
        );
      case UserRole.vulnerable:
        return const DynamicAdviceResult(
          headline: 'VULNERABILITY ALERT: Heat Exhaustion Risk',
          workRestCycle: 'Remain indoors; minimize cooking or heat-generating appliances',
          hydrationGoal: 'Maintain continuous oral fluid intake; avoid caffeinated tea/coffee',
          profileAction: 'Loosen tight clothing; arrange a welfare check-in with a neighbor.',
          coolingMethod: 'Frequent cool sponge baths or spritzing skin with water mist.',
          warningSign: 'Lightheadedness, irregular heartbeats, severe weakness.',
        );
    }
  }

  DynamicAdviceResult _buildStrongAdvice(double utci, UserRole role) {
    return const DynamicAdviceResult(
      headline: 'STRONG HEAT STRESS: Precautionary Measures Required',
      workRestCycle: '45 minutes work / 15 minutes rest in shaded canopy',
      hydrationGoal: 'Drink 500ml to 750ml water per hour',
      profileAction: 'Schedule heavy physical tasks before noon or after 16:30.',
      coolingMethod: 'Wear UV-protective sunglasses and breathable cotton clothing.',
      warningSign: 'Mild headache, fatigue, persistent excessive thirst.',
    );
  }

  DynamicAdviceResult _buildModerateAdvice(double utci, UserRole role) {
    return const DynamicAdviceResult(
      headline: 'MODERATE HEAT: Standard Thermal Safety',
      workRestCycle: 'Normal workflow with 10-minute hourly hydration break',
      hydrationGoal: 'Drink 350ml to 500ml water per hour',
      profileAction: 'Apply SPF sunscreen and stay mindful of peak sun angles.',
      coolingMethod: 'Stay in natural shade when taking work breaks.',
      warningSign: 'General dehydration or dry throat.',
    );
  }

  DynamicAdviceResult _buildComfortAdvice(double utci, UserRole role) {
    return const DynamicAdviceResult(
      headline: 'THERMAL COMFORT: Optimal Working Conditions',
      workRestCycle: 'Standard operating hours without heat-related restrictions',
      hydrationGoal: 'Standard daily hydration (2.0 to 2.5 Liters total)',
      profileAction: 'Great time for outdoor logistics, field cultivation, and transit.',
      coolingMethod: 'Natural ambient comfort.',
      warningSign: 'No significant heat stress risks detected.',
    );
  }

  /// AI Chat copilot providing structured advice
  Future<String> answerQuery({
    required String query,
    required UtciStatusModel? currentStatus,
    required UserRole role,
  }) async {
    // Artificial small delay for realistic AI generation feel
    await Future.delayed(const Duration(milliseconds: 300));

    final q = query.toLowerCase();
    final utciVal = currentStatus?.value ?? 36.0;
    final category = currentStatus?.categoryLabel ?? 'Strong Heat Stress';

    if (q.contains('hydration') || q.contains('water') || q.contains('drink')) {
      return '''💧 **Personalized Hydration Protocol for ${role.label}**
Current Heat Stress: **$category (${utciVal.toStringAsFixed(1)}°C UTCI)**

1. **Volume Target:** Drink **250ml (1 glass) every 15–20 minutes** under current conditions. That equals approximately **800ml to 1.0L per hour**.
2. **Electrolytes Matter:** Pure water alone during heavy sweating can cause hyponatremia (salt depletion). Add a tiny pinch of salt or consume oral rehydration salts / lemon water.
3. **Avoid Dehydrators:** Steer clear of high-sugar energy drinks, alcohol, and excessive caffeinated sodas — they increase kidney fluid loss.
4. **Urine Color Guide:** Pale straw color indicates healthy hydration; amber or dark yellow signals urgent need to drink 500ml immediately.''';
    }

    if (q.contains('symptom') || q.contains('exhaustion') || q.contains('stroke') || q.contains('sign')) {
      return '''⚠️ **Heat Exhaustion vs. Heat Stroke (Life Threatening)**

• **Heat Exhaustion (Act Immediately):**
  - Pale, cool, clammy skin
  - Heavy profuse sweating
  - Dizziness, nausea, rapid weak pulse
  - Muscle cramps and weakness
  ➡️ *Action:* Move to deep shade, lay down, loosen clothes, sip cool water, apply wet cloth.

• **Heat Stroke (MEDICAL EMERGENCY — DIAL 112 / EMERGENCY):**
  - High core temperature (>40°C)
  - Hot, red, dry skin OR heavy sweating that suddenly stops
  - Confusion, slurred speech, delirium, loss of consciousness
  - Vomiting or seizures
  ➡️ *Action:* Call emergency aid instantly! Immerse or douse victim in cold water. Fan aggressively. Do NOT force liquids into an unconscious person.''';
    }

    if (q.contains('roof') || q.contains('informal') || q.contains('home') || q.contains('cool') && q.contains('house')) {
      return '''🏠 **Passive Cooling for Tin & Corrugated Iron Homes (Zero AC)**

1. **Evaporative Window Screens:** Hang wet burlap or jute sacks across open windows facing the wind. Inflow air drops by **3°C to 5°C** as water evaporates.
2. **Night Purge Cross-Ventilation:** Keep all high vents and windows wide open from 20:00 to 07:00 to flush out heat stored in concrete and metal.
3. **Roof Whitewash:** Painting corrugated metal roofs with calcium lime whitewash reflects up to **75% of solar radiation**, dropping indoor ceiling temperatures by up to 8°C.
4. **Ceiling Barrier:** If ceiling boards are missing, suspend cardboard or woven reed mats 15cm below the tin sheets to block direct radiant heating into living rooms.''';
    }

    if (q.contains('rider') || q.contains('helmet') || q.contains('bike') || q.contains('motorcycle')) {
      return '''🛵 **Delivery Rider Thermal Safety Guide**

1. **Helmet Microclimate:** Inside a closed full-face helmet, temperatures can exceed **48°C**. Crack the visor 1–2 notches when in motion.
2. **Drop-Off Protocol:** The moment you stop the engine, unclip and take off your helmet to let head heat dissipate.
3. **Asphalt Radiance:** Dark asphalt absorbs and radiates extreme infrared heat (surface temps exceed 60°C). Park under awnings or trees at dispatch hubs.
4. **Under-Armor Cooling:** Soak a light cotton neck scarf in cold water before your shift; wind while riding produces continuous convective evaporative cooling.''';
    }

    if (q.contains('farm') || q.contains('crop') || q.contains('livestock') || q.contains('harvest')) {
      return '''🌾 **Agricultural & Livestock Heat Defense**

1. **Shift Inversion:** Shift field labor to the **Dawn Window (05:30 – 09:30)** and **Sunset Window (17:00 – 19:30)**. Avoid all midday open field tasks.
2. **Livestock Water Supply:** Cattle and goats require 50% more water in UTCI >35°C. Provide shaded water troughs and spray mister water over barn pens.
3. **Field Shade Tarps:** Install temporary mesh or palm-frond shade stations every 200 meters across work plots so workers don't walk far to recover.
4. **Salt Licks & Hydration:** Ensure field workers have access to clean salt-water solution or citrus-salt infusions.''';
    }

    if (q.contains('first aid') || q.contains('collapse') || q.contains('faint')) {
      return '''🚨 **Emergency Protocol: Worker Collapse on Site**

1. **Move Instantly:** Carry the person to the deepest available shade or ventilated shelter.
2. **Position:** Lay them on their back and elevate feet 30cm to restore blood circulation to the brain.
3. **Cool Rapidly:** Pour cool water over their chest, neck, and armpits. Fan vigorously with cardboard or cloths.
4. **Assess Consciousness:** If responsive, offer small sips of water. If unresponsive or confused, turn on their side (recovery position) and contact emergency medical assistance immediately.''';
    }

    // Default contextual response
    return '''💡 **AI Heat Guidance for ${role.label}**
Current Heat Stress: **$category (${utciVal.toStringAsFixed(1)}°C UTCI)**

Based on ERA5-HEAT reanalysis and occupational heat safety guidelines:
• **Work Scheduling:** Restrict intense manual tasks during peak solar radiation (12:00 PM – 3:30 PM).
• **Hydration Target:** Consume 250ml of clean drinking water every 20 minutes.
• **Cooling Tactic:** Keep neck and wrists cooled with damp cloths to lower core thermal strain.
• **Buddy Alert:** Watch your peers for fatigue, stumbling, or confusion — early intervention prevents heat exhaustion from escalating into life-threatening heat stroke.

*Tap the speaker button to hear this advice read aloud hands-free.*''';
  }
}
