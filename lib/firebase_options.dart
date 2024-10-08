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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvp2hNXMkpnwDObrzJEb1h2F1jRxW6yrM',
    appId: '1:674937610549:android:ce48bf664d86a3f117ec7c',
    messagingSenderId: '674937610549',
    projectId: 'instagram-clone-course-app',
    storageBucket: 'instagram-clone-course-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDAM-cgplP4qV4KMKcT6WlIw2_RDepxRKo',
    appId: '1:674937610549:ios:ee3f6037d2f2f0c517ec7c',
    messagingSenderId: '674937610549',
    projectId: 'instagram-clone-course-app',
    storageBucket: 'instagram-clone-course-app.appspot.com',
    androidClientId: '674937610549-q2jcmtt54hcc80ve5eu6kpmmvs1gu5ap.apps.googleusercontent.com',
    iosClientId: '674937610549-5ndevcv7abe4levugqrhf7jsrhh82i8m.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagramCloneApp',
  );

}