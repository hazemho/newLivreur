import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/Providers/SignUp&LogIn/LoginProvider.dart';
import 'package:monlivreur/Providers/UserProvider/UserProvider.dart';
import 'package:monlivreur/Screens/authentication/widget/default_action_button.dart';
import 'package:monlivreur/Screens/authentication/widget/easy_dialog.dart';
import 'package:monlivreur/Screens/authentication/widget/item_document_diver.dart';
import 'package:monlivreur/Screens/authentication/widget/snack_bar_alert.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:monlivreur/config/utils/car_type_data.dart';
import 'package:monlivreur/config/utils/driver_document_data.dart';
import 'package:provider/provider.dart';


class UpdateDocumentScreen extends StatefulWidget {

  final int? userType;
  final String? viheculeType;
  final String? filePermis;
  final String? fileIdentite;
  final String? fileCarteGrise;
  final String? filePlaque;
  final String? fileJustification;
  const UpdateDocumentScreen({Key? key, this.userType, this.viheculeType, this.filePermis,
    this.fileIdentite, this.fileCarteGrise, this.filePlaque, this.fileJustification,}) : super(key: key);

  @override
  UpdateDocumentScreenState createState() => UpdateDocumentScreenState();
}

class UpdateDocumentScreenState extends State<UpdateDocumentScreen> {

  int selectedCode = -1;

  bool isLoadingProgress = false;
  bool requiredDocument = false;

  List<DriverDocumentData> listDriverDocumentData = List.empty(growable: true);


  @override
  void initState() {
    switch(widget.viheculeType) {
      case "Moto":
        selectedCode = 0;
        break;
      case "Voiture":
        selectedCode = 1;
        break;
      case "Camion":
        selectedCode = 2;
        break;
      default: selectedCode = -1;
    }

    listDriverDocumentData = [

      DriverDocumentData(
          documentTitle: 'Carte grise',
          documentImagePath: widget.fileCarteGrise != ""? widget.fileCarteGrise: null
      ),
      DriverDocumentData(
          documentTitle: 'Plaque',
          documentImagePath: widget.filePlaque != ""? widget.filePlaque: null
      ),

      // DriverDocumentData(
      //     documentTitle: 'Carte d\'identité',
      //     documentImagePath: widget.fileIdentite != ""? widget.fileIdentite: null
      // ),
      // DriverDocumentData(
      //     documentTitle: 'Justification',
      //     documentImagePath: widget.fileJustification != ""? widget.fileJustification: null
      // ),
      // DriverDocumentData(
      //     documentTitle: 'Permis de conduite',
      //     documentImagePath: widget.filePermis != ""? widget.filePermis: null
      // ),
    ];
    super.initState();
  }

  File? filePermis;
  File? fileIdentite;
  File? fileCarteGrise;
  File? filePlaque;
  File? fileJustification;

  void onButtonClick(BuildContext context) async {

    if(selectedCode == 0 || (selectedCode != 0
        && (fileCarteGrise != null || widget.fileCarteGrise != null)
        && (filePlaque != null || widget.filePlaque != null)
    )){
      setState(() => isLoadingProgress = true);
      Provider.of<UserProvider>(context, listen: false).updateVehiculeDoc(
          fileCarteGrise?.path, filePlaque?.path, selectedCode + 1
      ).then((value) {
        setState(() => isLoadingProgress = false);
        if(value.userMessage != null){
          SnackBarAlert.show(context: context, description: "Vos données ont été mises à jour avec succès");
          Navigator.pop(context, [
            Provider.of<UserProvider>(context, listen: false).getUserProfile()
          ]);
        } else {
          SnackBarAlert.show(context: context, description: value.debugMessage);
        }});
    } else {
      setState(() => requiredDocument = true);
      EasyDialog(
          title: const Text("Update Require",
            style: TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 1.2, textAlign: TextAlign.center,
          ),
          description: const Text("Please upload the require documents",
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
                  child: Column(
                    children: [

                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.9,
                        child: const AutoSizeText("Update",
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
                                onTap: () => setState(() => selectedCode = index),
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

                      Visibility(
                        visible: selectedCode != 0,
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 15),
                          width: MediaQuery.of(context).size.width*0.9,
                          child: const AutoSizeText("Merci de nous envoyer vos documents afin de vérifier votre compte livreur",
                            style: TextStyle(color: AppThemeMode.textColorBlack, fontSize: 14),),
                        ),
                      ),

                      Visibility(
                        visible: selectedCode != 0,
                        child: GridView.builder(shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listDriverDocumentData.length,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1.56,
                              crossAxisSpacing: 12, mainAxisSpacing: 12,
                              mainAxisExtent: MediaQuery.of(context).size.height * 0.2,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return ItemDocumentDiver(requiredDocument: selectedCode != 0,
                                driverDocumentData: listDriverDocumentData.elementAt(index),
                                voidCallback: (File? document) {
                                  switch(index) {
                                    case 0: fileCarteGrise = document;
                                      break;
                                    case 1: filePlaque = document;
                                      break;
                                  }
                                },
                              );
                            }),
                      )
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
                        padding: const EdgeInsets.only(bottom: 20),
                        child: DefaultActionButton(
                          isLoading: isLoadingProgress,
                          textButton: "Changer",
                          onClickCallback: () => onButtonClick(context),
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
