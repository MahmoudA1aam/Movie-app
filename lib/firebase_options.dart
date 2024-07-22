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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAaXqh-STSWnWfOnLQYFm_KWnHoaYyA3wM',
    appId: '1:1045835687026:web:1c60632d216fce81d38eeb',
    messagingSenderId: '1045835687026',
    projectId: 'movie-e31a6',
    authDomain: 'movie-e31a6.firebaseapp.com',
    storageBucket: 'movie-e31a6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAh2QtQPVTc1O9fs7k-MPTJVYpvJWZgKH0',
    appId: '1:1045835687026:android:ba033d52f3556480d38eeb',
    messagingSenderId: '1045835687026',
    projectId: 'movie-e31a6',
    storageBucket: 'movie-e31a6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByIBrwlir2Y8u4v-yKcgjh_eyS46WOsdg',
    appId: '1:1045835687026:ios:4ec7ea23dc58ab65d38eeb',
    messagingSenderId: '1045835687026',
    projectId: 'movie-e31a6',
    storageBucket: 'movie-e31a6.appspot.com',
    iosBundleId: 'com.example.movie',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyByIBrwlir2Y8u4v-yKcgjh_eyS46WOsdg',
    appId: '1:1045835687026:ios:4ec7ea23dc58ab65d38eeb',
    messagingSenderId: '1045835687026',
    projectId: 'movie-e31a6',
    storageBucket: 'movie-e31a6.appspot.com',
    iosBundleId: 'com.example.movie',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAaXqh-STSWnWfOnLQYFm_KWnHoaYyA3wM',
    appId: '1:1045835687026:web:7d6ca1a38b288836d38eeb',
    messagingSenderId: '1045835687026',
    projectId: 'movie-e31a6',
    authDomain: 'movie-e31a6.firebaseapp.com',
    storageBucket: 'movie-e31a6.appspot.com',
  );

}