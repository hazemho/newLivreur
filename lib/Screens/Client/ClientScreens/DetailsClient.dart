import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/ClientProviders/ClientColisProvider.dart';
import 'package:monlivreur/Screens/Client/model/ColisData.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../Providers/PhoneCall.dart';
import '../../livreur/LivreurWidgets/livreurSmallMapDetails.dart';

// ignore: must_be_immutable
class DetailsClient extends StatefulWidget {

  @override
  State<DetailsClient> createState() => _DetailsClientState();
}

class _DetailsClientState extends State<DetailsClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Consumer<ClientColisProvider>(
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
                                        Text("${((Colis.clientDetailsColis?.geopam?.routes![0].duration)! / 100).round()} mins",
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
                                        Text("${((Colis.clientDetailsColis?.geopam?.routes![0].distance)! / 1000).round()} Km",
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
                                          Colis.clientDetailsColis?.ref_coli?? "",
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
                                geopam: Colis.clientDetailsColis?.geopam,
                                sourceLatLng: Colis.clientDetailsColis?.infopersonEnv?.adresse,
                                destinationLatLng: Colis.clientDetailsColis?.infopersonRec?.adresse,
                              )
                          )
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
                        Text(Colis.clientDetailsColis?.etat?.etat??"",
                          style: myTextStyleBase.checkoutInfosText,),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Nature du Colis',
                          style: myTextStyleBase.headline3,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...?Colis.clientDetailsColis?.natures?.map((element) {
                            return Text(element, style: myTextStyleBase.checkoutInfosText,);
                          }).toList()
                          ],
                        ),
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
                          Colis.clientDetailsColis?.infopersonEnv?.nom ?? "",
                          style: myTextStyleBase.checkoutInfosText,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Utils.openPhoneCall(
                                    phoneNumber: Colis.clientDetailsColis?.infopersonEnv?.phone_number?? "");
                              },
                              child: Text(
                                Colis.clientDetailsColis?.infopersonEnv?.phone_number?? "",
                                style: myTextStyleBase.checkoutInfosText,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          Colis.clientDetailsColis?.infopersonEnv?.adresse?.placeadresse?? "",
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
                          Colis.clientDetailsColis?.infopersonRec?.nom?? "",
                          style: myTextStyleBase.checkoutInfosText,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Utils.openPhoneCall(
                                    phoneNumber: Colis.clientDetailsColis?.infopersonRec?.phone_number?? "");
                              },
                              child: Text(
                                Colis.clientDetailsColis?.infopersonRec?.phone_number?? "",
                                style: myTextStyleBase.checkoutInfosText,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          Colis.clientDetailsColis?.infopersonRec?.adresse?.placeadresse?? "",
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
                          Colis.clientDetailsColis?.taille?? "",
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
                          Colis.clientDetailsColis?.description?? "",
                          style: myTextStyleBase.checkoutInfosText,
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        (Colis.clientDetailsColis?.lastCommentaire??[]).isNotEmpty?
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
                              (Colis.clientDetailsColis?.lastCommentaire ?? []).isNotEmpty?
                              (Colis.clientDetailsColis?.lastCommentaire ?? []).first.commentaire?? "" : "",
                              style: myTextStyleBase.checkoutInfosText,
                            ),
                          ],
                        ): SizedBox(),


                        Visibility(visible: false,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Colis.clientDetailsColis?.etat?.id_etat == 0
                                ? Text(
                                    'Dans l\'attente de l\'acceptation du livreur',
                                    style: myTextStyleBase.bodyText2,
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: PrimaryColorY,
                                            radius: 20,
                                            child: Container(
                                              color: PrimaryColorY,
                                              child: Image.asset('assets/Truck.png'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Colis en transit',
                                                style: myTextStyleBase.headline2,
                                              ),
                                              Text(
                                                '21.08.2020 - 16:10',
                                                style: myTextStyleBase.bodyText2,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: PrimaryColorY,
                                            radius: 20,
                                            child: Container(
                                              color: PrimaryColorY,
                                              child:
                                                  Image.asset('assets/Courier.png'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Parcel handed over to the courier.',
                                                style: myTextStyleBase.headline2,
                                              ),
                                              Text(
                                                '21.08.2020 - 8:23',
                                                style: myTextStyleBase.bodyText2,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: PrimaryColorY,
                                            radius: 20,
                                            child: Container(
                                              color: PrimaryColorY,
                                              child: Image.asset(
                                                  'assets/Sendparcel2.png'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Parcel prepared - not yet handed over to the courier.',
                                                  style: myTextStyleBase.headline2,
                                                ),
                                                Text(
                                                  '20.08.2020 - 18:48',
                                                  style: myTextStyleBase.bodyText2,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
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
