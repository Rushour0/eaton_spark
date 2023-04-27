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
    apiKey: 'AIzaSyBxwagZTqR95K-88jwMa4BQP57XGt5xw3Q',
    appId: '1:57566578344:web:89be3e4783d7060f76649d',
    messagingSenderId: '57566578344',
    projectId: 'eaton-spark',
    authDomain: 'eaton-spark.firebaseapp.com',
    storageBucket: 'eaton-spark.appspot.com',
    measurementId: 'G-KPTS5PSH8Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBy9nNjgurHdFDfowd_iMayzyy8rD8a34c',
    appId: '1:57566578344:android:c2837a80ddea6eb576649d',
    messagingSenderId: '57566578344',
    projectId: 'eaton-spark',
    storageBucket: 'eaton-spark.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTQ6gbXO3Ay0w5Rr_BON_1MlNb-OGF6ZI',
    appId: '1:57566578344:ios:ff3c2ba0b998637c76649d',
    messagingSenderId: '57566578344',
    projectId: 'eaton-spark',
    storageBucket: 'eaton-spark.appspot.com',
    iosClientId: '57566578344-pj9d91i73nknauueg6q77fvqqqg4ogd4.apps.googleusercontent.com',
    iosBundleId: 'com.example.eatonSpark',
  );
}
