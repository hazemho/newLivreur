import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/ClientProviders/ClientColisProvider.dart';
import 'package:monlivreur/Providers/PhoneCall.dart';
import 'package:monlivreur/Screens/Client/ClientScreens/DetailsClient.dart';
import 'package:monlivreur/Screens/Client/model/ColisData.dart';
import 'package:monlivreur/Screens/livreur/LivreurWidgets/LivreurDtailsCard.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../Providers/PolylineLivreur.dart';

class ClientRejeteeCourseCard extends StatefulWidget {
  const ClientRejeteeCourseCard({super.key});

  @override
  State<ClientRejeteeCourseCard> createState() =>
      _ClientRejeteeCourseCardState();
}

class _ClientRejeteeCourseCardState extends State<ClientRejeteeCourseCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClientColisProvider>(
      builder: (context, Colis, _) {
        return RefreshIndicator(
          color: AppThemeMode.primaryColor,
          onRefresh: () async {
            Provider.of<ClientColisProvider>(context, listen: false)
                .fetchAndSetClientColis(4);
          },
          child: ListView.builder(
              itemCount: Colis.clientColisRejete.length,
              itemBuilder: ((context, i) {
                return Colis.clientColisRejete == []
                    ? Center(
                        child: Text(
                          'il n\'y a accune announce pour le moment ',
                          style: myTextStyleBase.bodyText2,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          color: Color.fromARGB(144, 255, 135, 126),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 14,
                                              backgroundImage: NetworkImage(
                                                  "${Colis.clientColisRejete[i].infopersonLivreur?.photoINFO}"),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(Colis
                                                    .clientColisRejete[i]
                                                    .infopersonLivreur
                                                    ?.userINFO ??
                                                "")
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          Colis.clientColisRejete[i].ref_coli ??
                                              "",
                                          style: myTextStyleBase.bodyText2,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                                height: 20,
                                                child: Icon(
                                                  Icons.timelapse,
                                                  color:
                                                      AppThemeMode.primaryColor,
                                                )),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text('Times:',
                                                      style: myTextStyleBase
                                                          .bodyText2),
                                                  Text(
                                                      "${((Colis.clientColisRejete[i].geopam?.routes![0].duration)! / 100).round()} mins",
                                                      style: myTextStyleBase
                                                          .bodyText2),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                                height: 16,
                                                child: Image.asset(
                                                    'assets/livreurCard.png')),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text('Distance:',
                                                      style: myTextStyleBase
                                                          .bodyText2),
                                                  Text(
                                                      "${((Colis.clientColisRejete[i].geopam?.routes![0].distance) / 1000).round()} Km",
                                                      style: myTextStyleBase
                                                          .bodyText2),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    Utils.openPhoneCall(
                                        phoneNumber: Colis.clientColisRejete[i]
                                                .infopersonLivreur?.phoneINFO ??
                                            "");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      children: [
                                        Icon(Icons.call),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Appeler",
                                          style: myTextStyleBase.headline2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10, top: 10),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.black,
                                        side: BorderSide(color: Colors.black)),
                                    onPressed: () async {
                                      await Provider.of<ClientColisProvider>(
                                              context,
                                              listen: false)
                                          .fetchAndSetClientColisById(
                                        Colis.clientColisRejete[i].id,
                                      );

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsClient()),
                                      );
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
              })),
        );
      },
    );
  }
}
