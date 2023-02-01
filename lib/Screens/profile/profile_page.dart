import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monlivreur/Providers/SignUp&LogIn/LoginProvider.dart';
import 'package:monlivreur/Providers/UserProvider/UserProvider.dart';
import 'package:monlivreur/Screens/authentication/action_choose_screen.dart';

import 'package:monlivreur/Screens/authentication/widget/snack_bar_alert.dart';
import 'package:monlivreur/Screens/profile/password_screen.dart';
import 'package:monlivreur/Screens/profile/show_document_screen.dart';
import 'package:monlivreur/Screens/profile/update_document_screen.dart';
import 'package:monlivreur/Screens/profile/update_info_screen.dart';
import 'package:monlivreur/Screens/profile/update_phone_screen.dart';
import 'package:monlivreur/config/params/register_params.dart';
import 'package:monlivreur/config/route_transition/fade_route.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {

  final int? userType;
  final GlobalKey<NavigatorState>? nestedScreen;
  final VoidCallback voidCallback;
  const ProfilePage({Key? key, this.nestedScreen, this.userType, required this.voidCallback}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  File? _image;
  ImagePicker picker = ImagePicker();

  _imgFromCamera(BuildContext context, UserProvider loginProvider) {
    picker.pickImage(source: ImageSource.camera).then((value) {
      if(value != null){
        setState(() => _image = File(value.path));
        log('LOG : Get  Path Photo Response : ${_image!.path}');
        loginProvider.updateUserPhoto(
            value.path,
        ).then((value) {
          SnackBarAlert.show(context: context,
              description: value? "Success": "Failed");
        });
      }
    });
  }

  _imgFromGallery(BuildContext context, UserProvider loginProvider) async {
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if(value != null){
        setState(() => _image = File(value.path));
        log('LOG : Get  Path Photo Response : ${_image!.path}');
        loginProvider.updateUserPhoto(
            value.path
        ).then((value) {
          SnackBarAlert.show(context: context,
              description: value? "Success": "Failed");
        });
      }
    });
  }

  void _showPicker(context, UserProvider loginProvider) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context, isScrollControlled: true,
        isDismissible: true, clipBehavior: Clip.antiAlias,
        builder: (BuildContext context) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(color: AppThemeMode.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library, color: Colors.white,),
                    title: const Text('Galerie', style: TextStyle(color: Colors.white,),),
                    onTap: () {
                      _imgFromGallery(context, loginProvider);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera, color: Colors.white,),
                  title: const Text('Camera', style: TextStyle(color: Colors.white,),),
                  onTap: () {
                    _imgFromCamera(context, loginProvider);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
    );
  }

  String? fcmToken;

  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) {
      fcmToken =  value;
      debugPrint("Fcm Token: $fcmToken");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context, loginPd, _) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25,),
              InkWell(
                onTap: () => _showPicker(context, loginPd),
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: CircleAvatar(radius: 65,
                          backgroundColor: AppThemeMode.primaryColor,
                          backgroundImage: (_image != null ? FileImage(_image!)
                              : loginPd.userProfile?.photoprofileINFO != null
                              ? NetworkImage('${loginPd.userProfile?.photoprofileINFO}')
                              : AssetImage('assets/profilePic.png')) as ImageProvider,
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppThemeMode.primaryColor
                          ),
                          child: const Icon(Icons.camera_alt,
                            size: 26, color: AppThemeMode.textColorWhite,)
                      ),
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  widget.nestedScreen?.currentState?.push(FadeRoute(page:
                  UpdateInfoScreen(userType: widget.userType,
                    userEmail: loginPd.userProfile?.email,
                    userFirstName: loginPd.userProfile?.username,
                    userAddresse: loginPd.userProfile?.photoaddressINFO?.placeadresse,

                    filePermis: loginPd.userProfile?.photopermiINFO,
                    fileIdentite: loginPd.userProfile?.photocinINFO,
                    fileJustification: loginPd.userProfile?.photoaddressINFO?.photoadressephoto,
                  )));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 54, left: 25, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const Padding(
                        padding: EdgeInsets.only(right: 25),
                        child: Icon(Icons.person, size: 26,),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AutoSizeText("Nom & Prénom",
                            style: TextStyle(fontWeight: FontWeight.w500,
                                color: AppThemeMode.textColorBlack, fontSize: 12),),
                          AutoSizeText(loginPd.userProfile?.username ?? "",
                            style: TextStyle(fontWeight: FontWeight.w600,
                                color: AppThemeMode.textColorBlack, fontSize: 14),),
                        ],
                      ),

                      Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.edit_rounded, size: 20,),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 8, left: 25, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    const Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: Icon(Icons.email, size: 26,),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText("Addresse Email",
                          style: TextStyle(fontWeight: FontWeight.w500,
                              color: AppThemeMode.textColorBlack, fontSize: 12),),
                        AutoSizeText(loginPd.userProfile?.email ?? "",
                          style: TextStyle(fontWeight: FontWeight.w600,
                              color: AppThemeMode.textColorBlack, fontSize: 14),),
                      ],
                    ),

                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 8, left: 25, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    const Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: Icon(Icons.location_on_rounded, size: 26,),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText("Location",
                          style: TextStyle(fontWeight: FontWeight.w500,
                              color: AppThemeMode.textColorBlack, fontSize: 12),),
                        AutoSizeText(loginPd.userProfile?.photoaddressINFO?.placeadresse ?? "",
                          style: TextStyle(fontWeight: FontWeight.w600,
                              color: AppThemeMode.textColorBlack, fontSize: 14),),
                      ],
                    ),

                  ],
                ),
              ),

              InkWell(
                onTap: () {
                  widget.nestedScreen?.currentState?.push(FadeRoute(page:
                  UpdatePhoneScreen(
                      userCode: loginPd.userId,
                      phoneNumber: loginPd.userProfile?.phoneINFO
                  )));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 8, left: 25, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const Padding(
                        padding: EdgeInsets.only(right: 25),
                        child: Icon(Icons.phone, size: 26,),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AutoSizeText("Téléphone",
                            style: TextStyle(fontWeight: FontWeight.w500,
                                color: AppThemeMode.textColorBlack, fontSize: 12),),
                          AutoSizeText("+${loginPd.userProfile?.phoneINFO}",
                            style: TextStyle(fontWeight: FontWeight.w600,
                                color: AppThemeMode.textColorBlack, fontSize: 14),),
                        ],
                      ),
                      Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.edit_rounded, size: 20,),
                      ),
                    ],
                  ),
                ),
              ),

              Visibility(
                visible: widget.userType == 1,
                child: InkWell(
                  onTap: () {
                    widget.nestedScreen?.currentState?.push(FadeRoute(page:
                    ShowDocumentScreen(
                      filePermis: loginPd.userProfile?.photopermiINFO,
                      fileIdentite: loginPd.userProfile?.photocinINFO,
                      fileJustification: loginPd.userProfile?.photoaddressINFO?.photoadressephoto,
                      fileCarteGrise: loginPd.userProfile?.photovehiculeINFO?.photocgINFO,
                      filePlaque: loginPd.userProfile?.photovehiculeINFO?.photomatINFO,
                    )));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, left: 25, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const Padding(
                          padding: EdgeInsets.only(right: 25),
                          child: Icon(Icons.file_present_rounded, size: 26,),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText("Documents",
                              style: TextStyle(fontWeight: FontWeight.w500,
                                  color: AppThemeMode.textColorBlack, fontSize: 12),),
                            const AutoSizeText("Voir tous les documents",
                              style: TextStyle(fontWeight: FontWeight.w600,
                                  color: AppThemeMode.textColorBlack, fontSize: 14),),
                          ],
                        ),

                        Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(Icons.visibility, size: 20,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15
                ),
                child: Divider(height: 4,),
              ),


              InkWell(
                onTap: () {
                  widget.nestedScreen?.currentState?.push(FadeRoute(page:
                  PasswordScreen(
                    userCode: loginPd.userId,
                  )));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 8, left: 25, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const Padding(
                        padding: EdgeInsets.only(right: 25),
                        child: Icon(Icons.password, size: 26,),
                      ),

                      const AutoSizeText("Changer Votre Mot de Passe",
                        style: TextStyle(fontWeight: FontWeight.w600,
                            color: AppThemeMode.textColorBlack, fontSize: 14),),

                      Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.arrow_forward_ios_sharp, size: 20,),
                      ),
                    ],
                  ),
                ),
              ),

              Visibility(
                visible: widget.userType == 1,
                child: InkWell(
                  onTap: () {
                    widget.nestedScreen?.currentState?.push(FadeRoute(page:
                    UpdateDocumentScreen(userType: 2,
                      viheculeType: loginPd.userProfile?.photovehiculeINFO?.vehiculetype?.vehiculetype,
                      filePermis: loginPd.userProfile?.photopermiINFO,
                      fileIdentite: loginPd.userProfile?.photocinINFO,
                      filePlaque: loginPd.userProfile?.photovehiculeINFO?.photomatINFO,
                      fileCarteGrise: loginPd.userProfile?.photovehiculeINFO?.photocgINFO,
                      fileJustification: loginPd.userProfile?.photoaddressINFO?.photoadressephoto,
                    )));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, left: 25, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const Padding(
                          padding: EdgeInsets.only(right: 25),
                          child: Icon(Icons.car_crash_rounded, size: 26,),
                        ),

                        const AutoSizeText("Changer Votre Véhicule et Vos Papiers",
                          style: TextStyle(fontWeight: FontWeight.w600,
                              color: AppThemeMode.textColorBlack, fontSize: 14),),

                        Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(Icons.arrow_forward_ios_sharp, size: 20,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              InkWell(
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isLogin', false); prefs.reload();
                  Provider.of<UserProvider>(context, listen: false).logOut(fcmToken);
                  widget.voidCallback();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 8, left: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const Padding(
                        padding: EdgeInsets.only(right: 25),
                        child: Icon(Icons.logout_rounded, size: 26,),
                      ),

                      const AutoSizeText("Se déconnecter",
                        style: TextStyle(fontWeight: FontWeight.w600,
                            color: AppThemeMode.textColorBlack, fontSize: 14),)
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 45,),

            ],
          ),
        );
      }
    );
  }
}
