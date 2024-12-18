// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA0qZVNfwX69kAZOM12x1MYllMgpSR2anU',
    appId: '1:757624174291:web:716adff34848f733508626',
    messagingSenderId: '757624174291',
    projectId: 'techi-social-app',
    authDomain: 'techi-social-app.firebaseapp.com',
    storageBucket: 'techi-social-app.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKM_Qf4ku4ugH1_Lz8Wj0Ey-GhJ7Q6uRg',
    appId: '1:757624174291:android:e810e5885575a9e9508626',
    messagingSenderId: '757624174291',
    projectId: 'techi-social-app',
    storageBucket: 'techi-social-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVe2o6YlLDnKxQPSapRqBdHNQMBGPyCmA',
    appId: '1:757624174291:ios:98a64987db7bb0fa508626',
    messagingSenderId: '757624174291',
    projectId: 'techi-social-app',
    storageBucket: 'techi-social-app.firebasestorage.app',
    iosBundleId: 'com.example.tisocial',
  );
}
