import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/Providers/SignUp&LogIn/LoginProvider.dart';
import 'package:monlivreur/Screens/authentication/action_choose_screen.dart';
import 'package:monlivreur/Screens/authentication/login_phone_screen.dart';
import 'package:monlivreur/Screens/authentication/widget/default_action_button.dart';
import 'package:monlivreur/Screens/authentication/widget/easy_dialog.dart';
import 'package:monlivreur/Screens/authentication/widget/item_document_diver.dart';
import 'package:monlivreur/Screens/authentication/widget/snack_bar_alert.dart';
import 'package:monlivreur/config/params/register_params.dart';
import 'package:monlivreur/config/route_transition/fade_route.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:monlivreur/config/utils/driver_document_data.dart';
import 'package:provider/provider.dart';



class DriverDocumentScreen extends StatefulWidget {

  final RegisterParams registerParams;
  const DriverDocumentScreen({Key? key, required this.registerParams,}) : super(key: key);

  @override
  DriverDocumentScreenState createState() => DriverDocumentScreenState();
}

class DriverDocumentScreenState extends State<DriverDocumentScreen> {

  bool isLoadingProgress = false;
  bool requiredDocument = false;

  File? filePermis;
  File? fileIdentite;
  File? fileCarteGrise;
  File? filePlaque;
  File? fileJustification;

  late RegisterParams registerParams;

  void onButtonClick(BuildContext context) async {
    registerParams = RegisterParams(
      id_phone: widget.registerParams.id_phone,
      id_user_type: widget.registerParams.id_user_type,
      id_type_vehicule: widget.registerParams.id_type_vehicule,

      email: widget.registerParams.email,
      firstname: widget.registerParams.firstname,
      lastname: widget.registerParams.lastname,
      password: widget.registerParams.password,
      password_confirmation: widget.registerParams.password_confirmation,
      placeadresse: widget.registerParams.placeadresse,

      permis_path: filePermis, pieceidentite_path: fileIdentite,
      cartegrise_path: fileCarteGrise, plaque_path: filePlaque,
      justification_path: fileJustification
    );

    if((widget.registerParams.id_type_vehicule == 1
        && fileJustification != null && fileIdentite != null)

        || (widget.registerParams.id_type_vehicule != 1
            && filePermis != null && fileCarteGrise != null
            && filePlaque != null && fileIdentite != null)){
      setState(() => isLoadingProgress = true);
      Provider.of<LoginProvider>(context, listen: false).register(
          registerParams
      ).then((value) {
        setState(() => isLoadingProgress = false);
        if(value.userMessage?.token != null){
          EasyDialog(
              title: const Text("Inscription",
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.2, textAlign: TextAlign.center,
              ),
              description: const Text("Votre compte à été créé avec succès, attendez la confirmation d'admin",
                textScaleFactor: 1.1, textAlign: TextAlign.center,
              )).show(context);
          Future.delayed(Duration(seconds: 4), () {
            Navigator.pushReplacement(context, FadeRoute(page: ActionChooseScreen()),);
          });
        } else {
          SnackBarAlert.show(context: context, description: value.userMessage?.msg);
        }});
    } else {
      setState(() => requiredDocument = true);
      EasyDialog(
          title: const Text("Conditions d'inscription",
            style: TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 1.2, textAlign: TextAlign.center,
          ),
          description: const Text("Veuillez télécharger les documents requis !",
            textScaleFactor: 1.1, textAlign: TextAlign.center,
          )).show(context);
    }

  }


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
          body: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 30,),
                  child: Column(
                    children: [

                      Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          child: Image.asset("assets/delivery-logo.png",
                            color: AppThemeMode.primaryColor, height: 90,)),

                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.9,
                        child: const AutoSizeText("Inscription",
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color: AppThemeMode.textColorBlack, fontSize: 24),),
                      ),

                      Container(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        width: MediaQuery.of(context).size.width*0.9,
                        child: const AutoSizeText("Merci de nous envoyer vos documents afin de vérifier votre compte livreur",
                          style: TextStyle(color: AppThemeMode.textColorBlack, fontSize: 14),),
                      ),


                      GridView.builder(shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: DriverDocumentData.listDriverDocumentData.length,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1.56,
                            crossAxisSpacing: 12, mainAxisSpacing: 12,
                            mainAxisExtent: MediaQuery.of(context).size.height * 0.2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return ItemDocumentDiver(requiredDocument: requiredDocument && [0, 1, 2, 3].contains(index),
                              driverDocumentData: DriverDocumentData.listDriverDocumentData.elementAt(index),
                              voidCallback: (File? document) {
                                switch(index) {
                                  case 0: filePermis = document;
                                    break;
                                  case 1: fileCarteGrise = document;
                                    break;
                                  case 2: fileIdentite = document;
                                    break;
                                  case 3: filePlaque = document;
                                    break;
                                  case 4: fileJustification = document;
                                    break;
                                }
                              },
                            );
                          })
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultActionButton(
                        isLoading: isLoadingProgress,
                        textButton: "S'inscrire",
                        onClickCallback: () => onButtonClick(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 20
                        ),
                        child: RichText(
                          text: TextSpan(text: 'Vous avez déjà un compte ?',
                              style: TextStyle(color: AppThemeMode.textColorBlack, fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(text: ' Connexion', style: TextStyle(
                                    color: AppThemeMode.primaryColor, fontSize: 14),
                                  recognizer: TapGestureRecognizer()..onTap = () =>
                                      Navigator.pushReplacement(context, FadeRoute(page: LogInPhoneScreen()),),
                                )
                              ]
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
