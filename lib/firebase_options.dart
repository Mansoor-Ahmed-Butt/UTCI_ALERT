import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Generated / fallback configuration for Firebase initialization.
/// Values can be customized via `.env` or replaced by running `flutterfire configure`.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions get android => FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_ANDROID_API_KEY'] ?? 'AIzaSyDemoKeyAndroid1234567890abcdef',
        appId: dotenv.env['FIREBASE_ANDROID_APP_ID'] ?? '1:123456789012:android:abcdef1234567890abcdef',
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '123456789012',
        projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? 'utci-alert',
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? 'utci-alert.appspot.com',
      );

  static FirebaseOptions get ios => FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_IOS_API_KEY'] ?? 'AIzaSyDemoKeyIOS1234567890abcdef',
        appId: dotenv.env['FIREBASE_IOS_APP_ID'] ?? '1:123456789012:ios:abcdef1234567890abcdef',
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '123456789012',
        projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? 'utci-alert',
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? 'utci-alert.appspot.com',
        iosBundleId: 'com.example.utciAlert',
      );

  static FirebaseOptions get web => FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_WEB_API_KEY'] ?? 'AIzaSyDemoKeyWeb1234567890abcdef',
        appId: dotenv.env['FIREBASE_WEB_APP_ID'] ?? '1:123456789012:web:abcdef1234567890abcdef',
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '123456789012',
        projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? 'utci-alert',
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? 'utci-alert.appspot.com',
      );
}
