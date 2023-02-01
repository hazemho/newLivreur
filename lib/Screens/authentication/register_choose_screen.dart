import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:monlivreur/Screens/authentication/phone_number_screen.dart';
import 'package:monlivreur/Screens/authentication/widget/default_action_button.dart';
import 'package:monlivreur/config/route_transition/fade_route.dart';
import 'package:monlivreur/config/themes/app_theme.dart';

class RegisterChooseScreen extends StatelessWidget {
  static String registerChooseScreenRoute = '/registerChooseScreenRoute';
  const RegisterChooseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 0.975,
          devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            backgroundColor: AppThemeMode.containerBackground,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Image.asset("assets/delivery-logo.png",
                      color: AppThemeMode.primaryColor, height: 180,)),


                const AutoSizeText("Bienvenue sur Mon Livreur", style: TextStyle(fontWeight: FontWeight.bold,
                    color: AppThemeMode.textColorBlack, fontSize: 24),),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15, vertical: 10
                  ),
                  child: AutoSizeText("La premiére application permettant de trouver un livreur pour récupérer vos colis et vous faire livrer partout en Côte d\'ivoire.",
                    style: TextStyle(color: AppThemeMode.textColorBlack, fontSize: 14), textAlign: TextAlign.center,),
                ),

                const Spacer(),
                DefaultActionButton(isLoading: false,
                  textButton: "Livreur",
                  onClickCallback: () {
                   /// context.router.navigate(PhoneNumberScreenRoute(userType: 1));
                    Navigator.pushReplacement(context, FadeRoute(page: PhoneNumberScreen(userType: 1)),);
                  },
                ),
                DefaultActionButton(isLoading: false,
                  textButton: "Client",
                  onClickCallback: () {
                   /// context.router.navigate(PhoneNumberScreenRoute(userType: 2));
                    Navigator.pushReplacement(context, FadeRoute(page: PhoneNumberScreen(userType: 2)),);
                  },
                ),
                const SizedBox(height: 15,)
              ],
            )
        ),
      ),
    );
  }
}
