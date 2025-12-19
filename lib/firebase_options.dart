import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kIsWeb;

/// Prefer generating this file via: `flutterfire configure`.
///
/// For Android, this project already has `android/app/google-services.json` so
/// you can also initialize without options.
/// For Web, you MUST set proper values (either here, or via dart-defines).
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return webFromEnvironment();
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform. '
          'Run `flutterfire configure` to generate options.',
        );
    }
  }

  /// ANDROID (from android/app/google-services.json)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAethhfn0TkdYFkEWKCmCL_1JBoamOiD5o',
    appId: '1:264523302252:android:cab5b0ab4f1b151c4f1f49',
    messagingSenderId: '264523302252',
    projectId: 'namaztracker1',
    storageBucket: 'namaztracker1.firebasestorage.app',
  );

  /// WEB (recommended: paste values from Firebase Console)
  static FirebaseOptions webFromEnvironment() {
    const apiKey = String.fromEnvironment('FIREBASE_API_KEY');
    const appId = String.fromEnvironment('FIREBASE_APP_ID');
    const messagingSenderId = String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
    const projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');

    // Optional
    const authDomain = String.fromEnvironment('FIREBASE_AUTH_DOMAIN');
    const storageBucket = String.fromEnvironment('FIREBASE_STORAGE_BUCKET');
    const measurementId = String.fromEnvironment('FIREBASE_MEASUREMENT_ID');

    // If defines aren't provided, fall back to placeholders.
    if (apiKey.isEmpty || appId.isEmpty || messagingSenderId.isEmpty || projectId.isEmpty) {
      return web;
    }

    return FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      authDomain: authDomain.isEmpty ? null : authDomain,
      storageBucket: storageBucket.isEmpty ? null : storageBucket,
      measurementId: measurementId.isEmpty ? null : measurementId,
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyBdxjmHw81LjoF4ebcJmR3Hn-e3jEqnZvQ",
      authDomain: "namaztracker1.firebaseapp.com",
      projectId: "namaztracker1",
      storageBucket: "namaztracker1.firebasestorage.app",
      messagingSenderId: "264523302252",
      appId: "1:264523302252:web:faf74119f9829c444f1f49",
      measurementId: "G-B80DSXF1M7"
  );
}
