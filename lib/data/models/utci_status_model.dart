import 'package:hive/hive.dart';
import '../../core/utils/utci_calculator.dart';

part 'utci_status_model.g.dart';

@HiveType(typeId: 1)
class UtciStatusModel extends HiveObject {
  @HiveField(0)
  final String category; // no_stress / moderate / strong / very_strong / extreme
  @HiveField(1)
  final double value;
  @HiveField(2)
  final String city;
  @HiveField(3)
  final DateTime updatedAt;
  @HiveField(4)
  final String? suggestion; // AI-generated safety tip from the last alert, if any

  UtciStatusModel({
    required this.category,
    required this.value,
    required this.city,
    required this.updatedAt,
    this.suggestion,
  });

  String get categoryLabel => UtciCalculator.getCategoryLabel(category);
}
