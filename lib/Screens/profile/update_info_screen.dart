import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/Providers/SignUp&LogIn/LoginProvider.dart';
import 'package:monlivreur/Providers/UserProvider/UserProvider.dart';
import 'package:monlivreur/Screens/authentication/widget/default_action_button.dart';
import 'package:monlivreur/Screens/authentication/widget/item_document_diver.dart';
import 'package:monlivreur/Screens/authentication/widget/snack_bar_alert.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:monlivreur/config/utils/driver_document_data.dart';
import 'package:provider/provider.dart';

class UpdateInfoScreen extends StatefulWidget {
  final int? userType;
  final String? userEmail;
  final String? userFirstName;
  final String? userAddresse;

  final String? filePermis;
  final String? fileIdentite;
  final String? fileJustification;

  const UpdateInfoScreen({
    Key? key,
    this.userType,
    this.userEmail,
    this.userFirstName,
    this.userAddresse,
    this.filePermis,
    this.fileIdentite,
    this.fileJustification,
  }) : super(key: key);

  @override
  UpdateInfoScreenState createState() => UpdateInfoScreenState();
}

class UpdateInfoScreenState extends State<UpdateInfoScreen> {
  bool hidePassword = true;
  bool isLoadingProgress = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldEmailKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldAdresseKey = GlobalKey<FormState>();
  GlobalKey<FormState> formFieldFirstNameKey = GlobalKey<FormState>();

  final TextEditingController firstNameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController adresseTextEditingController =
      TextEditingController();

  List<DriverDocumentData> listDriverDocumentData = List.empty(growable: true);

  void onButtonClick(BuildContext context) async {
    setState(() => isLoadingProgress = true);
    Provider.of<UserProvider>(context, listen: false)
        .updateUserInfo(
            emailTextEditingController.text.trim(),
            firstNameTextEditingController.text.trim(),
            adresseTextEditingController.text.trim(),
            widget.userType,
            fileIdentite?.path,
            filePermis?.path,
            fileJustification?.path)
        .then((value) {
      setState(() => isLoadingProgress = false);
      if (value.userMessage != null) {
        SnackBarAlert.show(
            context: context,
            description: "Vos données ont été mises à jour avec succès");
        Navigator.pop(context, [
          Provider.of<UserProvider>(context, listen: false).getUserProfile()
        ]);
      } else {
        SnackBarAlert.show(
            context: context,
            description: "La mise à jour de vos données a échoué");
      }
    });
  }

  String? _filePermis;
  String? _fileIdentite;
  String? _fileJustification;

  File? fileIdentite;
  File? filePermis;
  File? fileJustification;

  @override
  void initState() {
    emailTextEditingController.text = widget.userEmail ?? "";
    firstNameTextEditingController.text = widget.userFirstName ?? "";
    adresseTextEditingController.text = widget.userAddresse ?? "";

    _filePermis = widget.filePermis;
    _fileIdentite = widget.fileIdentite;
    _fileJustification = widget.fileJustification;

    listDriverDocumentData = [
      DriverDocumentData(
          documentTitle: 'Carte d\'identité',
          documentImagePath: _fileIdentite != "" ? _fileIdentite : null),
      DriverDocumentData(
          documentTitle: 'Permis de conduite',
          documentImagePath: _filePermis != "" ? _filePermis : null),
      DriverDocumentData(
          documentTitle: 'Justificatif de domicile',
          documentImagePath:
              _fileJustification != "" ? _fileJustification : null),
    ];
    super.initState();
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
    firstNameTextEditingController.dispose();
    adresseTextEditingController.dispose();
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
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(
              color: AppThemeMode.textColorBlack,
            ),
            backgroundColor: AppThemeMode.primaryColor,
          ),
          body: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                    top: 30,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: const AutoSizeText(
                            "Modification",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppThemeMode.textColorBlack,
                                fontSize: 24),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: const AutoSizeText(
                            "modifier votre coordonnées",
                            style: TextStyle(
                                color: AppThemeMode.textColorBlack,
                                fontSize: 14),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.only(bottom: 10, top: 20),
                          child: TextFormField(
                            maxLines: 1,
                            key: formFieldFirstNameKey,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(
                                color: AppThemeMode.textColorBlack),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppThemeMode.containerFieldColor,
                              contentPadding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              border: InputBorder.none,
                              hintText: "Nom",
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
                                Icons.person,
                                size: 20,
                                color: AppThemeMode.textColorBlack,
                              ),
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
                          margin: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: TextFormField(
                            maxLines: 1,
                            key: formFieldEmailKey,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                                color: AppThemeMode.textColorBlack),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppThemeMode.containerFieldColor,
                              contentPadding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              border: InputBorder.none,
                              hintText: "Email",
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
                                Icons.email,
                                size: 20,
                                color: AppThemeMode.textColorBlack,
                              ),
                            ),
                            controller: emailTextEditingController,
                            validator: (value) {
                              if (value!.isNotEmpty &&
                                  EmailValidator.validate(value)) {
                                return null;
                              } else {
                                return '*Please enter a valid email';
                              }
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: TextFormField(
                            maxLines: 1,
                            key: formFieldAdresseKey,
                            keyboardType: TextInputType.streetAddress,
                            style: const TextStyle(
                                color: AppThemeMode.textColorBlack),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppThemeMode.containerFieldColor,
                              contentPadding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              border: InputBorder.none,
                              hintText: "Adresse",
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
                                Icons.location_on_rounded,
                                size: 20,
                                color: AppThemeMode.textColorBlack,
                              ),
                            ),
                            controller: adresseTextEditingController,
                            onChanged: (value) {
                              if (value != widget.userAddresse) {
                                setState(() {
                                  _fileJustification = null;
                                  listDriverDocumentData = [
                                    DriverDocumentData(
                                        documentTitle: 'Carte d\'identité',
                                        documentImagePath: _fileIdentite != ""
                                            ? _fileIdentite
                                            : null),
                                    DriverDocumentData(
                                        documentTitle: 'Permis de conduite',
                                        documentImagePath: _filePermis != ""
                                            ? _filePermis
                                            : null),
                                    DriverDocumentData(
                                        documentTitle: 'Justification',
                                        documentImagePath:
                                            _fileJustification != ""
                                                ? _fileJustification
                                                : null),
                                  ];
                                });
                              } else {
                                setState(() {
                                  listDriverDocumentData = [
                                    DriverDocumentData(
                                        documentTitle: 'Carte d\'identité',
                                        documentImagePath: _fileIdentite != ""
                                            ? _fileIdentite
                                            : null),
                                    DriverDocumentData(
                                        documentTitle: 'Permis de conduite',
                                        documentImagePath: _filePermis != ""
                                            ? _filePermis
                                            : null),
                                    DriverDocumentData(
                                        documentTitle: 'Justification',
                                        documentImagePath:
                                            widget.fileJustification != ""
                                                ? widget.fileJustification
                                                : null),
                                  ];
                                });
                              }
                            },
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              } else {
                                return '*Please enter a valid adresse';
                              }
                            },
                          ),
                        ),
                        Visibility(
                          visible: widget.userType == 1,
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 15, top: 15),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: const AutoSizeText(
                              "Merci de nous envoyer vos documents afin de vérifier votre compte livreur",
                              style: TextStyle(
                                  color: AppThemeMode.textColorBlack,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: widget.userType == 1,
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: listDriverDocumentData.length,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.56,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                mainAxisExtent:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return ItemDocumentDiver(
                                  requiredDocument:
                                      adresseTextEditingController.text !=
                                          widget.userAddresse,
                                  driverDocumentData:
                                      listDriverDocumentData.elementAt(index),
                                  voidCallback: (File? document) {
                                    switch (index) {
                                      case 0:
                                        fileIdentite = document;
                                        break;
                                      case 1:
                                        filePermis = document;
                                        break;
                                      case 2:
                                        fileJustification = document;
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
                            if (formKey.currentState!.validate()) {
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
