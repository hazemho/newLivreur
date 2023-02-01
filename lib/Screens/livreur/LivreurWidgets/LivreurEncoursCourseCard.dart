import 'package:flutter/material.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/LivreurProviders/LivreurColisProvider.dart';
import 'package:monlivreur/Screens/livreur/LivreurWidgets/LivreurDtailsCard.dart';
import 'package:monlivreur/Screens/livreur/LivreurWidgets/LivreurMapTrack.dart';
import 'package:monlivreur/Screens/livreur/LivreurWidgets/PopUpLivreur.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class LivreurEncoursCourseCard extends StatefulWidget {
  const LivreurEncoursCourseCard({super.key});

  @override
  State<LivreurEncoursCourseCard> createState() =>
      _LivreurEncoursCourseCardState();
}

class _LivreurEncoursCourseCardState extends State<LivreurEncoursCourseCard> {

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
    return Consumer<LivreurColisProvider>(
      builder: (context, Colis, _) => RefreshIndicator(
        color: AppThemeMode.primaryColor,
        onRefresh: () async {
          Provider.of<LivreurColisProvider>(context, listen: false).fetchAndSetLivreurColis(null);
        },
        child: ListView.builder(
            itemCount: Colis.livreurColis.length,
            itemBuilder: ((context, i) {
              if (Colis.livreurColis == []) {
                return Center(child: Text(
                'il n\'y a accune announce pour le moment ',
                style: myTextStyleBase.bodyText2,),);
              } else {
                return InkWell(
                onTap: () async {
                  await Provider.of<LivreurColisProvider>(context, listen: false)
                      .fetchAndSetLivreurColisById(Colis.livreurColis[i].id,);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LivreurDetailsCard()),);

                },
                child: Padding(
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
                                        backgroundImage: NetworkImage(Colis.livreurColis[i].infopersonUser?.photoINFO??""),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(Colis.livreurColis[i].infopersonUser?.userINFO ?? "")
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    Colis.livreurColis[i].ref_coli ?? "",
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
                                                Text('Times:',
                                                    style: myTextStyleBase.bodyText2),
                                                Text("${((Colis.livreurColis[i].geopam?.routes![0].duration)! / 100).round()} mins",
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
                                                Text("${((Colis.livreurColis[i].geopam?.routes![0].distance)/ 1000).round()} Km",
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
                              Text(
                                'Adresse de ramassage',
                                style: myTextStyleBase.headline4,
                              ),
                              Text(
                                Colis.livreurColis[i].infopersonEnv?.adresse?.placeadresse ?? "",
                                style: myTextStyleBase.AdresseTextLivreur1,
                              ),
                              Divider(),
                              Text(
                                'Adresse de Livraison',
                                style: myTextStyleBase.headline4,
                              ),
                              Text(
                                Colis.livreurColis[i].infopersonRec?.adresse?.placeadresse ?? "",
                                style: myTextStyleBase.AdresseTextLivreur1,
                              ),
                              Divider(),
                              Text(
                                Colis.livreurColis[i].etat?.etat ?? "",
                                style: myTextStyleBase.headline4,
                              ),
                              Text(
                                getDuration(DateTime.parse(
                                    Colis.livreurColis[i].dateColis!.date!)),
                                style: myTextStyleBase.bodyText2,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: LinearPercentIndicator(
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  lineHeight: 5,
                                  percent: Colis.livreurColis[i].etat?.id_etat == 2? 0.2: 0.7,
                                  progressColor: PrimaryColorY,
                                  backgroundColor: Colors.grey[100],
                                  barRadius: Radius.circular(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      side: BorderSide(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                          LivreurMapTrack(Colis.livreurColis[i])),);
                                    },
                                    child: Text('Commancer',
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
                                    onPressed: ()  {
                                        showModalBottomSheet<void>(
                                          elevation: 10, context: context,
                                          backgroundColor: Colors.transparent,
                                          isScrollControlled: true,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: MediaQuery.of(context).size.height * 0.375,
                                              decoration: BoxDecoration(color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),)
                                              ),
                                              padding: EdgeInsets.only(top: 20, right: 15, left: 15),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: <Widget>[
                                                    Text('Mettre à jour',
                                                      style: myTextStyleBase.headline1,),

                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 30),
                                                      child: Column(
                                                        children: [

                                                          Visibility(
                                                            visible: Colis.livreurColis[i].etat?.id_etat == 2,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(bottom: 10),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('Commencer la livraison',
                                                                    style: myTextStyleBase.bodyText1,),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor: Colors.grey,
                                                                      foregroundColor: Colors.white,
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Text('Encous',
                                                                          style: TextStyle(fontSize: 12, color: Colors.white),),
                                                                        SizedBox(width: 10,),
                                                                        Image.asset('assets/Recuperation.png'),
                                                                      ],
                                                                    ),
                                                                    onPressed: () {

                                                                      Navigator.pop(context, []);

                                                                      showDialog(context: context,
                                                                          builder: (BuildContext context) {
                                                                            return LivreurPopUp('assets/Recuperation.png', 'Colis récupéré',
                                                                                Colis.livreurColis[i].id, 3, () => {});
                                                                          });
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(bottom: 10),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text('Terminer la course',
                                                                  style: myTextStyleBase.bodyText1,),
                                                                ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                    backgroundColor: Colors.green,
                                                                    foregroundColor: Colors.white,
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Text('Terminé',
                                                                        style: TextStyle(fontSize: 12, color: Colors.white),),
                                                                      SizedBox(width: 10,),
                                                                      Image.asset('assets/colisdone.png'),
                                                                    ],
                                                                  ),
                                                                  onPressed: () {

                                                                    Navigator.pop(context, []);

                                                                    showDialog(context: context,
                                                                        builder: (BuildContext context) {
                                                                          return LivreurPopUp('assets/colisdone.png', 'colis livré',
                                                                              Colis.livreurColis[i].id, 5, () => {});
                                                                        });
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('Annuler la course',
                                                                style: myTextStyleBase.bodyText1,),
                                                              ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor: Colors.red,
                                                                  foregroundColor: Colors.white,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Text('Annulé',
                                                                      style: TextStyle(fontSize: 12, color: Colors.white),),
                                                                    SizedBox(width: 10,),
                                                                    Image.asset('assets/annuleCourse.png'),
                                                                  ],
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(context, []);
                                                                  showDialog(context: context, builder: (BuildContext context) =>
                                                                      LivreurPopUp('assets/annuleCourse.png', 'Annuler la course',
                                                                          Colis.livreurColis[i].id, 4, () => {}));
                                                                },
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    child: Text('Mettre à jour',
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
                      ],
                    ),
                ),
              ),
                  );
              }
            })),
      ),
    );
  }
}
