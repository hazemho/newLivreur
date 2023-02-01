import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/ClientProviders/ClientColisProvider.dart';
import 'package:monlivreur/Providers/LivreurProviders/LivreurColisProvider.dart';
import 'package:monlivreur/Screens/Client/model/ColisData.dart';
import 'package:monlivreur/Screens/livreur/LivreurWidgets/LivreurDtailsCard.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../Providers/PolylineLivreur.dart';

class LivreurRejeteeCourseCard extends StatefulWidget {
  const LivreurRejeteeCourseCard({super.key});

  @override
  State<LivreurRejeteeCourseCard> createState() =>
      _LivreurRejeteeCourseCardState();
}

class _LivreurRejeteeCourseCardState extends State<LivreurRejeteeCourseCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LivreurColisProvider>(
      builder: (context, Colis, _) => RefreshIndicator(
        color: AppThemeMode.primaryColor,
        onRefresh: () async {
          Provider.of<LivreurColisProvider>(context, listen: false).fetchAndSetLivreurColis(4);
        },
        child: ListView.builder(
            itemCount: Colis.livreurColisRejete.length,
            itemBuilder: ((context, i) {
              return Colis.livreurColisRejete == [] ?
              Center(child: Text(
                'il n\'y a accune announce pour le moment ',
                style: myTextStyleBase.bodyText2,),) :
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  color: Color.fromARGB(144, 255, 135, 126),
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
                                      backgroundImage: NetworkImage(Colis.livreurColisRejete[i]
                                          .infopersonUser?.photoINFO??""),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(Colis.livreurColisRejete[i].infopersonUser?.userINFO??"")
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  Colis.livreurColisRejete[i].ref_coli??"",
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
                                        child: Icon(Icons.timelapse,
                                          color: AppThemeMode.primaryColor,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text('Times:',
                                              style: myTextStyleBase.bodyText2),
                                          Text("${((Colis.livreurColisRejete[i].geopam?.routes![0].duration)! / 100).round()} mins",
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
                                        child: Image.asset(
                                            'assets/livreurCard.png')),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text('Distance:',
                                              style: myTextStyleBase.bodyText2),
                                          Text("${((Colis.livreurColisRejete[i].geopam?.routes![0].distance)/ 1000).round()} Km",
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0, backgroundColor: Colors.transparent,
                                foregroundColor: Colors.black,
                                side: BorderSide(color: Colors.black)),
                            onPressed: () async {
                              await Provider.of<LivreurColisProvider>(context, listen: false)
                                  .fetchAndSetLivreurColisById(Colis.livreurColisRejete[i].id,);
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
            })),
      ),
    );
  }
}
