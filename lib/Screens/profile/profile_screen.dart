import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/SignUp&LogIn/LoginProvider.dart';
import 'package:monlivreur/Providers/UserProvider/UserProvider.dart';
import 'package:monlivreur/Screens/authentication/action_choose_screen.dart';
import 'package:monlivreur/Screens/profile/password_screen.dart';
import 'package:monlivreur/Screens/profile/profile_page.dart';
import 'package:monlivreur/Screens/profile/show_document_screen.dart';
import 'package:monlivreur/Screens/profile/update_document_screen.dart';
import 'package:monlivreur/Screens/profile/update_info_screen.dart';
import 'package:monlivreur/Screens/profile/update_phone_screen.dart';
import 'package:monlivreur/Screens/authentication/widget/default_action_button.dart';
import 'package:monlivreur/Screens/authentication/widget/snack_bar_alert.dart';
import 'package:monlivreur/config/params/register_params.dart';
import 'package:monlivreur/config/route_transition/fade_route.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {

  final int? userType;
  const ProfileScreen({Key? key, this.userType}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final nestedScreen = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 0.975,
            devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
        child: SafeArea(
            top: false,
            bottom: false,
            child: Navigator(
              key: nestedScreen,
              onGenerateRoute: (route) => MaterialPageRoute(settings: route,
                builder: (cxt) => Scaffold(
                  backgroundColor: AppThemeMode.containerBackground,
                  appBar: AppBar(elevation: 0.2, centerTitle: true,
                    backgroundColor: AppThemeMode.primaryColor,
                    title: const AutoSizeText("Profile",
                      style: TextStyle(fontWeight: FontWeight.w600,
                          color: AppThemeMode.textColorWhite, fontSize: 20),),
                  ),
                  body: FutureBuilder(
                      future: Provider.of<UserProvider>(cxt, listen: false).getUserProfile(),
                      builder: (ctx, dataSnapshot) {
                        print(dataSnapshot.connectionState);
                        if (dataSnapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(
                            color: PrimaryColorY,));
                        } else {
                          if (dataSnapshot.connectionState == ConnectionState.none) {
                            return Center(child: Text('il n\'y a accune announce pour le moment '),);
                          } else {
                            if (dataSnapshot.error != null) {
                              print(dataSnapshot.error);
                              // ...()
                              // Do error handling stuff
                              return Center(
                                child: Text('une erreur est survenue'),
                              );
                            } else {
                              return ProfilePage(
                                nestedScreen: nestedScreen,
                                userType: widget.userType,
                                voidCallback: () => Navigator.pushReplacement(context,
                                  FadeRoute(page: ActionChooseScreen()),),
                              );
                            }
                          }
                        }
                      }),
                )
              ),
            ),
        )
    );
  }
}
