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
    apiKey: 'AIzaSyAB2xnGXl4xgPC7DcH-pMpPZEvQOg0i3bs',
    appId: '1:523238709382:web:64fdf774581557dd245907',
    messagingSenderId: '523238709382',
    projectId: 'udem-88794',
    authDomain: 'udem-88794.firebaseapp.com',
    databaseURL: 'https://udem-88794-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'udem-88794.appspot.com',
    measurementId: 'G-M0P4M49P6Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZeGV3KQ5ksJPOzhPXR7uFX-uqG-YrDTY',
    appId: '1:523238709382:android:393b0ea25ed28f28245907',
    messagingSenderId: '523238709382',
    projectId: 'udem-88794',
    databaseURL: 'https://udem-88794-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'udem-88794.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7UpeVmTAokPBU3whxejiEMnH2izJrQNc',
    appId: '1:523238709382:ios:888b4684b117ce11245907',
    messagingSenderId: '523238709382',
    projectId: 'udem-88794',
    databaseURL: 'https://udem-88794-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'udem-88794.appspot.com',
    iosClientId: '523238709382-om2fmep7jlvshdogiraqb3qf5uc2bvjd.apps.googleusercontent.com',
    iosBundleId: 'com.example.udemyFlutterChat',
  );
}
