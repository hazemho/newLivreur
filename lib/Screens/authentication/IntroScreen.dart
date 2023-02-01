
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:monlivreur/Screens/authentication/action_choose_screen.dart';

import 'package:monlivreur/config/route_transition/fade_route.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:monlivreur/config/utils/intro_data.dart';
import 'package:shared_preferences/shared_preferences.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        showSkipButton: true, skipOrBackFlex: 0, nextFlex: 0,
        bodyPadding: const EdgeInsets.only(top: 25),
        pages: IntroData.introDataList.map((intro) {
          return PageViewModel(
            title: intro.title,
            body: intro.description,
            image: Image.asset(intro.imagePath,)
          );
        }).toList(),

        back: const Icon(Icons.arrow_back, color: AppThemeMode.primaryColor,),
        skip: const Text('Passer', style: TextStyle(
          fontWeight: FontWeight.w600, color: AppThemeMode.primaryColor,)),
        next: const Icon(Icons.arrow_forward, color: AppThemeMode.primaryColor,),
        done: const Text('Terminer', style: TextStyle(
          fontWeight: FontWeight.w600, color: AppThemeMode.primaryColor,)),

        onDone: () async {
          /// injector<LocalStorageService>().isIntroEnable();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isSeen', true);
          Navigator.pushReplacement(context, FadeRoute(page: ActionChooseScreen()),);
        },
        onSkip: () async {
          /// injector<LocalStorageService>().isIntroEnable();
          /// context.router.replace(const LoginScreenRoute());
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isSeen', true);
          Navigator.pushReplacement(context, FadeRoute(page: ActionChooseScreen()),);
       },
      ),
    );
  }
}
