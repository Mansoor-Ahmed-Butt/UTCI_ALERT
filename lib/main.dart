import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'core/i18n/app_translations.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/hive_local_datasource.dart';
import 'firebase_options.dart';
import 'presentation/bindings/initial_binding.dart';
import 'presentation/controllers/theme_controller.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await HiveLocalDataSource().init();

  Get.put(ThemeController(), permanent: true);

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    final notificationService = NotificationService();
    await notificationService.handleTerminatedLaunch(
      onAlert: (_, __) => NotificationService.hadTerminatedLaunchAlert = true,
    );
  } catch (e, stackTrace) {
    debugPrint('Firebase initialization error: $e\n$stackTrace');
  }

  runApp(const UtciAlertApp());
}

class UtciAlertApp extends StatelessWidget {
  const UtciAlertApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(
      () => GetMaterialApp(
        title: 'UTCI Alert',
        debugShowCheckedModeBanner: false,
        translations: AppTranslations(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeController.themeMode.value,
        initialBinding: InitialBinding(),
        initialRoute: AppRoutes.home,
        getPages: AppPages.pages,
      ),
    );
  }
}
