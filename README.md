# UTCI Alert — Flutter App

Heat-stress alerting app for outdoor workers, delivery riders, and
farmers. Built against `UTCI_Alert_App_Architecture`: GetX
(state/DI/routing) + a lightweight clean-architecture split
(data / domain / presentation), one entry screen (Sign-in +
Role-Selection) and one Home/Dashboard screen, Hive offline caching,
Firebase Auth (Google) + FCM, and on-device TTS for reading alerts
aloud.

This delivery contains the complete `lib/` source tree and
`pubspec.yaml` only — Flutter's Android/iOS platform folders,
`firebase_options.dart`, and generated Hive adapters are machine- and
project-specific, so they're generated locally in step 1–2 below
rather than shipped pre-built.

## Setup

1. **Scaffold platform folders** (this repo only ships `lib/`):
   ```bash
   flutter create --org com.yourcompany --project-name utci_alert .
   ```
   This adds `android/`, `ios/`, `test/`, etc. without touching the
   `lib/` and `pubspec.yaml` already in this folder (confirm no
   overwrite prompts touch `lib/`).

2. **Get packages:**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters** (`app_user_model.g.dart`,
   `utci_status_model.g.dart`):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Firebase:**
   - Create a Firebase project, enable **Authentication → Google**
     and **Cloud Messaging**.
   - Run `flutterfire configure` (from the `flutterfire_cli` package)
     to generate `lib/firebase_options.dart`, or manually drop
     `google-services.json` into `android/app/` and
     `GoogleService-Info.plist` into `ios/Runner/`.
   - If you use `flutterfire configure`, wire the generated
     `DefaultFirebaseOptions.currentPlatform` into
     `Firebase.initializeApp(options: ...)` in `lib/main.dart`.

5. **Environment:**
   ```bash
   cp .env.example .env
   # then edit .env with your deployed backend's base URL
   ```

6. **Android manifest / iOS Info.plist:** add the standard
   `google_sign_in`, `firebase_messaging` (notification permission,
   `POST_NOTIFICATIONS` on Android 13+), and `geolocator` (location
   usage description) entries per each package's own setup docs —
   these live in the platform folders `flutter create` generates in
   step 1, so they're not part of this `lib/`-only delivery.

7. **Run:**
   ```bash
   flutter run
   ```

## Notes

- The backend this app talks to (`POST /register`, `GET /status`,
  and the FCM payload shape `{ category, profile, suggestion }`) is
  the existing Node/Express + Firebase service described in the
  architecture doc's backend explainer — this repo is the client
  only.
- The AI-generated safety-suggestion feature lives entirely on that
  backend; the app only reads the extra `suggestion` field already
  wired in `NotificationService`.
- Two colors, everywhere: `lib/core/theme/app_colors.dart` is the one
  file allowed to declare a `Color(0x...)`. `StatusBadge`'s five UTCI
  category colors are variations on the same accent hue, not new
  brand colors.
