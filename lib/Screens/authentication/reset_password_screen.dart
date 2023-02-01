import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/Providers/SignUp&LogIn/LoginProvider.dart';
import 'package:monlivreur/Screens/authentication/login_phone_screen.dart';

import 'package:monlivreur/Screens/authentication/widget/default_action_button.dart';
import 'package:monlivreur/Screens/authentication/widget/snack_bar_alert.dart';
import 'package:monlivreur/config/route_transition/fade_route.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {

  final int? userCode;
  const ResetPasswordScreen({Key? key, this.userCode,}) : super(key: key);

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {

  bool hidePassword = true;
  bool isLoadingProgress = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  GlobalKey<FormState> formFieldPasswordKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldConfirmPasswordKey = GlobalKey<FormState>();


  final TextEditingController passwordTextEditingController = TextEditingController();
  final TextEditingController confirmPasswordTextEditingController = TextEditingController();


  void onButtonClick(BuildContext context) async {
    setState(() => isLoadingProgress = true);

    Provider.of<LoginProvider>(context, listen: false).resetPassword(
        passwordTextEditingController.text, widget.userCode
    ).then((value) {
      setState(() => isLoadingProgress = false);
      if(value.userMessage?.password != null){
        Navigator.pushReplacement(context, FadeRoute(page:LogInPhoneScreen()),);
      } else {
        SnackBarAlert.show(context: context, description: value.debugMessage);
      }});
  }


  @override
  void dispose() {
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
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
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                  ),
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
                          child: const AutoSizeText("Nouveau mot de passe", style: TextStyle(fontWeight: FontWeight.bold,
                              color: AppThemeMode.textColorBlack, fontSize: 24),),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          child: const AutoSizeText("entrer votre nouveau mot de passe", style: TextStyle(
                              color: AppThemeMode.textColorBlack, fontSize: 14),),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.only(bottom: 10, top: 20),
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
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: DefaultActionButton(
                      isLoading: isLoadingProgress,
                      textButton: "Changer",
                      onClickCallback: () {
                        if(formKey.currentState!.validate()){
                          onButtonClick(context);
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
