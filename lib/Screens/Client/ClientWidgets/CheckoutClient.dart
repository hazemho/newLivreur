import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:monlivreur/Providers/LocationAdressProvider.dart';
import 'package:monlivreur/Screens/Client/ClientWidgets/BottomClientNavigation.dart';

import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Screens/Client/model/Adresse.dart';
import 'package:monlivreur/Screens/Client/model/ColisData.dart';
import 'package:monlivreur/Screens/Client/model/DateColis.dart';
import 'package:monlivreur/Screens/Client/model/InfoPerson.dart';
import 'package:monlivreur/Screens/authentication/action_choose_screen.dart';
import 'package:monlivreur/config/route_transition/fade_route.dart';
import 'package:provider/provider.dart';


import '../../../Providers/ClientProviders/ClientColisProvider.dart';
import '../../../Providers/SommaireDetailsProvider.dart';

class CheckoutClient extends StatefulWidget {
  const CheckoutClient({super.key});

  @override
  State<CheckoutClient> createState() => _CheckoutClientState();
}

class _CheckoutClientState extends State<CheckoutClient> {
  bool isloading = false;
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

    int? tailleColisValue =
        Provider.of<SommaireDetailsProvider>(context).getTailleColisValue;
    String tailleColis =
        Provider.of<SommaireDetailsProvider>(context).getTailleColis;

    String nomLivreur =
        Provider.of<SommaireDetailsProvider>(context).getnomLivreur;
    String phoneLivreur =
        Provider.of<SommaireDetailsProvider>(context).getphoneLivreur;
    String emailLivraison =
        Provider.of<SommaireDetailsProvider>(context).getEmailLivreur;
    String adresseLivraison =
        Provider.of<LocationAdressProvider>(context).LocationAdress;

    String emailRamassage =
        Provider.of<SommaireDetailsProvider>(context).getemailEnvoyeur;
    String adresseRamassage =
        Provider.of<LocationAdressProvider>(context).LocationDestinationAdress;
    String nomEnvoyeur =
        Provider.of<SommaireDetailsProvider>(context).getnomEnvoyeur;
    String phoneEnvoyeur =
        Provider.of<SommaireDetailsProvider>(context).getphoneEnvoyeur;

    String dateColis =
        Provider.of<SommaireDetailsProvider>(context).getDateColis;
    String timeColis =
        Provider.of<SommaireDetailsProvider>(context).getTimeColis;
    String descriptionColis =
        Provider.of<SommaireDetailsProvider>(context, listen: false).getDescriptionColis;

    LatLng sourceCoord =
        Provider.of<LocationAdressProvider>(context, listen: false).CoordSource;
    LatLng destinationCoord =
        Provider.of<LocationAdressProvider>(context, listen: false).CoordDestination;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Sommaire',
                      style: myTextStyleBase.headline4,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Nature du Colis',
                    style: myTextStyleBase.headline3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (alimentaireColis == 'Alimentaire')
                    Text(
                      alimentaireColis,
                      style: myTextStyleBase.checkoutInfosText,
                    ),
                  if (electronicColis == 'Electronique')
                    Text(
                      electronicColis,
                      style: myTextStyleBase.checkoutInfosText,
                    ),
                  if (flameColis == 'Marchandises inflammables')
                    Text(
                      flameColis,
                      style: myTextStyleBase.checkoutInfosText,
                    ),
                  if (autreColis == 'Autres')
                    Text(
                      autreColis,
                      style: myTextStyleBase.checkoutInfosText,
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Informations sur l\'envoyeur',
                    style: myTextStyleBase.headline3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    nomEnvoyeur,
                    style: myTextStyleBase.checkoutInfosText,
                  ),
                  Text(
                    phoneEnvoyeur,
                    style: myTextStyleBase.checkoutInfosText,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    adresseRamassage,
                    style: myTextStyleBase.checkoutInfosText,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Informations sur le récepteur',
                    style: myTextStyleBase.headline3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    nomLivreur,
                    style: myTextStyleBase.checkoutInfosText,
                  ),
                  Text(
                    phoneLivreur,
                    style: myTextStyleBase.checkoutInfosText,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    adresseLivraison,
                    style: myTextStyleBase.checkoutInfosText,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Taille du colis',
                    style: myTextStyleBase.headline3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    tailleColis,
                    style: myTextStyleBase.checkoutInfosText,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Date de livraison',
                    style: myTextStyleBase.headline3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    dateColis,
                    style: myTextStyleBase.checkoutInfosText,
                  ),
                  Text(
                    timeColis,
                    style: myTextStyleBase.checkoutInfosText,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Descriptions du colis',
                    style: myTextStyleBase.headline3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    descriptionColis,
                    style: myTextStyleBase.checkoutInfosText,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isloading = true;
                          });
                          if ((alimentaireColis == '' ||
                                  electronicColis == '' ||
                                  flameColis == '' ||
                                  autreColis == '') &&
                              tailleColis == '' &&
                              nomEnvoyeur == '' &&
                              phoneEnvoyeur == '' &&
                              adresseRamassage == '' &&
                              nomLivreur == '' &&
                              phoneLivreur == '' &&
                              adresseLivraison == '' &&
                              descriptionColis == '' &&
                              dateColis == '') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Vérifier vos données",
                                  style: TextStyle(color: PrimaryColorY)),
                            ));
                          } else {
                            await Provider.of<ClientColisProvider>(context, listen: false).setClientColis(
                              ColisData(
                                taille: tailleColis, description: descriptionColis,
                                dateColis: DateColis(
                                  time: timeColis, date: dateColis,
                                ),
                                infopersonEnv: InfoPerson(
                                  nom: nomEnvoyeur,
                                  email: emailRamassage,
                                  phone_number: phoneEnvoyeur,
                                  adresse: Adresse(
                                    placeadresse: adresseRamassage,
                                    laltitude: "${sourceCoord.latitude}",
                                    longitude: "${sourceCoord.longitude}",
                                  )
                                ),
                                infopersonRec: InfoPerson(
                                    nom: nomLivreur,
                                    email: emailLivraison,
                                    phone_number: phoneLivreur,
                                    adresse: Adresse(
                                      placeadresse: adresseLivraison,
                                      laltitude: "${destinationCoord.latitude}",
                                      longitude: "${destinationCoord.longitude}",
                                    )
                                )
                              ),
                                tailleColisValue,
                              [
                                alimentaireColis.isNotEmpty? 1:null,
                                electronicColis.isNotEmpty? 2:null,
                                flameColis.isNotEmpty? 3:null,
                                autreColis.isNotEmpty? 4:null,
                              ]
                            );
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PickAlimentaireColis('');
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PickAutreColis('');
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PickDateColis('');
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PickDescriptionColis('');
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PickElectronicColis('');
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PickEmailLivreur('');
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PickFlameColis('');
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PickTailleColis('');
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PickTimeColis('');
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PickadresseLivreur('');
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PickemailEnvoyeur('');
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PicknomEnvoyeur('');
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PicknomLivreur('');
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PickphoneEnvoyeur('');
                            Provider.of<SommaireDetailsProvider>(
                                context, listen: false).PickphoneLivreur('');

                            Navigator.pushNamed(context, BottomClientNavigation.bottomClientNavigation);
                            /// Navigator.pushReplacement(context, FadeRoute(page: ActionChooseScreen()),);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Votre colis est publié", style: TextStyle(color: PrimaryColorY)),));
                          }
                          setState(() => isloading = false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MonLTextDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            // side: BorderSide(width: 2, color: Colors.white),
                          ),
                          minimumSize: Size.fromHeight(28),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: isloading
                              ? CircularProgressIndicator(color: PrimaryColorY,)
                              : Text('Publier', style: myTextStyleBase.button,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
