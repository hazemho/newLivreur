import 'package:flutter/material.dart';
import 'package:monlivreur/Providers/LivreurProviders/LivreurColisProvider.dart';
import 'package:monlivreur/Screens/Client/model/ColisData.dart';
import 'package:monlivreur/Screens/livreur/LivreurWidgets/LivreurMapTrack.dart';
import 'package:monlivreur/Screens/livreur/LivreurWidgets/livreurSmallMapDetails.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../ConstantsWidgets/Constants.dart';

// ignore: must_be_immutable
class LivreurDetailsCard extends StatefulWidget {


  const LivreurDetailsCard({super.key});


  @override
  State<LivreurDetailsCard> createState() => _LivreurDetailsCardState();
}

class _LivreurDetailsCardState extends State<LivreurDetailsCard> {

  bool _isloading = false;

  void getCurrentLocation(ColisData? colisData) async {

    setState(() => _isloading = true);
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        LivreurMapTrack(colisData, isEnable: true,)),);
    setState(() => _isloading = false);
  }

  @override
  void initState() {
    // getCurrentLocation();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Consumer<LivreurColisProvider>(
          builder: (context, Colis, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Détails',
                        style: myTextStyleBase.headline1,
                      ),
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  Container(
                                      height: 20,
                                      child: Icon(Icons.timelapse,
                                        color: AppThemeMode.primaryColor,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text('Times:',
                                            style: myTextStyleBase.bodyText2),
                                        Text("${((Colis.livreurDetailsColis?.geopam?.routes![0].duration)! / 100).round()} mins",
                                            style: myTextStyleBase.bodyText2),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                      height: 20,
                                      child:
                                          Image.asset('assets/livreurCard.png')),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text('Distance:',
                                            style: myTextStyleBase.bodyText2),
                                        Text("${((Colis.livreurDetailsColis?.geopam?.routes![0].distance)! / 1000).round()} Km",
                                            style: myTextStyleBase.bodyText2),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, left: 12, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          Colis.livreurDetailsColis?.ref_coli ?? "",
                                          style: myTextStyleBase.headline2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                              child: LivreurSmallMapDetails(
                                geopam: Colis.livreurDetailsColis?.geopam,
                                sourceLatLng: Colis.livreurDetailsColis?.infopersonEnv?.adresse,
                                destinationLatLng: Colis.livreurDetailsColis?.infopersonRec?.adresse,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Statut : ',
                              style: myTextStyleBase.headline4,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(Colis.livreurDetailsColis?.etat?.etat??"",
                          style: myTextStyleBase.checkoutInfosText,),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Adresse de ramassage',
                          style: myTextStyleBase.headline3,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          Colis.livreurDetailsColis?.infopersonEnv?.nom ?? "",
                          style: myTextStyleBase.checkoutInfosText,
                        ),
                        Text(
                          Colis.livreurDetailsColis?.infopersonEnv?.phone_number ?? "",
                          style: myTextStyleBase.checkoutInfosText,
                        ),
                        Text(
                          Colis.livreurDetailsColis?.infopersonEnv?.adresse?.placeadresse ?? "",
                          style: myTextStyleBase.checkoutInfosText,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Adresse de livraison',
                          style: myTextStyleBase.headline3,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          Colis.livreurDetailsColis?.infopersonRec?.nom ?? "",
                          style: myTextStyleBase.checkoutInfosText,
                        ),
                        Text(
                          Colis.livreurDetailsColis?.infopersonRec?.phone_number ?? "",
                          style: myTextStyleBase.checkoutInfosText,
                        ),
                        Text(
                          Colis.livreurDetailsColis?.infopersonRec?.adresse?.placeadresse ?? "",
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
                          Colis.livreurDetailsColis?.taille ?? "",
                          style: myTextStyleBase.checkoutInfosText,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Nature de Colis',
                          style: myTextStyleBase.headline3,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Alimentaire',
                          style: myTextStyleBase.checkoutInfosText,
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        (Colis.livreurDetailsColis?.lastCommentaire??[]).isNotEmpty?
                        Column(
                          children: [
                            Text(
                              'Commentaires',
                              style: myTextStyleBase.headline3,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              (Colis.livreurDetailsColis?.lastCommentaire ?? []).isNotEmpty?
                              (Colis.livreurDetailsColis?.lastCommentaire ?? []).first.commentaire?? "" : "",
                              style: myTextStyleBase.checkoutInfosText,
                            ),
                          ],
                        ): SizedBox(),


                        Visibility(
                          visible: Colis.livreurDetailsColis?.etat?.id_etat == 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 5),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      side: BorderSide(color: Colors.black),
                                    ),
                                    onPressed: ()  {

                                      showDialog(context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Text('Alert d\'emploi'),
                                          content: Text('Voulez-vous décliner cette offre ?'),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: AppThemeMode.primaryColor),
                                              child: Text('Non'),
                                              onPressed: () {
                                                Navigator.of(ctx).pop([]);
                                              },
                                            ),
                                            ElevatedButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: AppThemeMode.primaryColor),
                                              child: Text('Oui'),
                                              onPressed: () {
                                                Navigator.of(ctx).pop([
                                                  Provider.of<LivreurColisProvider>(context, listen: false)
                                                    .setColisDecline(Colis.livreurDetailsColis?.id),

                                                 Provider.of<LivreurColisProvider>(context, listen: false)
                                                    .fetchAndSetLivreurColisById(Colis.livreurDetailsColis?.id),

                                                 Provider.of<LivreurColisProvider>(context, listen: false)
                                                    .fetchAndSetAlertColis()
                                                ]);
                                              },
                                            )
                                          ],
                                        ),
                                      );

                                    },
                                    child: Text('DECLINE',
                                        style: myTextStyleBase.headline3),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 20),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: PrimaryColorY,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {

                                      showDialog(context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Text('Alert d\'emploi'),
                                          content: Text('Voulez-vous accepter cette offre ?'),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: AppThemeMode.primaryColor),
                                              child: Text('Non'),
                                              onPressed: () {
                                                Navigator.of(ctx).pop([]);
                                              },
                                            ),
                                            ElevatedButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: AppThemeMode.primaryColor),
                                              child: Text('Oui'),
                                              onPressed: () {
                                                Navigator.of(ctx).pop([
                                                 Provider.of<LivreurColisProvider>(context, listen: false)
                                                    .setEtatColis(Colis.livreurDetailsColis?.id, 2),

                                                 Provider.of<LivreurColisProvider>(context, listen: false)
                                                    .fetchAndSetLivreurColisById(Colis.livreurDetailsColis?.id),

                                                 Provider.of<LivreurColisProvider>(context, listen: false)
                                                    .fetchAndSetAlertColis(),
                                                ]);
                                              },
                                            )
                                          ],
                                        ),
                                      );

                                    },
                                    child: Text('ACCEPT',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: Colis.livreurDetailsColis?.etat?.id_etat == 1,
                          child: _isloading
                              ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      side: BorderSide(color: Colors.black)),
                                  onPressed: () {},
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: PrimaryColorY,
                                    ),
                                  )),
                            ),
                          )
                              : Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    side: BorderSide(color: Colors.black)),
                                onPressed: () {
                                  showDialog(context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text('Alert d\'emploi'),
                                      content: Text('Voulez-vous commencer la livraison ?'),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: AppThemeMode.primaryColor),
                                          child: Text('Non'),
                                          onPressed: () {
                                            Navigator.of(ctx).pop([]);
                                          },
                                        ),
                                        ElevatedButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: AppThemeMode.primaryColor),
                                          child: Text('Oui'),
                                          onPressed: () {
                                            Navigator.of(ctx).pop([
                                              getCurrentLocation(Colis.livreurDetailsColis)
                                            ]);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: Text('Commencer la livraison',
                                    style: myTextStyleBase.headline3),
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
      ),
    );
  }
}
