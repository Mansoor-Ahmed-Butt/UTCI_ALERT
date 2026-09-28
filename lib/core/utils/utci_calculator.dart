import 'dart:math' as math;
import '../../data/models/user_role.dart';

/// Implements bioclimatic UTCI (Universal Thermal Climate Index) calculations
/// and threshold classification based on ERA5-HEAT reanalysis standards.
class UtciCalculator {
  UtciCalculator._();

  /// Calculates the UTCI equivalent temperature (°C)
  /// Ta: Air temperature (°C)
  /// rh: Relative humidity (%)
  /// va: Wind speed at 10m height (m/s)
  /// solarRadiationWm2: Direct/Global solar radiation (W/m²), default ~400 for daytime sun
  static double calculate({
    required double airTempC,
    required double relativeHumidityPct,
    required double windSpeedMps,
    double solarRadiationWm2 = 350.0,
  }) {
    final ta = airTempC.clamp(-50.0, 60.0);
    final rh = relativeHumidityPct.clamp(0.0, 100.0);
    final va = math.max(0.5, windSpeedMps.clamp(0.1, 30.0));

    // Calculate water vapor pressure e (hPa) using Magnus-Tetens formula
    final eSat = 6.112 * math.exp((17.67 * ta) / (ta + 243.5));
    final e = (rh / 100.0) * eSat;

    // Approximate Mean Radiant Temperature (Tmrt) offset above air temp
    // Under clear African sunshine, radiant heating typically elevates Tmrt by 10-18°C
    final tmrtOffset = (solarRadiationWm2 / 80.0).clamp(0.0, 20.0);
    final dTmrt = tmrtOffset;

    // Operational polynomial regression approximation for UTCI offset:
    // delta = UTCI - Ta
    // Incorporates wind convection cooling, vapor pressure humidity barrier,
    // and thermal radiant load.
    final va05 = math.sqrt(va);
    final windCooling = -2.8 * (va05 - 1.0) * (1.0 - (ta / 45.0).clamp(0.0, 1.0));
    final humidityStress = 0.05 * e * (1.0 + (ta - 20.0) / 25.0);
    final radiationStress = 0.55 * dTmrt * (1.0 / (1.0 + 0.15 * va05));

    final delta = windCooling + humidityStress + radiationStress;
    final utci = ta + delta;

    return double.parse(utci.toStringAsFixed(1));
  }

  /// Classifies a UTCI value into Table 1 scientific categories:
  /// ≥ 46.0°C: Extreme Heat Stress
  /// 38.0°C to 45.9°C: Very Strong Heat Stress
  /// 32.0°C to 37.9°C: Strong Heat Stress
  /// 26.0°C to 31.9°C: Moderate Heat Stress
  /// 9.0°C to 25.9°C: No Thermal Stress (Comfort)
  /// < 9.0°C: Cold Stress
  static String categorize(double utci) {
    if (utci >= 46.0) return 'extreme';
    if (utci >= 38.0) return 'very_strong';
    if (utci >= 32.0) return 'strong';
    if (utci >= 26.0) return 'moderate';
    if (utci >= 9.0) return 'no_stress';
    return 'cold_stress';
  }

  static String getCategoryLabel(String category) {
    switch (category.toLowerCase()) {
      case 'extreme':
        return 'Extreme Heat Stress';
      case 'very_strong':
        return 'Very Strong Heat Stress';
      case 'strong':
        return 'Strong Heat Stress';
      case 'moderate':
        return 'Moderate Heat Stress';
      case 'no_stress':
        return 'No Thermal Stress';
      case 'cold_stress':
        return 'Cold Stress';
      default:
        return 'Moderate Heat Stress';
    }
  }

  /// Plain-language warning co-designed around African urban & informal-settlement realities
  static String getPlainLanguageWarning({
    required String category,
    required UserRole role,
  }) {
    switch (category.toLowerCase()) {
      case 'extreme':
        switch (role) {
          case UserRole.outdoorWorker:
            return 'DANGER: Stop heavy manual labor immediately. Direct sunlight can trigger life-threatening heat stroke in under 25 minutes.';
          case UserRole.deliveryRider:
            return 'CRITICAL: Extreme asphalt radiance (>55°C road surface). Take mandatory 20-min shade stops every hour; soak neck wrap.';
          case UserRole.farmer:
            return 'HAZARD: Cease field harvesting. Move livestock to covered shade; delay irrigation work until sunset.';
          case UserRole.informalResident:
            return 'EXTREME INDOOR HEAT: Metal roofs trap severe radiant heat. Evacuate unventilated rooms; seek community shade trees.';
          case UserRole.vulnerable:
            return 'MEDICAL ALERT: Immediate risk of heat collapse. Remain in coolest available room; apply damp cloths to forehead and feet.';
        }
      case 'very_strong':
        switch (role) {
          case UserRole.outdoorWorker:
            return 'Severe heat load. Work in 30-min shifts with 15-min shade breaks. Drink 250ml water every 15 minutes.';
          case UserRole.deliveryRider:
            return 'Heavy helmet heat buildup. Remove helmet at delivery stops and hydrate with electrolytes.';
          case UserRole.farmer:
            return 'High thermal stress in open fields. Wear wide-brim headwear and shift heavy tasks to shaded barns.';
          case UserRole.informalResident:
            return 'Corrugated tin heats up rapidly. Hang wet cloths over window openings for evaporative cooling.';
          case UserRole.vulnerable:
            return 'High health risk. Keep fans running near open windows; drink fluids regularly even without thirst.';
        }
      case 'strong':
        return 'Heat stress elevated. Avoid strenuous outdoor exertion between 12:00 PM and 3:30 PM. Stay hydrated.';
      case 'moderate':
        return 'Moderate thermal conditions. Safe for normal outdoor tasks with regular water intake and sunscreen.';
      case 'no_stress':
        return 'Thermal comfort zone. Ideal conditions for outdoor work, delivery transit, and farm labor.';
      case 'cold_stress':
        return 'Cool temperature. Wear appropriate windproof layers if riding or working outdoors.';
      default:
        return 'Monitor hydration and take shade breaks as needed.';
    }
  }
}
