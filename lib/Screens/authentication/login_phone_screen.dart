import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/Providers/SignUp&LogIn/LoginProvider.dart';
import 'package:monlivreur/Screens/Client/ClientWidgets/BottomClientNavigation.dart';
import 'package:monlivreur/Screens/authentication/login_email_screen.dart';
import 'package:monlivreur/Screens/authentication/phone_number_screen.dart';
import 'package:monlivreur/Screens/authentication/register_choose_screen.dart';
import 'package:monlivreur/Screens/authentication/widget/default_action_button.dart';
import 'package:monlivreur/Screens/authentication/widget/snack_bar_alert.dart';
import 'package:monlivreur/Screens/livreur/LivreurWidgets/BottomLivreurNavigation.dart';
import 'package:monlivreur/config/params/login_params.dart';
import 'package:monlivreur/config/route_transition/fade_route.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:phone_number_text_field/phone_number_text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPhoneScreen extends StatefulWidget {
  static String loginScreenRoute = '/loginScreenRoute';
  const LogInPhoneScreen({Key? key}) : super(key: key);

  @override
  LogInPhoneScreenState createState() => LogInPhoneScreenState();
}

class LogInPhoneScreenState extends State<LogInPhoneScreen> {
  bool hidePassword = true;
  bool isLoadingProgress = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldPhoneNumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldPasswordKey = GlobalKey<FormState>();

  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController phoneNumberTextEditingController =
      TextEditingController();

  String initialCountry = 'TN';
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'TN', phoneNumber: '00000000');

  String? fcmToken;
  late LoginParams loginParams;

  void onButtonClick(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => isLoadingProgress = true);
    loginParams = LoginParams(
      fcmToken: fcmToken,
      email: phoneNumber.phoneNumber?.replaceAll("+", ""),
      password: passwordTextEditingController.text.trim(),
    );

    Provider.of<LoginProvider>(context, listen: false)
        .authenticate(
      loginParams.email,
      loginParams.password,
      loginParams.fcmToken,
    )
        .then((value) {
      setState(() => isLoadingProgress = false);
      if (value.userstatus != null) {
        prefs.setBool('isLogin', true);
        prefs.setBool('isClient', value.usertype == 2);
        prefs.setInt('userId', value.userid ?? -1);
        prefs.setString('userToken', value.token ?? "");
        prefs.setString(
            'userPhone', phoneNumber.phoneNumber?.replaceAll("+", "") ?? "");
        prefs.setString(
            'userPassword', passwordTextEditingController.text.trim());
        value.usertype == 1
            ? Navigator.pushReplacement(
                context,
                FadeRoute(page: BottomLivreurNavigation()),
              )
            : Navigator.pushReplacement(
                context,
                FadeRoute(page: BottomClientNavigation()),
              );
      } else {
        SnackBarAlert.show(
            context: context, description: "Vérifiez vos identifiants");
      }
    });
  }

  setUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userPhone = prefs.getString('userPhone');
    var userPassword = prefs.getString('userPassword') ?? "";
    if (userPhone != null) {
      getPhoneNumber("+${userPhone}");
    }
    passwordTextEditingController.text = userPassword;
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');
    setState(() => this.phoneNumber = number);
  }

  @override
  void initState() {
    setUserData();
    FirebaseMessaging.instance.getToken().then((value) {
      fcmToken = value;
      debugPrint("Fcm Token: $fcmToken");
    });
    super.initState();
  }

  @override
  void dispose() {
    phoneNumberTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
          textScaleFactor: 0.975,
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
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 25),
                            child: Image.asset(
                              "assets/delivery-logo.png",
                              color: AppThemeMode.primaryColor,
                              height: 180,
                            )),
                        const AutoSizeText(
                          "Connexion",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppThemeMode.textColorBlack,
                              fontSize: 24),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: const AutoSizeText(
                            "Se connecter avec votre numéro de téléphone et mot de passe ",
                            style: TextStyle(
                                color: AppThemeMode.textColorBlack,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.only(bottom: 10, top: 20),
                          child: InternationalPhoneNumberInput(
                            key: formFieldPhoneNumberKey,
                            onInputChanged: (PhoneNumber number) {
                              phoneNumber = number;
                            },
                            selectorConfig: const SelectorConfig(
                              setSelectorButtonAsPrefixIcon: true,
                              leadingPadding: 15,
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: true,
                            autoValidateMode: AutovalidateMode.always,
                            selectorTextStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            initialValue: phoneNumber,
                            textFieldController:
                                phoneNumberTextEditingController,
                            textStyle: const TextStyle(
                                color: AppThemeMode.textColorBlack,
                                wordSpacing: 12),
                            inputDecoration: InputDecoration(
                              filled: true,
                              fillColor: AppThemeMode.containerFieldColor,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              border: InputBorder.none,
                              hintText: "Numéro de télephone",
                              hintStyle: const TextStyle(
                                color: AppThemeMode.textColorBlack,
                              ),
                              focusedBorder: AppThemeMode.outlineInputBorder,
                              enabledBorder: AppThemeMode.outlineInputBorder,
                              errorBorder: AppThemeMode.outlineInputBorder,
                              focusedErrorBorder:
                                  AppThemeMode.outlineInputBorder,
                              errorStyle: const TextStyle(fontSize: 7.5),
                            ),
                            // validator: (phone) {;
                            //     if (phoneNumber.phoneNumber == '00000000') {
                            //       return null;
                            //     } else {
                            //       return '*Please enter a valid phone number';
                            //     }
                            // },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.only(bottom: 4),
                          child: TextFormField(
                            key: formFieldPasswordKey,
                            obscureText: hidePassword,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(
                                color: AppThemeMode.textColorBlack),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppThemeMode.containerFieldColor,
                              contentPadding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              border: InputBorder.none,
                              hintText: "Mot de passe",
                              hintStyle: const TextStyle(
                                  color: AppThemeMode.textColorBlack),
                              focusedBorder:
                                  AppThemeMode.outlineInputBorderGrey,
                              enabledBorder:
                                  AppThemeMode.outlineInputBorderGrey,
                              errorBorder: AppThemeMode.outlineInputBorderGrey,
                              focusedErrorBorder:
                                  AppThemeMode.outlineInputBorderGrey,
                              errorStyle: AppThemeMode.errorStyle,
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 20,
                                color: AppThemeMode.textColorBlack,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                color:
                                    AppThemeMode.primaryColor.withOpacity(0.4),
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 24,
                                  color: AppThemeMode.primaryColor,
                                ),
                              ),
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
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            FadeRoute(page: PhoneNumberScreen(userType: 0)),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: const EdgeInsets.only(bottom: 15, top: 4),
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: AutoSizeText(
                                "Mot de passe oublié ?",
                                style: TextStyle(
                                    color: AppThemeMode.textColorBlack,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            FadeRoute(page: LogInEmailScreen()),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: const EdgeInsets.only(bottom: 5, top: 10),
                            child: AutoSizeText(
                              "Se connecter avec votre email !",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppThemeMode.primaryColor,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        DefaultActionButton(
                          isLoading: isLoadingProgress,
                          textButton: "Se connecter",
                          onClickCallback: () {
                            if (formKey.currentState!.validate()) {
                              onButtonClick(context);
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25, top: 10),
                          child: Column(
                            children: [
                              const AutoSizeText(
                                "Vous ne possédez pas encore de compte?",
                                style: TextStyle(
                                    color: AppThemeMode.textColorBlack,
                                    fontSize: 14),
                              ),
                              InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  FadeRoute(page: RegisterChooseScreen()),
                                ),
                                child: const AutoSizeText(
                                  "Inscription",
                                  style: TextStyle(
                                      color: AppThemeMode.primaryColor,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
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
