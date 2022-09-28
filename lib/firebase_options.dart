// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
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
    apiKey: 'AIzaSyC6lwdPVn2VSfy3NxfQ_giqxaAaKe1IH2U',
    appId: '1:102049305394:web:11901173e50a46856b3d2b',
    messagingSenderId: '102049305394',
    projectId: 'first-firebase-app-dee34',
    authDomain: 'first-firebase-app-dee34.firebaseapp.com',
    storageBucket: 'first-firebase-app-dee34.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCl6v08uYSYbnksuYyFxBaQWi0XPFU1Y_s',
    appId: '1:102049305394:android:8aed193570c7a24a6b3d2b',
    messagingSenderId: '102049305394',
    projectId: 'first-firebase-app-dee34',
    storageBucket: 'first-firebase-app-dee34.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAPue_WBRuvmRefNXJ8mwqXJm97JJ1bMpI',
    appId: '1:102049305394:ios:458fc09c081a1dcd6b3d2b',
    messagingSenderId: '102049305394',
    projectId: 'first-firebase-app-dee34',
    storageBucket: 'first-firebase-app-dee34.appspot.com',
    iosClientId: '102049305394-p9h1r7j9s0euvhn4d0ms3uecuvblmop1.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAPue_WBRuvmRefNXJ8mwqXJm97JJ1bMpI',
    appId: '1:102049305394:ios:458fc09c081a1dcd6b3d2b',
    messagingSenderId: '102049305394',
    projectId: 'first-firebase-app-dee34',
    storageBucket: 'first-firebase-app-dee34.appspot.com',
    iosClientId: '102049305394-p9h1r7j9s0euvhn4d0ms3uecuvblmop1.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseApp',
  );
}