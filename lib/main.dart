import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monlivreur/ConstantsWidgets/notification_service.dart';
import 'package:monlivreur/Providers/ClientProviders/ClientColisProvider.dart';
import 'package:monlivreur/Providers/LivreurProviders/LivreurColisProvider.dart';
import 'package:monlivreur/Providers/LocationAdressProvider.dart';
import 'package:monlivreur/Providers/UserProvider/UserProvider.dart';
import 'package:monlivreur/Screens/Client/ClientScreens/MyParcel.dart';
import 'package:monlivreur/Screens/Client/ClientWidgets/BottomClientNavigation.dart';
import 'package:monlivreur/Screens/authentication/IntroScreen.dart';
import 'package:monlivreur/Screens/authentication/action_choose_screen.dart';

import 'package:monlivreur/Screens/livreur/LivreurScreens/MesCourse.dart';
import 'package:monlivreur/Screens/livreur/LivreurWidgets/BottomLivreurNavigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ConstantsWidgets/Constants.dart';
import 'ConstantsWidgets/firebase_options.dart';
import 'Providers/SignUp&LogIn/LoginProvider.dart';
import 'Providers/SommaireDetailsProvider.dart';
import 'Screens/authentication/login_phone_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationPluginService.initNotificationsPlugin(fromBackground: true);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  NotificationPluginService.initNotificationsPlugin();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _userToken;
  int? _userId;

  Future<String> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _isSeen = (prefs.getBool('isSeen') ?? false);
    bool _isLogin = (prefs.getBool('isLogin') ?? false);
    bool _isClient = (prefs.getBool('isClient') ?? false);
    _userId = prefs.getInt('userId');
    _userToken = prefs.getString('userToken');
    if (_isSeen) {
      if (_isLogin) {
        if (_isClient) {
          return 'isClient';
        } else {
          return 'isLivreur';
        }
      } else {
        return 'isLogOut';
      }
    } else {
      return 'isIntro';
    }
  }

  @override
  void initState() {
    checkFirstSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationAdressProvider>(
            create: (_) => LocationAdressProvider()),
        ChangeNotifierProvider<SommaireDetailsProvider>(
            create: (_) => SommaireDetailsProvider()),
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(_userId, _userToken),
        ),
        ChangeNotifierProxyProvider<LoginProvider, UserProvider>(
          create: (_) => UserProvider(_userId, _userToken),
          update: (ctx, auth, user) => UserProvider(auth.userId, auth.token),
        ),
        ChangeNotifierProxyProvider<LoginProvider, ClientColisProvider>(
          create: (_) => ClientColisProvider(
            '',
            '',
          ),
          update: (ctx, auth, oldColis) => ClientColisProvider(
            "${auth.token}",
            "${auth.userId}",
          ),
        ),
        ChangeNotifierProxyProvider<LoginProvider, LivreurColisProvider>(
          create: (_) => LivreurColisProvider(
            '',
            '',
          ),
          update: (ctx, auth, oldColis) => LivreurColisProvider(
            "${auth.token}",
            "${auth.userId}",
          ),
        ),
      ],
      child: FutureBuilder(
          future: checkFirstSeen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: PrimaryColorY,
                child: Center(),
              );
            } else {
              return MaterialApp(
                title: 'Mon Livreur',
                debugShowCheckedModeBanner: false,
                theme: MonLThemeData,
                // home: snapshot.data == 'isIntro'
                //     ? IntroScreen(): snapshot.data == 'isClient'
                //     ? BottomClientNavigation(): snapshot.data == 'isLivreur'
                //     ? BottomLivreurNavigation() : ActionChooseScreen(),
                // initialRoute: snapshot.data,
                routes: {
                  // When navigating to the "/" route, build the FirstScreen widget.
                  '/': (context) => snapshot.data == 'isIntro'
                      ? IntroScreen()
                      : snapshot.data == 'isClient'
                          ? BottomClientNavigation()
                          : snapshot.data == 'isLivreur'
                              ? BottomLivreurNavigation()
                              : ActionChooseScreen(),
                  '/loginScreenRoute': (context) => LogInPhoneScreen(),
                  '/actionRoute': (context) => const ActionChooseScreen(),

                  '/PublierLivreurAnnonce': (context) =>
                      const PublierLivreurAnnonce(),
                  '/bottomLivreurNavigation': (context) =>
                      BottomLivreurNavigation(),
                  '/bottomClientNavigation': (context) =>
                      BottomClientNavigation(),
                  '/MyParcel': (context) => MyParcel(),
                },
              );
            }
          }),
    );
  }
}
