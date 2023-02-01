import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/LivreurProviders/LivreurColisProvider.dart';
import 'package:monlivreur/Screens/livreur/LivreurWidgets/LivreurRejeteeCourseCard.dart';
import 'package:monlivreur/Screens/livreur/LivreurWidgets/LivreurTermineeCourseCard.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../LivreurWidgets/LivreurEncoursCourseCard.dart';

class PublierLivreurAnnonce extends StatefulWidget {
  static String PublierLivreurAnnoce = '/PublierLivreurAnnonce';
  const PublierLivreurAnnonce({super.key});

  @override
  State<PublierLivreurAnnonce> createState() => _PublierAnnonceState();
}

class _PublierAnnonceState extends State<PublierLivreurAnnonce> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text('Mes Courses'),
          bottom: TabBar(
            onTap: (value) {
              switch(value) {
                case 0:
                  Provider.of<LivreurColisProvider>(context, listen: false).fetchAndSetLivreurColis(null);
                  break;
                case 1:
                  Provider.of<LivreurColisProvider>(context, listen: false).fetchAndSetLivreurColis(4);
                  break;
                case 2:
                  Provider.of<LivreurColisProvider>(context, listen: false).fetchAndSetLivreurColis(5);
                  break;
              }
            },
            tabs: [
              Tab(
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      child: Image.asset('assets/camion.png'),
                    ),
                    Text(
                      'En cours',
                      style: myTextStyleBase.bodyText2,
                    )
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      child: Image.asset('assets/close.png'),
                    ),
                    Text(
                      'Rejeté',
                      style: myTextStyleBase.bodyText2,
                    )
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      child: Image.asset('assets/donee.png'),
                    ),
                    Text(
                      'Livré',
                      style: myTextStyleBase.bodyText2,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
                child: Column(
              children: [

                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: const EdgeInsets.only(top: 25,),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: AppThemeMode.textColorBlack),
                    decoration: InputDecoration(
                        filled: true, fillColor: AppThemeMode.containerFieldColor,
                        contentPadding: const EdgeInsets.only(
                            left: 30, right: 15
                        ),
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none, hintText: "Rechercher un colis",
                        hintStyle: const TextStyle(color: AppThemeMode.textColorBlack),
                        focusedBorder: AppThemeMode.outlineInputBorderSearch,
                        enabledBorder: AppThemeMode.outlineInputBorderSearch,
                        errorBorder: AppThemeMode.outlineInputBorderSearch,
                        focusedErrorBorder: AppThemeMode.outlineInputBorderSearch,
                        errorStyle: AppThemeMode.errorStyle
                    ),
                    onChanged: (value) {
                      Provider.of<LivreurColisProvider>(context,
                          listen: false).fetchAndSetColis(null, value);
                    },
                  ),
                ),

                Expanded(
                  child: FutureBuilder(
                      future: Provider.of<LivreurColisProvider>(context, listen: false).fetchAndSetLivreurColis(null),
                      builder: (ctx, dataSnapshot) {
                        print(dataSnapshot.connectionState);
                        if (dataSnapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(
                            color: PrimaryColorY,));
                        } else {
                          if (dataSnapshot.connectionState == ConnectionState.none) {
                            return Center(child: Text('il n\'y a accune announce pour le moment '),);
                          } else {
                            if (dataSnapshot.error != null) {
                              print(dataSnapshot.error);
                              // ...()
                              // Do error handling stuff
                              return Center(
                                child: Text('une erreur est survenue'),
                              );
                            } else {
                              return LivreurEncoursCourseCard();
                            }
                          }
                        }
                      }),
                ),
              ],
            )),
            Container(
                child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: const EdgeInsets.only(top: 25,),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: AppThemeMode.textColorBlack),
                    decoration: InputDecoration(
                        filled: true, fillColor: AppThemeMode.containerFieldColor,
                        contentPadding: const EdgeInsets.only(
                            left: 30, right: 15
                        ),
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none, hintText: "Rechercher un colis",
                        hintStyle: const TextStyle(color: AppThemeMode.textColorBlack),
                        focusedBorder: AppThemeMode.outlineInputBorderSearch,
                        enabledBorder: AppThemeMode.outlineInputBorderSearch,
                        errorBorder: AppThemeMode.outlineInputBorderSearch,
                        focusedErrorBorder: AppThemeMode.outlineInputBorderSearch,
                        errorStyle: AppThemeMode.errorStyle
                    ),
                    onChanged: (value) {
                      Provider.of<LivreurColisProvider>(context,
                          listen: false).fetchAndSetColis(4, value);
                    },
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                      future: Provider.of<LivreurColisProvider>(context, listen: false).fetchAndSetLivreurColis(4),
                      builder: (ctx, dataSnapshot) {
                        print(dataSnapshot.connectionState);
                        if (dataSnapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(
                            color: PrimaryColorY,));
                        } else {
                          if (dataSnapshot.connectionState == ConnectionState.none) {
                            return Center(child: Text('il n\'y a accune announce pour le moment '),);
                          } else {
                            if (dataSnapshot.error != null) {
                              print(dataSnapshot.error);
                              // ...()
                              // Do error handling stuff
                              return Center(
                                child: Text('une erreur est survenue'),
                              );
                            } else {
                              return LivreurRejeteeCourseCard();
                            }
                          }
                        }
                      }),
                ),
              ],
            )),
            Container(
                child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: const EdgeInsets.only(top: 25,),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: AppThemeMode.textColorBlack),
                    decoration: InputDecoration(
                        filled: true, fillColor: AppThemeMode.containerFieldColor,
                        contentPadding: const EdgeInsets.only(
                            left: 30, right: 15
                        ),
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none, hintText: "Rechercher un colis",
                        hintStyle: const TextStyle(color: AppThemeMode.textColorBlack),
                        focusedBorder: AppThemeMode.outlineInputBorderSearch,
                        enabledBorder: AppThemeMode.outlineInputBorderSearch,
                        errorBorder: AppThemeMode.outlineInputBorderSearch,
                        focusedErrorBorder: AppThemeMode.outlineInputBorderSearch,
                        errorStyle: AppThemeMode.errorStyle
                    ),
                    onChanged: (value) {
                      Provider.of<LivreurColisProvider>(context,
                          listen: false).fetchAndSetColis(5, value);
                    },
                  ),
                ),

                Expanded(
                  child: FutureBuilder(
                      future: Provider.of<LivreurColisProvider>(context, listen: false).fetchAndSetLivreurColis(5),
                      builder: (ctx, dataSnapshot) {
                        print(dataSnapshot.connectionState);
                        if (dataSnapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(
                            color: PrimaryColorY,));
                        } else {
                          if (dataSnapshot.connectionState == ConnectionState.none) {
                            return Center(child: Text('il n\'y a accune announce pour le moment '),);
                          } else {
                            if (dataSnapshot.error != null) {
                              print(dataSnapshot.error);
                              // ...()
                              // Do error handling stuff
                              return Center(
                                child: Text('une erreur est survenue'),
                              );
                            } else {
                              return LivreurTermineeCourseCard();
                            }
                          }
                        }
                      }),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}



// FutureBuilder(
//           future: null,
//           builder: (ctx, dataSnapshot) {
//             print(dataSnapshot.connectionState);
//             if (dataSnapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else {
//               if (dataSnapshot.connectionState == ConnectionState.none) {
//                 return Center(child: LivreurCourseCard()
//                     //  Text('il n\'y a accune announce pour le moment '),
//                     );
//               } else {
//                 if (dataSnapshot.error != null) {
//                   print(dataSnapshot.error);
//                   // ...()
//                   // Do error handling stuff
//                   return Center(
//                     child: Text('An error occurred!'),
//                   );
//                 } else {
//                   return LivreurCourseCard();
//                 }
//               }
//             }
//           }),