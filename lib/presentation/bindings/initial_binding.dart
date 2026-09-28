import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../data/datasources/backend_remote_datasource.dart';
import '../../data/datasources/google_auth_datasource.dart';
import '../../data/datasources/hive_local_datasource.dart';
import '../../data/datasources/weather_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/status_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/status_repository.dart';
import '../../domain/services/ai_heat_advisor_service.dart';
import '../../services/location_service.dart';
import '../../services/notification_service.dart';
import '../../services/tts_service.dart';

/// Global/Core dependencies required throughout the entire app lifecycle,
/// regardless of which screen or route is loaded first.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HiveLocalDataSource(), permanent: true);
    Get.put(GoogleAuthDataSource(), permanent: true);
    Get.put(
      Dio(BaseOptions(baseUrl: AppConstants.backendBaseUrl)),
      permanent: true,
    );
    Get.put(BackendRemoteDataSource(Get.find()), permanent: true);

    // Weather API & Calculations
    Get.put(WeatherRemoteDataSource(Get.find<Dio>()), permanent: true);

    Get.put<AuthRepository>(
      AuthRepositoryImpl(Get.find(), Get.find()),
      permanent: true,
    );
    Get.put<StatusRepository>(
      StatusRepositoryImpl(
          Get.find(), Get.find(), Get.find<WeatherRemoteDataSource>()),
      permanent: true,
    );
    Get.put(NotificationService(), permanent: true);
    Get.put(LocationService(), permanent: true);

    // AI Heat Health Reasoning Engine
    Get.put(AiHeatAdvisorService(), permanent: true);

    // On-Device Text-To-Speech
    Get.put(TtsService(), permanent: true);
  }
}
