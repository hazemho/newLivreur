import 'package:flutter/material.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/LocationAdressProvider.dart';
import 'package:monlivreur/Providers/SommaireDetailsProvider.dart';
import 'package:monlivreur/Screens/Client/ClientWidgets/NatureColis.dart';
import 'package:monlivreur/Screens/Client/ClientWidgets/ProgramLaivraisons.dart';
import 'package:monlivreur/Screens/Client/ClientWidgets/SendParcelDeliveryDestination.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../ClientWidgets/DescriptionsColis.dart';
import '../ClientWidgets/SendParcelDeliveryRamassage.dart';
import '../ClientWidgets/CheckoutClient.dart';
import '../ClientWidgets/TailleColis.dart';

class SendParcel extends StatefulWidget {
  const SendParcel({super.key});

  @override
  State<SendParcel> createState() => _SendParcelState();
}

class _SendParcelState extends State<SendParcel> {


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        buttonPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10, vertical: 8
        ),
        title: Text('Une erreur se produite'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            Padding(
              padding: const EdgeInsets.only(
                top: 20, bottom: 10
              ),
              child: ElevatedButton(
                style: TextButton.styleFrom(
                    backgroundColor: AppThemeMode.primaryColor),
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            )
          ],
        ),
        actions: <Widget>[

        ],
      ),
    );
  }

  int _currentStep = 0;

  bool selectedList1 = false;
  bool selectedList2 = false;
  bool selectedList3 = false;
  bool selectedList4 = false;
  bool selectedList5 = false;
  bool selectedList6 = false;
  bool selectedList7 = false;

  @override
  Widget build(BuildContext context) {
    String alimentaireColis =
        Provider.of<SommaireDetailsProvider>(context).getAlimentaireColis;
    String electronicColis =
        Provider.of<SommaireDetailsProvider>(context).getElectronicColis;
    String flameColis =
        Provider.of<SommaireDetailsProvider>(context).getFlameColis;
    String autreColis =
        Provider.of<SommaireDetailsProvider>(context).getAutreColis;

    String tailleColis =
        Provider.of<SommaireDetailsProvider>(context).getTailleColis;

    String nomLivreur =
        Provider.of<SommaireDetailsProvider>(context).getnomLivreur;
    String emailLivreur =
        Provider.of<SommaireDetailsProvider>(context).getEmailLivreur;
    String phoneLivreur =
        Provider.of<SommaireDetailsProvider>(context).getphoneLivreur;
    String adresseLivraison =
        Provider.of<LocationAdressProvider>(context).LocationAdress;

    String adresseRamassage =
        Provider.of<LocationAdressProvider>(context).LocationDestinationAdress;
    String nomEnvoyeur =
        Provider.of<SommaireDetailsProvider>(context).getnomEnvoyeur;
    String emailEnvoyeur =
        Provider.of<SommaireDetailsProvider>(context).getemailEnvoyeur;
    String phoneEnvoyeur =
        Provider.of<SommaireDetailsProvider>(context).getphoneEnvoyeur;

    String dateColis =
        Provider.of<SommaireDetailsProvider>(context).getDateColis;
    String timeColis =
        Provider.of<SommaireDetailsProvider>(context).getTimeColis;

    String descriptionColis =
        Provider.of<SommaireDetailsProvider>(context, listen: false).getDescriptionColis;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  'Envoyer un colis',
                  style: myTextStyleBase.headline1,
                ),
              ),
              Theme(
                data: ThemeData(
                    primaryColor: PrimaryColorY,
                    colorScheme: ColorScheme.light(primary: PrimaryColorY)
                        .copyWith(secondary: PrimaryColorY)),
                child: Stepper(
                  controlsBuilder: (context, controller) {
                    return const SizedBox.shrink();
                  },
                  physics: ClampingScrollPhysics(),
                  steps: _mySteps(),
                  currentStep: _currentStep,
                  onStepTapped: (step) {

                    switch(step) {
                      case 1: alimentaireColis.isNotEmpty
                          || electronicColis.isNotEmpty
                          || flameColis.isNotEmpty
                          || autreColis.isNotEmpty ?
                      setState(() => _currentStep = step): _showErrorDialog("Choisir votre nature de coli.");
                        break;
                      case 2: tailleColis.isNotEmpty ?
                      setState(() => _currentStep = step): _showErrorDialog("Choisir votre taille de coli.");
                        break;
                      case 3: nomLivreur.isNotEmpty
                          && emailLivreur.isNotEmpty
                          && phoneLivreur.isNotEmpty
                          && adresseLivraison.isNotEmpty &&
                          nomEnvoyeur.isNotEmpty
                          && emailEnvoyeur.isNotEmpty
                          && phoneEnvoyeur.isNotEmpty
                          && adresseRamassage.isNotEmpty ?
                      setState(() => _currentStep = step): _showErrorDialog("Completer la méthode de livraison");
                        break;
                      case 4: dateColis.isNotEmpty
                          || timeColis.isNotEmpty ?
                      setState(() => _currentStep = step): _showErrorDialog("Choisir la date de livraison.");;
                        break;
                      case 5: descriptionColis.isNotEmpty ?
                      setState(() => _currentStep = step): _showErrorDialog("Veuillez décrire le contenu de votre colis");
                        break;
                      default: setState(() => _currentStep = step);
                    }
                    debugPrint("On Step Tapped : $step");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text('Nature du Colis'),
        content: NatureColis(),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text('Taille du colis'),
        content: TailleColis(),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text('Méthode de livraison'),
        content: Column(
          children: [
            InkWell(
              onTap: () => setState(() => selectedList5 = !selectedList5),
              child: SendParcelDeliveryRamassage('Adresse de ramassage',
                  'assets/Doordelivery.png', selectedList5),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => setState(() => selectedList7 = !selectedList7),
              child: SendParcelDeliveryDestination('Adresse de livraison',
                  'assets/Doordelivery.png', selectedList7),
            ),
          ],
        ),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: Text('Programmer la livraison'),
        content: ProgramLaivraisons(),
        isActive: _currentStep >= 3,
      ),
      Step(
        title: Text('Descriptions'),
        content: DescriptionsColis(),
        isActive: _currentStep >= 4,
      ),
      Step(
        title: Text('Vérifier'),
        content: CheckoutClient(),
        isActive: _currentStep >= 5,
      )
    ];
    return _steps;
  }

}
