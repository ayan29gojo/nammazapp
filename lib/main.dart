import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled75/Screens/splash_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Object? firebaseInitError;
  try {
    if (kIsWeb) {
      final opts = DefaultFirebaseOptions.currentPlatform;

      // Fail fast if the placeholders are still there.
      if (opts.apiKey.startsWith('YOUR_') || opts.appId.startsWith('YOUR_')) {
        throw Exception(
          'Web Firebase config is not set. Open lib/firebase_options.dart and replace '
          'YOUR_WEB_* values with the real values from Firebase Console -> Project settings -> Web app.',
        );
      }

      await Firebase.initializeApp(options: opts);
    } else {
      // Android can use google-services.json.
      await Firebase.initializeApp();
    }
  } catch (e) {
    firebaseInitError = e;
  }

  runApp(MyApp(firebaseInitError: firebaseInitError));
}

class MyApp extends StatelessWidget {
  final Object? firebaseInitError;

  const MyApp({super.key, this.firebaseInitError});

  @override
  Widget build(BuildContext context) {
    if (firebaseInitError != null) {
      return MaterialApp(
        title: 'Namaz Tracker',
        home: Scaffold(
          appBar: AppBar(title: const Text('Firebase init failed')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Firebase could not initialize.\n\n'
              'WEB FIX (recommended):\n'
              '1) Firebase Console -> Add app -> Web\n'
              '2) Copy config values\n'
              '3) Paste into lib/firebase_options.dart (replace YOUR_WEB_*)\n\n'
              'Error: $firebaseInitError',
            ),
          ),
        ),
      );
    }

    return const MaterialApp(
      title: 'Namaz Tracker',
      home: SplashScreen(),
    );
  }
}
