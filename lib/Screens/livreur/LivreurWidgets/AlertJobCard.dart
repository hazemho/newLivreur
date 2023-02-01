import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:monlivreur/Providers/LivreurProviders/LivreurColisProvider.dart';
import 'package:monlivreur/Providers/PolylineLivreur.dart';
import 'package:monlivreur/Screens/Client/model/ColisData.dart';
import 'package:monlivreur/Screens/livreur/LivreurWidgets/BottomLivreurNavigation.dart';
import 'package:monlivreur/Screens/livreur/LivreurWidgets/LivreurDtailsCard.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../ConstantsWidgets/Constants.dart';

class AlertJobCard extends StatefulWidget {

  final int index;
  final ColisData? colisData;
  const AlertJobCard({super.key, this.colisData, required this.index});

  @override
  State<AlertJobCard> createState() => _AlertJobCardState();
}

class _AlertJobCardState extends State<AlertJobCard> {


  ColisData? colisData;

  @override
  void initState() {
    colisData = widget.colisData;
    super.initState();
  }


  @override
  void didUpdateWidget(covariant AlertJobCard oldWidget) {
    if(widget.colisData?.id != oldWidget.colisData?.id){
      colisData = widget.colisData;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent, radius: 20,
                            backgroundImage: NetworkImage(colisData?.infopersonUser?.photoINFO??""),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(colisData?.infopersonUser?.userINFO?? "",)
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(colisData?.ref_coli?? "",
                        style: myTextStyleBase.bodyText2,
                      ),
                    ],
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
                                    Text('Time:',
                                        style: myTextStyleBase.bodyText2),
                                    Text("${((colisData?.geopam?.routes![0].duration)! / 100).round()} mins",
                                        style: myTextStyleBase.bodyText2),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(height: 20,
                                  child: Image.asset('assets/livreurCard.png')),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text('Distance:',
                                        style: myTextStyleBase.bodyText2),
                                    Text("${((colisData?.geopam?.routes![0].distance)/ 1000).round()} Km",
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Adresse de ramassage',
                    style: myTextStyleBase.headline4,),
                  Text(
                    colisData?.infopersonEnv?.adresse?.placeadresse ?? "",
                    style: myTextStyleBase.AdresseTextLivreur1,),
                  Divider(),
                  Text('Adresse de Livraison',
                    style: myTextStyleBase.headline4,),
                  Text(
                    colisData?.infopersonRec?.adresse?.placeadresse ?? "",
                    style: myTextStyleBase.AdresseTextLivreur1,),
                ],
              ),
            ),
            Row(
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
                      onPressed: () {
                        showDialog(context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Alert d\'emploi'),
                            content: Text('Voulez-vous décliner  ?'),
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
                                      .setColisDecline(widget.colisData?.id),
                                    Provider.of<LivreurColisProvider>(context, listen: false)
                                      .fetchAndSetAlertColis()
                                  ]);
                                },
                              )
                            ],
                          ),
                        );
                      },
                      child: Text('DECLINE', style: myTextStyleBase.headline3),
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
                            content: Text('Voulez-vous accepter  ?'),
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
                                      .setEtatColis(colisData?.id, 2),
                                  Provider.of<LivreurColisProvider>(context, listen: false)
                                      .fetchAndSetAlertColis(),
                                  Navigator.pushReplacementNamed(context,
                                      BottomLivreurNavigation.bottomLivreurNavigation),
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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.black)),
                  onPressed: () async {

                    await Provider.of<LivreurColisProvider>(context, listen: false)
                        .fetchAndSetLivreurColisById(colisData?.id,);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LivreurDetailsCard()),);

                  },
                  child: Text('VOIR LES DETAILS DU COLIS',
                      style: myTextStyleBase.headline3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
