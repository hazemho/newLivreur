import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/SignUp&LogIn/LoginProvider.dart';
import 'package:monlivreur/Providers/UserProvider/UserProvider.dart';
import 'package:monlivreur/Screens/authentication/widget/default_action_button.dart';
import 'package:monlivreur/Screens/authentication/widget/snack_bar_alert.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordScreen extends StatefulWidget {

  final int? userCode;
  const PasswordScreen({Key? key, this.userCode,}) : super(key: key);

  @override
  PasswordScreenState createState() => PasswordScreenState();
}

class PasswordScreenState extends State<PasswordScreen> {

  bool hidePassword = true;
  bool hideOldPassword = true;
  bool isLoadingProgress = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  GlobalKey<FormState> formFieldPasswordKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldNewPasswordKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldConfirmPasswordKey = GlobalKey<FormState>();


  final TextEditingController passwordTextEditingController = TextEditingController();
  final TextEditingController newPasswordTextEditingController = TextEditingController();
  final TextEditingController confirmPasswordTextEditingController = TextEditingController();


  void onButtonClick(BuildContext context) async {
    setState(() => isLoadingProgress = true);

    Provider.of<UserProvider>(context, listen: false).updatePassword(
        passwordTextEditingController.text,
        newPasswordTextEditingController.text, widget.userCode
    ).then((value) {
      setState(() => isLoadingProgress = false);
      if(value.userMessage?.password != null){
        _showErrorDialog(context, "Vous voulez déconneter de tous les autres appareils ?");
      } else {
        SnackBarAlert.show(context: context, description: value.debugMessage);
      }});
  }

  void _showErrorDialog(BuildContext context,String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('LogOut'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MonLTextDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                // side: BorderSide(width: 2, color: Colors.white),
              ),
            ),
            child: Text('Non'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: PrimaryColorY,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                // side: BorderSide(width: 2, color: Colors.white),
              ),
            ),
            child: Text('Oui'),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop([
                Provider.of<UserProvider>(context, listen: false).logOutFromAll(fcmToken).then((value) async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('userToken', value.userMessage?.token?? ""); prefs.reload();
                }),
              ]);
            },
          )
        ],
      ),
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
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          child: const AutoSizeText("Nouveau mot de passe", style: TextStyle(fontWeight: FontWeight.bold,
                              color: AppThemeMode.textColorBlack, fontSize: 24),),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          child: const AutoSizeText("Changer votre mot de passe", style: TextStyle(
                              color: AppThemeMode.textColorBlack, fontSize: 14),),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(key: formFieldPasswordKey,
                            obscureText: hideOldPassword,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(color: AppThemeMode.textColorBlack),
                            decoration: InputDecoration(
                              filled: true, fillColor: AppThemeMode.containerFieldColor,
                              contentPadding: const EdgeInsets.only(
                                  left: 15, right: 15
                              ),
                              border: InputBorder.none, hintText: "Ancien Mot de passe",
                              hintStyle: const TextStyle(color: AppThemeMode.textColorBlack),
                              focusedBorder: AppThemeMode.outlineInputBorderGrey,
                              enabledBorder: AppThemeMode.outlineInputBorderGrey,
                              errorBorder: AppThemeMode.outlineInputBorderGrey,
                              focusedErrorBorder: AppThemeMode.outlineInputBorderGrey,
                              errorStyle: AppThemeMode.errorStyle,
                              prefixIcon: const Icon(Icons.lock,
                                size: 20, color: AppThemeMode.textColorBlack,),
                              suffixIcon: IconButton(
                                onPressed: () {setState(() {hideOldPassword = !hideOldPassword;});},
                                color: AppThemeMode.primaryColor.withOpacity(0.4),
                                icon: Icon(hideOldPassword ? Icons.visibility_off : Icons.visibility,
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
                          margin: const EdgeInsets.only(bottom: 10, top: 20),
                          child: TextFormField(key: formFieldNewPasswordKey,
                            obscureText: hidePassword,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(color: AppThemeMode.textColorBlack),
                            decoration: InputDecoration(
                              filled: true, fillColor: AppThemeMode.containerFieldColor,
                              contentPadding: const EdgeInsets.only(
                                  left: 15, right: 15
                              ),
                              border: InputBorder.none, hintText: "Nouveau mot de passe",
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
                            controller: newPasswordTextEditingController,
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
                              border: InputBorder.none, hintText: "Confirmation de mot de passe",
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
                                      == newPasswordTextEditingController.text) {
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
