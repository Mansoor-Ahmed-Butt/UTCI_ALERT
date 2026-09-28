import 'package:flutter_test/flutter_test.dart';
import 'package:utci_alert/core/utils/utci_calculator.dart';
import 'package:utci_alert/data/models/user_role.dart';
import 'package:utci_alert/data/models/utci_status_model.dart';
import 'package:utci_alert/domain/services/ai_heat_advisor_service.dart';

void main() {
  group('UtciCalculator Tests', () {
    test('Calculates UTCI value in reasonable physiological range', () {
      final utci = UtciCalculator.calculate(
        airTempC: 38.0,
        relativeHumidityPct: 45.0,
        windSpeedMps: 2.0,
        solarRadiationWm2: 600.0,
      );

      expect(utci, greaterThan(35.0));
      expect(utci, lessThan(55.0));
    });

    test('Classifies UTCI into Table 1 scientific categories correctly', () {
      expect(UtciCalculator.categorize(48.0), 'extreme');
      expect(UtciCalculator.categorize(46.0), 'extreme');
      expect(UtciCalculator.categorize(42.0), 'very_strong');
      expect(UtciCalculator.categorize(38.0), 'very_strong');
      expect(UtciCalculator.categorize(35.0), 'strong');
      expect(UtciCalculator.categorize(32.0), 'strong');
      expect(UtciCalculator.categorize(28.0), 'moderate');
      expect(UtciCalculator.categorize(26.0), 'moderate');
      expect(UtciCalculator.categorize(22.0), 'no_stress');
      expect(UtciCalculator.categorize(5.0), 'cold_stress');
    });

    test('Generates role-tailored plain-language warnings', () {
      final warningRider = UtciCalculator.getPlainLanguageWarning(
        category: 'extreme',
        role: UserRole.deliveryRider,
      );
      expect(warningRider.toLowerCase(), contains('asphalt'));

      final warningWorker = UtciCalculator.getPlainLanguageWarning(
        category: 'extreme',
        role: UserRole.outdoorWorker,
      );
      expect(warningWorker.toLowerCase(), contains('heavy manual labor'));

      final warningInformal = UtciCalculator.getPlainLanguageWarning(
        category: 'extreme',
        role: UserRole.informalResident,
      );
      expect(warningInformal.toLowerCase(), contains('metal roofs'));
    });
  });

  group('AiHeatAdvisorService Tests', () {
    final aiService = AiHeatAdvisorService();

    test('Generates dynamic advice based on status and user role', () {
      final status = UtciStatusModel(
        category: 'very_strong',
        value: 41.5,
        city: 'Kano, Nigeria',
        updatedAt: DateTime.now(),
      );

      final advice = aiService.generateDynamicAdvice(
        status: status,
        role: UserRole.deliveryRider,
      );

      expect(advice.headline.isNotEmpty, isTrue);
      expect(advice.workRestCycle.isNotEmpty, isTrue);
      expect(advice.hydrationGoal.isNotEmpty, isTrue);
      expect(advice.profileAction.isNotEmpty, isTrue);
    });

    test('Answers specific chat queries intelligently', () async {
      final status = UtciStatusModel(
        category: 'very_strong',
        value: 40.0,
        city: 'Cairo, Egypt',
        updatedAt: DateTime.now(),
      );

      final answerHydration = await aiService.answerQuery(
        query: 'What is my hourly hydration goal?',
        currentStatus: status,
        role: UserRole.outdoorWorker,
      );
      expect(answerHydration.toLowerCase(), contains('hydration'));
      expect(answerHydration.toLowerCase(), contains('water'));

      final answerRoof = await aiService.answerQuery(
        query: 'How to cool a tin roof informal home?',
        currentStatus: status,
        role: UserRole.informalResident,
      );
      expect(answerRoof.toLowerCase(), contains('evaporative'));
      expect(answerRoof.toLowerCase(), contains('whitewash'));
    });
  });

  group('UserRole Enum Tests', () {
    test('Resolves backendKey correctly', () {
      expect(UserRole.fromBackendKey('outdoor_worker'), UserRole.outdoorWorker);
      expect(UserRole.fromBackendKey('delivery_rider'), UserRole.deliveryRider);
      expect(UserRole.fromBackendKey('farmer'), UserRole.farmer);
      expect(UserRole.fromBackendKey('informal_resident'), UserRole.informalResident);
      expect(UserRole.fromBackendKey('vulnerable'), UserRole.vulnerable);
      // Fallback
      expect(UserRole.fromBackendKey('unknown_key'), UserRole.outdoorWorker);
    });
  });
}
