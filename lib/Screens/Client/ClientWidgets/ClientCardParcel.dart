import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:monlivreur/Providers/PhoneCall.dart';
import 'package:monlivreur/Screens/Client/ClientScreens/DetailsClient.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../ConstantsWidgets/Constants.dart';
import '../../../Providers/ClientProviders/ClientColisProvider.dart';
import '../../../Providers/PolylineLivreur.dart';

class ClientCardParcel extends StatefulWidget {

  const ClientCardParcel({Key? key,}) : super(key: key);

  @override
  State<ClientCardParcel> createState() => _ClientCardParcelState();
}

class _ClientCardParcelState extends State<ClientCardParcel> {


  LatLngBounds? bounds;

  var indexx = -1;

  String getDuration(DateTime dateTime){
    var duration = DateTime.now().difference(dateTime);
    if(duration.inHours < 1){
      return "Dernière mise à jour : il y a ${duration.inMinutes} min";
    } else if(duration.inHours >= 1 && duration.inHours < 24){
      return "Dernière mise à jour : il y a ${duration.inHours} heure(s)";
    } else {
      return "Dernière mise à jour : il y a ${duration.inDays} jour(s)";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientColisProvider>(
      builder: (context, Colis, _) {
        return RefreshIndicator(
          color: AppThemeMode.primaryColor,
          onRefresh: () async {
            Provider.of<ClientColisProvider>(context, listen: false).fetchAndSetClientColis(null);
          },
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemCount: Colis.clientColis.length,
            itemBuilder: ((context, i) {

              if (Colis.clientColis == []) {
                return Center(
                      child: Text(
                        'il n\'y a accune announce pour le moment ',
                        style: myTextStyleBase.bodyText2,
                      ),
                    );
              } else {
                return InkWell(
                  onTap: () async {
                    await Provider.of<ClientColisProvider>(context, listen: false)
                        .fetchAndSetClientColisById(Colis.clientColis[i].id,);

                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsClient()),);
                  },
                  child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 8
                        ),
                        child: Container(
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                                left: 12,
                                bottom: 14
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                Colis.clientColis[i].ref_coli ?? "",
                                                style: myTextStyleBase.headline2,),
                                            ),

                                            Colis.clientColis[i].etat?.id_etat == 1? SizedBox():
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: GestureDetector(
                                                onTap: () {
                                                  showModalBottomSheet<void>(
                                                    elevation: 10,
                                                    backgroundColor: Colors.transparent,
                                                    context: context,
                                                    builder: (BuildContext
                                                    context) {
                                                      return Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          color: PrimaryColorY,
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(20),
                                                            topRight: Radius.circular(20),
                                                          ),
                                                        ),
                                                        height: 200,
                                                        child: Column(
                                                          children: <Widget>[
                                                            SizedBox(height: 10,),
                                                            Padding(padding:
                                                              const EdgeInsets.all(8.0),
                                                              child: Text('Informations sur le livreur',
                                                                style: myTextStyleBase.headline1,),
                                                            ),
                                                            Padding(padding:
                                                              const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Icon(Icons.person_pin_rounded),
                                                                  SizedBox(width: 5,),
                                                                  Text(Colis.clientColis[i].infopersonLivreur?.userINFO ?? "",
                                                                    style: myTextStyleBase.headline2,),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(padding: const EdgeInsets.all(8.0),
                                                              child:
                                                              InkWell(
                                                                onTap: () {
                                                                  Utils.openPhoneCall(phoneNumber:
                                                                      Colis.clientColis[i].infopersonLivreur?.phoneINFO??"");
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.phone_iphone),
                                                                    SizedBox(width: 5,),
                                                                    Text(Colis.clientColis[i].infopersonLivreur?.phoneINFO??"",
                                                                      style: myTextStyleBase.headline2,),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor: Colors.transparent, radius: 18,
                                                          backgroundImage: NetworkImage("${Colis.clientColis[i]
                                                              .infopersonLivreur?.photoINFO}"),
                                                        ),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 2,),
                                                    Text(Colis.clientColis[i].infopersonLivreur?.userINFO ?? ""),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          Colis.clientColis[i].etat?.etat ?? "",
                                          style: myTextStyleBase.headline3,
                                        ),
                                        Text(getDuration(DateTime.parse(
                                            Colis.clientColis[i].dateColis!.date!)),
                                          style: myTextStyleBase.bodyText2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width * 0.75,
                                      lineHeight: 5,
                                      percent: Colis.clientColis[i].etat?.id_etat == 1?
                                      0.2 : Colis.clientColis[i].etat?.id_etat == 2? 0.5: 0.8,
                                      progressColor: PrimaryColorY,
                                      backgroundColor: Colors.grey[100],
                                      barRadius: Radius.circular(2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                );
              }
            })),
        );
      },
    );
  }
}
