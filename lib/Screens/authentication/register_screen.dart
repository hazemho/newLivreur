import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:monlivreur/Providers/SignUp&LogIn/LoginProvider.dart';
import 'package:monlivreur/Screens/authentication/action_choose_screen.dart';
import 'package:monlivreur/Screens/authentication/car_choose_screen.dart';
import 'package:monlivreur/Screens/authentication/login_phone_screen.dart';

import 'package:monlivreur/Screens/authentication/widget/default_action_button.dart';
import 'package:monlivreur/Screens/authentication/widget/easy_dialog.dart';
import 'package:monlivreur/Screens/authentication/widget/snack_bar_alert.dart';
import 'package:monlivreur/config/params/register_params.dart';
import 'package:monlivreur/config/route_transition/fade_route.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:phone_number_text_field/phone_number_text_field.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {

  final int? userType;
  final int? phoneCode;
  final PhoneNumber? phoneNumber;
  const RegisterScreen({Key? key, this.userType, this.phoneNumber, this.phoneCode}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {

  bool hidePassword = true;
  bool isLoadingProgress = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldEmailKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldAdresseKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldFirstNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldLastNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldPasswordKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldConfirmPasswordKey = GlobalKey<FormState>();

  final TextEditingController firstNameTextEditingController = TextEditingController();
  final TextEditingController lastNameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController adresseTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();
  final TextEditingController confirmPasswordTextEditingController = TextEditingController();


  // userMessage: {id_phone: 18, msg: Confimation effectué avec succés.},

  late RegisterParams registerParams;

  void onButtonClick(BuildContext context) async {
    setState(() => isLoadingProgress = true);
    registerParams = RegisterParams(
      id_phone: widget.phoneCode, id_user_type: widget.userType,
      email: emailTextEditingController.text.trim(),
      firstname: firstNameTextEditingController.text.trim(),
      lastname: lastNameTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
      password_confirmation: confirmPasswordTextEditingController.text.trim(),
      placeadresse: adresseTextEditingController.text.trim(),
      longitude: "${currentLocation?.longitude}", laltitude: "${currentLocation?.latitude}"
    );

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
            description: const Text("Votre compte a été créé avec succès."
                "Votre compte sera vérifié par l'administration dans les 12 prochaines heures",
              textScaleFactor: 1.1, textAlign: TextAlign.center,
            )).show(context);
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(context, FadeRoute(page: ActionChooseScreen()),);
        });
      } else {
        SnackBarAlert.show(context: context, description: value.userMessage?.msg);
      }});
  }


  LocationData? currentLocation;
  Location location = Location();

  @override
  void initState() {
    location.getLocation().then((location) {
      return currentLocation = location;
    });
    super.initState();
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
    firstNameTextEditingController.dispose();
    lastNameTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    adresseTextEditingController.dispose();
    super.dispose();
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Image.asset("assets/delivery-logo.png",
                              color: AppThemeMode.primaryColor, height: 90,)),

                        Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          child: const AutoSizeText("Inscription", style: TextStyle(fontWeight: FontWeight.bold,
                              color: AppThemeMode.textColorBlack, fontSize: 24),),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          child: const AutoSizeText("entrer votre coordonnées", style: TextStyle(
                              color: AppThemeMode.textColorBlack, fontSize: 14),),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.only(bottom: 10, top: 20),
                          child: TextFormField(maxLines: 1, key: formFieldFirstNameKey,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(color: AppThemeMode.textColorBlack),
                            decoration: InputDecoration(
                                filled: true, fillColor: AppThemeMode.containerFieldColor,
                                contentPadding: const EdgeInsets.only(
                                    left: 15, right: 15
                                ),
                                border: InputBorder.none, hintText: "Nom",
                                hintStyle: const TextStyle(color: AppThemeMode.textColorBlack),
                                focusedBorder: AppThemeMode.outlineInputBorderGrey,
                                enabledBorder: AppThemeMode.outlineInputBorderGrey,
                                errorBorder: AppThemeMode.outlineInputBorderGrey,
                                focusedErrorBorder: AppThemeMode.outlineInputBorderGrey,
                                errorStyle: AppThemeMode.errorStyle,
                              prefixIcon: const Icon(Icons.person,
                                size: 20, color: AppThemeMode.textColorBlack,),
                            ),
                            controller: firstNameTextEditingController,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              } else {
                                return '*Please enter a valid Nom';
                              }
                            },
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.only(bottom: 10,),
                          child: TextFormField(maxLines: 1, key: formFieldLastNameKey,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(color: AppThemeMode.textColorBlack),
                            decoration: InputDecoration(
                                filled: true, fillColor: AppThemeMode.containerFieldColor,
                                contentPadding: const EdgeInsets.only(
                                    left: 15, right: 15
                                ),
                                border: InputBorder.none, hintText: "Prénom",
                                hintStyle: const TextStyle(color: AppThemeMode.textColorBlack),
                                focusedBorder: AppThemeMode.outlineInputBorderGrey,
                                enabledBorder: AppThemeMode.outlineInputBorderGrey,
                                errorBorder: AppThemeMode.outlineInputBorderGrey,
                                focusedErrorBorder: AppThemeMode.outlineInputBorderGrey,
                                errorStyle: AppThemeMode.errorStyle,
                              prefixIcon: const Icon(Icons.person,
                                size: 20, color: AppThemeMode.textColorBlack,),
                            ),
                            controller: lastNameTextEditingController,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              } else {
                                return '*Please enter a valid prénom';
                              }
                            },
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.only(bottom: 10,),
                          child: TextFormField(maxLines: 1, key: formFieldAdresseKey,
                            keyboardType: TextInputType.streetAddress,
                            style: const TextStyle(color: AppThemeMode.textColorBlack),
                            decoration: InputDecoration(
                                filled: true, fillColor: AppThemeMode.containerFieldColor,
                                contentPadding: const EdgeInsets.only(
                                    left: 15, right: 15
                                ),
                                border: InputBorder.none, hintText: "Adresse",
                                hintStyle: const TextStyle(color: AppThemeMode.textColorBlack),
                                focusedBorder: AppThemeMode.outlineInputBorderGrey,
                                enabledBorder: AppThemeMode.outlineInputBorderGrey,
                                errorBorder: AppThemeMode.outlineInputBorderGrey,
                                focusedErrorBorder: AppThemeMode.outlineInputBorderGrey,
                                errorStyle: AppThemeMode.errorStyle,
                              prefixIcon: const Icon(Icons.location_on_rounded,
                                size: 20, color: AppThemeMode.textColorBlack,),
                            ),
                            controller: adresseTextEditingController,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              } else {
                                return '*Please enter a valid adresse';
                              }
                            },
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.only(bottom: 10,),
                          child: TextFormField(maxLines: 1, key: formFieldEmailKey,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: AppThemeMode.textColorBlack),
                            decoration: InputDecoration(
                                filled: true, fillColor: AppThemeMode.containerFieldColor,
                                contentPadding: const EdgeInsets.only(
                                    left: 15, right: 15
                                ),
                                border: InputBorder.none, hintText: "Email",
                                hintStyle: const TextStyle(color: AppThemeMode.textColorBlack),
                                focusedBorder: AppThemeMode.outlineInputBorderGrey,
                                enabledBorder: AppThemeMode.outlineInputBorderGrey,
                                errorBorder: AppThemeMode.outlineInputBorderGrey,
                                focusedErrorBorder: AppThemeMode.outlineInputBorderGrey,
                                errorStyle: AppThemeMode.errorStyle,
                              prefixIcon: const Icon(Icons.email,
                                size: 20, color: AppThemeMode.textColorBlack,),
                            ),
                            controller: emailTextEditingController,
                            validator: (value) {
                              if (value!.isNotEmpty && EmailValidator.validate(value)) {
                                return null;
                              } else {
                                return '*Please enter a valid email';
                              }
                            },
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(key: formFieldPasswordKey,
                            obscureText: hidePassword,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(color: AppThemeMode.textColorBlack),
                            decoration: InputDecoration(
                              filled: true, fillColor: AppThemeMode.containerFieldColor,
                              contentPadding: const EdgeInsets.only(
                                  left: 15, right: 15
                              ),
                              border: InputBorder.none, hintText: "Mot de passe",
                              hintStyle: const TextStyle(color: AppThemeMode.textColorBlack),
                              focusedBorder: AppThemeMode.outlineInputBorderGrey,
                              enabledBorder: AppThemeMode.outlineInputBorderGrey,
                              errorBorder: AppThemeMode.outlineInputBorderGrey,
                              focusedErrorBorder: AppThemeMode.outlineInputBorderGrey,
                              errorStyle: AppThemeMode.errorStyle,
                              prefixIcon: const Icon(Icons.lock,
                                size: 20, color: AppThemeMode.textColorBlack,),
                              suffixIcon: IconButton(
                                onPressed: () {setState(() {hidePassword = !hidePassword;});},
                                color: AppThemeMode.primaryColor.withOpacity(0.4),
                                icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility,
                                  size: 24, color: AppThemeMode.primaryColor,),),
                            ),
                            controller: passwordTextEditingController,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              } else {
                                return "*Please enter a valid password";
                              }
                            },
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(key: formFieldConfirmPasswordKey,
                            obscureText: hidePassword,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(color: AppThemeMode.textColorBlack),
                            decoration: InputDecoration(
                              filled: true, fillColor: AppThemeMode.containerFieldColor,
                              contentPadding: const EdgeInsets.only(
                                  left: 15, right: 15
                              ),
                              border: InputBorder.none, hintText: "Mot de passe",
                              hintStyle: const TextStyle(color: AppThemeMode.textColorBlack),
                              focusedBorder: AppThemeMode.outlineInputBorderGrey,
                              enabledBorder: AppThemeMode.outlineInputBorderGrey,
                              errorBorder: AppThemeMode.outlineInputBorderGrey,
                              focusedErrorBorder: AppThemeMode.outlineInputBorderGrey,
                              errorStyle: AppThemeMode.errorStyle,
                              prefixIcon: const Icon(Icons.lock,
                                size: 20, color: AppThemeMode.textColorBlack,),
                              suffixIcon: IconButton(
                                onPressed: () {setState(() {hidePassword = !hidePassword;});},
                                color: AppThemeMode.primaryColor.withOpacity(0.4),
                                icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility,
                                  size: 24, color: AppThemeMode.primaryColor,),),
                            ),
                            controller: confirmPasswordTextEditingController,
                            validator: (value) {
                              if (value!.isNotEmpty &&
                                  confirmPasswordTextEditingController.text
                                      == passwordTextEditingController.text) {
                                return null;
                              } else {
                                return "*Please enter a valid password";
                              }
                            },
                          ),
                        ),

                      ],
                    ),
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
                        textButton: widget.userType == 1?"Suivant":"S'inscrire",
                        onClickCallback: () {
                          if(formKey.currentState!.validate() && widget.userType == 1) {
                            registerParams = RegisterParams(
                              id_phone: widget.phoneCode, id_user_type: widget.userType,
                              email: emailTextEditingController.text.trim(),
                              firstname: firstNameTextEditingController.text.trim(),
                              lastname: lastNameTextEditingController.text.trim(),
                              password: passwordTextEditingController.text.trim(),
                              password_confirmation: confirmPasswordTextEditingController.text.trim(),
                              placeadresse: adresseTextEditingController.text.trim(),
                            );
                            setState(() => isLoadingProgress = true);
                            Provider.of<LoginProvider>(context, listen: false).checkEmail(
                              emailTextEditingController.text.trim(),
                            ).then((value) {
                              setState(() => isLoadingProgress = false);
                              if(value.userMessage?.first == "email validé"){
                                Navigator.pushReplacement(context, FadeRoute(
                                    page: CarChooseScreen(registerParams: registerParams)),);
                              } else {
                                SnackBarAlert.show(context: context,
                                    description: "L'e-mail a été utilisé.");
                              }
                            });
                            /// context.router.replace(CarChooseScreenRoute(registerParams: registerParams));
                          } else if(formKey.currentState!.validate() && widget.userType == 2){
                            Provider.of<LoginProvider>(context, listen: false).checkEmail(
                              emailTextEditingController.text.trim(),
                            ).then((value) {
                              setState(() => isLoadingProgress = false);
                              if(value.userMessage?.first == "email validé"){
                                onButtonClick(context);
                              } else {
                                SnackBarAlert.show(context: context,
                                    description: "L'e-mail a été utilisé.");
                              }
                            });
                          }
                        },
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
