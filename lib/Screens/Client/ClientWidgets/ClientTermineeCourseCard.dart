import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:latlong2/latlong.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/ClientProviders/ClientColisProvider.dart';
import 'package:monlivreur/Providers/PolylineLivreur.dart';
import 'package:monlivreur/Screens/Client/ClientScreens/DetailsClient.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';

class ClientTermineeCourseCard extends StatefulWidget {
  const ClientTermineeCourseCard({super.key});

  @override
  State<ClientTermineeCourseCard> createState() =>
      _ClientTermineeCourseCardState();
}

class _ClientTermineeCourseCardState extends State<ClientTermineeCourseCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClientColisProvider>(
      builder: (context, Colis, _) {
        return RefreshIndicator(
          color: AppThemeMode.primaryColor,
          onRefresh: () async {
            Provider.of<ClientColisProvider>(context, listen: false).fetchAndSetClientColis(5);
          },
          child: ListView.builder(
              itemCount: Colis.clientColisTermine.length,
              itemBuilder: ((context, i) {
                return Colis.clientColisTermine == []
                    ? Center(child: Text('il n\'y a accune announce pour le moment ',
                  style: myTextStyleBase.bodyText2,),
                ) : Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    color: Color.fromARGB(103, 133, 250, 137),
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
                                        backgroundColor: Colors.transparent, radius: 16,
                                        backgroundImage: NetworkImage("${Colis.clientColisTermine[i]
                                            .infopersonLivreur?.photoINFO}"),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(Colis.clientColisTermine[i].infopersonLivreur?.userINFO??"")
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    Colis.clientColisTermine[i].ref_coli??"",
                                    style: myTextStyleBase.bodyText2,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                                Text("${((Colis.clientColisTermine[i].geopam?.routes![0].duration)! / 100).round()} mins",
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
                                                Text("${((Colis.clientColisTermine[i].geopam?.routes![0].distance)/ 1000).round()} Km",
                                                    style: myTextStyleBase.bodyText2),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: RatingBar.builder(
                                      itemSize: 20,
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      ignoreGestures: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
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
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.black,
                                  side: BorderSide(color: Colors.black)),
                              onPressed: () async {

                                await Provider.of<ClientColisProvider>(context, listen: false)
                                    .fetchAndSetClientColisById(Colis.clientColisTermine[i].id,);

                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsClient()),);

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
