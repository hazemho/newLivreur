
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/Providers/SignUp&LogIn/LoginProvider.dart';
import 'package:monlivreur/Providers/UserProvider/UserProvider.dart';
import 'package:monlivreur/Screens/authentication/widget/default_action_button.dart';
import 'package:monlivreur/Screens/authentication/widget/snack_bar_alert.dart';
import 'package:monlivreur/Screens/profile/pin_update_screen.dart';
import 'package:monlivreur/config/route_transition/fade_route.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:phone_number_text_field/phone_number_text_field.dart';
import 'package:provider/provider.dart';

class UpdatePhoneScreen extends StatefulWidget {

  final int? userCode;
  final String? phoneNumber;
  const UpdatePhoneScreen({Key? key, this.userCode, this.phoneNumber}) : super(key: key);

  @override
  UpdatePhoneScreenState createState() => UpdatePhoneScreenState();
}

class UpdatePhoneScreenState extends State<UpdatePhoneScreen> {

  bool hidePassword = true;
  bool isLoadingProgress = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldPhoneNumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldPasswordKey = GlobalKey<FormState>();

  final TextEditingController phoneNumberTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();

  String initialCountry = 'TN';
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'TN',);

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');
    setState(() => this.phoneNumber = number);
  }

  void onButtonClick(BuildContext context) async {
    setState(() => isLoadingProgress = true);
    if(phoneNumberTextEditingController.text.isNotEmpty){
      Provider.of<UserProvider>(context, listen: false).updatePhone(
          phoneNumber.phoneNumber?.replaceAll("+", ""),
          widget.userCode, passwordTextEditingController.text
      ).then((value) {
        setState(() => isLoadingProgress = false);
        if(value.checkPhoneData?.otp != null){
          Navigator.pushReplacement(context, FadeRoute(page: PinUpdateScreen(
            authSecurity: value.checkPhoneData?.auth,
            userCode: widget.userCode, otpCode: value.checkPhoneData?.otp,
          )),);
        } else {
          SnackBarAlert.show(context: context, description: value.debugMessage);
        }
      });
    } else {
      setState(() => isLoadingProgress = false);
       SnackBarAlert.show(context: context, description: "Please enter a valid phone number!");
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
  void initState() {
    getPhoneNumber("+${widget.phoneNumber}");
    super.initState();
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
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
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
                          isLoading: isLoadingProgress,
                          textButton: "Changer",
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
