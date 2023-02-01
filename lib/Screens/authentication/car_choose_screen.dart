
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/Screens/authentication/driver_document_screen.dart';
import 'package:monlivreur/Screens/authentication/login_phone_screen.dart';

import 'package:monlivreur/config/params/register_params.dart';
import 'package:monlivreur/config/route_transition/fade_route.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:monlivreur/config/utils/car_type_data.dart';

class CarChooseScreen extends StatefulWidget {

  final RegisterParams registerParams;
  const CarChooseScreen({Key? key, required this.registerParams,}) : super(key: key);

  @override
  CarChooseScreenState createState() => CarChooseScreenState();
}

class CarChooseScreenState extends State<CarChooseScreen> {

  int selectedCode = -1;
  bool isLoadingProgress = false;
  late RegisterParams registerParams;

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
                        child: const AutoSizeText("Merci de choisir le type de votre véhicule",
                          style: TextStyle(color: AppThemeMode.textColorBlack, fontSize: 14),),
                      ),

                      ListView.builder(
                          itemCount: CarTypeData.listCarData.length, shrinkWrap: true,
                          padding: const EdgeInsets.only(
                              bottom: 20, top: 25, left: 6, right: 6),
                          itemBuilder:  (contextList, index) {
                            return InkWell(
                                onTap: () {
                                  registerParams = RegisterParams(
                                    id_type_vehicule: index + 1,
                                    id_phone: widget.registerParams.id_phone,
                                    id_user_type: widget.registerParams.id_user_type,
                                    email: widget.registerParams.email,
                                    firstname: widget.registerParams.firstname,
                                    lastname: widget.registerParams.lastname,
                                    password: widget.registerParams.password,
                                    password_confirmation: widget.registerParams.password_confirmation,
                                    placeadresse: widget.registerParams.placeadresse,
                                  );
                                  setState(() => selectedCode = index);
                                  /// context.router.replace(DriverDocumentScreenRoute(registerParams: registerParams));
                                  Navigator.pushReplacement(context, FadeRoute(page: DriverDocumentScreen(registerParams: registerParams)),);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                    color: selectedCode == index
                                        ? AppThemeMode.primaryColor
                                        : Colors.black12,),
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                                  child: AutoSizeText(CarTypeData.listCarData.elementAt(index).carTitle,
                                    textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600,
                                        color: AppThemeMode.textColorBlack, fontSize: 16),),
                                ));
                          }
                      ),

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
