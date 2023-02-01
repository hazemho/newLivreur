
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/Providers/SignUp&LogIn/LoginProvider.dart';
import 'package:monlivreur/Screens/authentication/login_phone_screen.dart';

import 'package:monlivreur/Screens/authentication/pin_number_screen.dart';
import 'package:monlivreur/Screens/authentication/widget/default_action_button.dart';
import 'package:monlivreur/Screens/authentication/widget/snack_bar_alert.dart';
import 'package:monlivreur/config/route_transition/fade_route.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:phone_number_text_field/phone_number_text_field.dart';
import 'package:provider/provider.dart';

class PhoneNumberScreen extends StatefulWidget {

  final int userType;
  const PhoneNumberScreen({Key? key, required this.userType}) : super(key: key);

  @override
  PhoneNumberScreenState createState() => PhoneNumberScreenState();
}

class PhoneNumberScreenState extends State<PhoneNumberScreen> {

  bool isLoadingProgress = false;
  bool isFirstEdit = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldPhoneNumberKey = GlobalKey<FormState>();

  final TextEditingController phoneNumberTextEditingController = TextEditingController();

  String initialCountry = 'TN';
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'TN',);


  void onButtonClick(BuildContext context) async {
    setState(() => isLoadingProgress = true);
    if(phoneNumberTextEditingController.text.isNotEmpty){
      Provider.of<LoginProvider>(context, listen: false).checkUserPhone(
        phoneNumber.phoneNumber?.replaceAll("+", ""), isForgotPassword: widget.userType == 0
      ).then((value) {
        setState(() => isLoadingProgress = false);
        if(value.checkPhoneData?.otp != null){
          Navigator.pushReplacement(context, FadeRoute(page: PinNumberScreen(
              userType: widget.userType, phoneNumber: phoneNumber,
              authSecurity: value.checkPhoneData?.auth, otpCode: value.checkPhoneData?.otp
          )),);
        } else {
          SnackBarAlert.show(context: context, description: value.userMessage);
        }
      });
    } else {
      setState(() => isLoadingProgress = false);
       SnackBarAlert.show(context: context, description: "S'il vous plaît entrer un numéro de téléphone valide!");
    }
  }


  bool phoneValidation(String? phone) {
    bool isValid = false;
    PhoneNumber.isValidNumber("$phone", "${phoneNumber.dialCode}").then((value) {
      isValid = value ?? false;
    });
    return isValid;
  }


  @override
  void dispose() {
    phoneNumberTextEditingController.dispose();
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
          // appBar: AppBar(elevation: 0,
          //   iconTheme: IconThemeData(color: AppThemeMode.primaryColor,),
          //   backgroundColor: AppThemeMode.containerBackground,
          // ),
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
                          margin: const EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width*0.9,
                          child: const AutoSizeText("Saisissez votre numéro de téléphone portable",
                            style: TextStyle(fontWeight: FontWeight.bold,
                              color: AppThemeMode.textColorBlack, fontSize: 24),),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.9,
                          child: InternationalPhoneNumberInput(
                            key: formFieldPhoneNumberKey,
                            onInputChanged: (PhoneNumber number) {
                              phoneNumber = number;
                            },
                            selectorConfig: const SelectorConfig(
                              setSelectorButtonAsPrefixIcon: true, leadingPadding: 15,
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: true, autoValidateMode: AutovalidateMode.always,
                            selectorTextStyle: const TextStyle(color: Colors.black,),
                            initialValue: phoneNumber, textFieldController: phoneNumberTextEditingController,
                            textStyle: const TextStyle(color: AppThemeMode.textColorBlack, wordSpacing: 12),
                            inputDecoration: InputDecoration(
                                filled: true, fillColor: AppThemeMode.containerFieldColor,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                border: InputBorder.none, hintText: "00 000 000",
                                hintStyle: const TextStyle(color: AppThemeMode.textColorBlack, wordSpacing: 12),
                                focusedBorder: AppThemeMode.outlineInputBorder,
                                enabledBorder: AppThemeMode.outlineInputBorder,
                                errorBorder: AppThemeMode.outlineInputBorder,
                                focusedErrorBorder: AppThemeMode.outlineInputBorder,
                                errorStyle: const TextStyle(fontSize: 7.5)
                            ),
                            // validator: (phone) {
                            //   var isValid = PhoneNumber.isValidNumber("$phone", "${phoneNumber.dialCode}") as bool;
                            //     if (isValid) {
                            //       return null;
                            //     } else {
                            //       return '*Please enter a valid phone number';
                            //     }
                            // },
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          width: MediaQuery.of(context).size.width*0.9,
                          child: const AutoSizeText("Si vous continuez vous recevrez un SMS de vérification. "
                              "Des frais de messagerie SMS  et de transfert de données peuvent s\'appliquer", style: TextStyle(
                              color: AppThemeMode.textColorBlack, fontSize: 14), textAlign: TextAlign.center,),
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
                        textButton: "Suivant",
                        onClickCallback: () {
                          if(formKey.currentState!.validate()) {
                            onButtonClick(context);
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
                                      Navigator.pushReplacement(context, FadeRoute(page:LogInPhoneScreen()),),
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
