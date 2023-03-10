import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/Providers/SignUp&LogIn/LoginProvider.dart';
import 'package:monlivreur/Providers/UserProvider/UserProvider.dart';

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

class PinUpdateScreen extends StatefulWidget {

  final int? userCode;
  final String? otpCode;
  final String? authSecurity;

  const PinUpdateScreen({Key? key, this.userCode, this.otpCode,
    this.authSecurity,}) : super(key: key);

  @override
  PinUpdateScreenState createState() => PinUpdateScreenState();
}

class PinUpdateScreenState extends State<PinUpdateScreen> {

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
    Provider.of<UserProvider>(context, listen: false).checkUpdatePhone(
      widget.userCode, widget.authSecurity, widget.otpCode,
    ).then((value) {
      setState(() => isLoadingProgress = false);
      if(value.userMessage?.id_phone != null){
        Navigator.pop(context, [
          Provider.of<UserProvider>(context, listen: false).getUserProfile()]);
      } else {
        SnackBarAlert.show(context: context, description: value.debugMessage);
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
          appBar: AppBar(elevation: 0,
            iconTheme: IconThemeData(color: AppThemeMode.textColorBlack,),
            backgroundColor: AppThemeMode.primaryColor,
          ),
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
                          margin: const EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width*0.9,
                          child: const AutoSizeText("Nous avons envoy?? un otp sur votre mobile",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color: AppThemeMode.textColorBlack, fontSize: 24),),
                        ),

                        Container(
                          padding: const EdgeInsets.only(bottom: 25),
                          width: MediaQuery.of(context).size.width*0.9,
                          child: const AutoSizeText("Veuillez v??rifier votre num??ro de portable, "
                              "nous vous avons envoy?? un message avec 4 chiffres",
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
                                         title: const Text("OTP Check",
                                           style: TextStyle(fontWeight: FontWeight.bold),
                                           textScaleFactor: 1.2, textAlign: TextAlign.center,
                                         ),
                                         description: const Text("Invalid verification code",
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
                                        Text("Vous n'avez pas re??u ? ",
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
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DefaultActionButton(
                          isClickable: isClickable,
                          isLoading: isLoadingProgress,
                          textButton: "Confirmer",
                          onClickCallback: () {
                            if(formKey.currentState!.validate()) {
                              onButtonClick(context);
                            }
                          },
                        ),
                      ],
                    ),
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
