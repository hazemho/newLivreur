import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/Providers/SignUp&LogIn/LoginProvider.dart';
import 'package:monlivreur/Screens/authentication/login_phone_screen.dart';

import 'package:monlivreur/Screens/authentication/register_screen.dart';
import 'package:monlivreur/Screens/authentication/reset_password_screen.dart';
import 'package:monlivreur/Screens/authentication/widget/default_action_button.dart';
import 'package:monlivreur/Screens/authentication/widget/easy_dialog.dart';
import 'package:monlivreur/Screens/authentication/widget/snack_bar_alert.dart';
import 'package:monlivreur/Screens/authentication/widget/timer_controller.dart';
import 'package:monlivreur/Screens/authentication/widget/timer_count_down.dart';
import 'package:monlivreur/config/params/confirm_phone_params.dart';
import 'package:monlivreur/config/route_transition/fade_route.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:phone_number_text_field/phone_number_text_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class PinNumberScreen extends StatefulWidget {

  final int? userType;
  final String? otpCode;
  final String? authSecurity;
  final PhoneNumber? phoneNumber;

  const PinNumberScreen({Key? key, this.userType, this.otpCode,
    this.phoneNumber, this.authSecurity,}) : super(key: key);

  @override
  PinNumberScreenState createState() => PinNumberScreenState();
}

class PinNumberScreenState extends State<PinNumberScreen> {

  bool isClickable = false;
  bool isLoadingProgress = false;

  var onTapRecognizer = TapGestureRecognizer();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldPinKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  late StreamController<ErrorAnimationType> errorController;
  final CountdownController _controller = CountdownController();

  // data: {otp: 1389, auth: 39cb829d-4a15-4dff-b041-a71d542f8124, phone: 21652674770}

  void onButtonClick(BuildContext context) async {
    setState(() => isLoadingProgress = true);
    Provider.of<LoginProvider>(context, listen: false).phoneConfirmation(
      widget.otpCode, widget.authSecurity, isForgotPassword: widget.userType == 0
    ).then((value) {
      setState(() => isLoadingProgress = false);
      if(value.userMessage?.id_phone != null){
        Navigator.pushReplacement(context, FadeRoute(page:
        widget.userType == 0?
        ResetPasswordScreen(userCode: value.userMessage?.id_phone) :
        RegisterScreen(phoneCode: value.userMessage?.id_phone,
            userType: widget.userType, phoneNumber: widget.phoneNumber)));
      } else {
        SnackBarAlert.show(context: context, description: "Code de vérification invalide");
      }
    });
  }

  String formatTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  void initState() {
    onTapRecognizer.onTap = () => Navigator.pop(context);
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
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
                          margin: const EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width*0.9,
                          child: const AutoSizeText("Nous avons envoyé un otp sur votre mobile",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color: AppThemeMode.textColorBlack, fontSize: 24),),
                        ),

                        Container(
                          padding: const EdgeInsets.only(bottom: 25),
                          width: MediaQuery.of(context).size.width*0.9,
                          child: const AutoSizeText("Veuillez vérifier votre numéro de portable, "
                              "nous vous avons envoyé un message avec 4 chiffres",
                            style: TextStyle(color: AppThemeMode.textColorBlack, fontSize: 14),),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                               child: PinCodeTextField(appContext: context,
                                 length: 4, obscureText: false, key: formFieldPinKey,
                                 dialogConfig: DialogConfig(
                                 ), keyboardType: TextInputType.number,
                                 cursorColor: AppThemeMode.containerFieldColor,
                                 animationType: AnimationType.fade,
                                 textStyle: const TextStyle(color: AppThemeMode.textColorWhite),
                                 pinTheme: PinTheme(
                                   shape: PinCodeFieldShape.box, borderWidth: 0.8,
                                   borderRadius: BorderRadius.circular(10),
                                   activeColor: AppThemeMode.primaryColor,
                                   activeFillColor: AppThemeMode.primaryColor,
                                   selectedColor: AppThemeMode.primaryColor,
                                   selectedFillColor: AppThemeMode.primaryColor.withOpacity(0.7),
                                   disabledColor: AppThemeMode.containerFieldColor,
                                   inactiveColor: AppThemeMode.containerFieldColor,
                                   inactiveFillColor: AppThemeMode.containerFieldColor
                                 ),
                                 animationDuration: const Duration(milliseconds: 300),
                                 enableActiveFill: true,
                                 errorAnimationController: errorController,
                                 controller: textEditingController,
                                 onCompleted: (value) {
                                   debugPrint("Completed");
                                   if(widget.otpCode == value){
                                     setState(() => isClickable = true);
                                   } else {
                                     EasyDialog(
                                         title: const Text("Vérification OTP",
                                           style: TextStyle(fontWeight: FontWeight.bold),
                                           textScaleFactor: 1.2, textAlign: TextAlign.center,
                                         ),
                                         description: const Text("Code de vérification invalide",
                                           textScaleFactor: 1.1, textAlign: TextAlign.center,
                                         )).show(context);
                                   }
                                 },
                                 onChanged: (value) => debugPrint(value),
                                 beforeTextPaste: (text) => true,
                               )
                            ),
                            Countdown(
                              seconds: 120,
                              controller: _controller,
                              interval: const Duration(milliseconds: 100),
                              build: (_, double time) {
                                if (time == 0 || time == 120) {
                                  return InkWell(
                                    onTap: () {
                                      _controller.restart();
                                      setState(() => isClickable = false);
                                      textEditingController.clear();
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text("Vous n'avez pas reçu ? ",
                                            style: TextStyle(color: AppThemeMode.textColorBlack, fontSize: 14)),
                                        Text("Cliquez ici",
                                            style: TextStyle(color: AppThemeMode.primaryColor, fontSize: 14)),
                                      ],
                                    ),);
                                } else {
                                  return Text(formatTime(timeInSecond: time.toInt()),
                                      style: const TextStyle(color: AppThemeMode.primaryColor, fontSize: 14));
                                }
                              },
                              onFinished: () {
                                setState(() => isClickable = true);
                              },
                            ),
                          ],
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
                        isClickable: isClickable,
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
