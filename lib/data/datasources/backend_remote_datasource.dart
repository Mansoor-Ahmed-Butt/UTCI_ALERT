import 'package:dio/dio.dart';
import '../models/utci_status_model.dart';

/// The single client for the Node/Express backend. This is the ONLY
/// file in the app that knows the backend's base URL or route shape —
/// if the backend URL or payload ever changes, this is the one file
/// to touch.
class BackendRemoteDataSource {
  final Dio _dio;
  BackendRemoteDataSource(this._dio);

  Future<void> registerDevice({
    required String fcmToken,
    required String city,
    required double lat,
    required double lon,
    required String profile, // UserRole.backendKey
  }) async {
    await _dio.post('/register', data: {
      'fcmToken': fcmToken,
      'city': city,
      'lat': lat,
      'lon': lon,
      'profile': profile,
    });
  }

  /// Fetches the latest UTCI reading for a city, used to refresh the
  /// dashboard once connectivity is available (falls back to the
  /// Hive-cached value when this fails or there's no connection).
  Future<UtciStatusModel> fetchStatus({required String city}) async {
    final response = await _dio.get('/status', queryParameters: {'city': city});
    final data = response.data as Map<String, dynamic>;
    return UtciStatusModel(
      category: data['category'] as String,
      value: (data['value'] as num).toDouble(),
      city: city,
      updatedAt: DateTime.now(),
      suggestion: data['suggestion'] as String?,
    );
  }
}
