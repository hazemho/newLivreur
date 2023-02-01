import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2pFj6xkpMUzaHo3RN3x4Ut6wzpjUwIMM',
    appId: '1:424710215206:android:921d72ebff13f8bfaef8e7',
    messagingSenderId: '424710215206',
    projectId: 'monlivreur-2737e',
    storageBucket: 'monlivreur-2737e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChrjr0JOEd7RpBH-jbdAYFeB7fxo0STFI',
    appId: '1:620476995022:ios:4d682c2623111ef5c9879f',
    messagingSenderId: '620476995022',
    projectId: 'fire-app-757',
    storageBucket: 'fire-app-757.appspot.com',
    iosClientId: '620476995022-nomfer0o2bstem8mtjkjr52to58nq4m9.apps.googleusercontent.com',
    iosBundleId: 'com.example.monlivreur',
  );
}
