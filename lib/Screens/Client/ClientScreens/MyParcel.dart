import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/ClientProviders/ClientColisProvider.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../ClientWidgets/ClientCardParcel.dart';
import '../ClientWidgets/ClientRejeteeCourseCard.dart';
import '../ClientWidgets/ClientTermineeCourseCard.dart';

class MyParcel extends StatefulWidget {
  const MyParcel({super.key});
  static String myParcel = '/MyParcel';
  @override
  State<MyParcel> createState() => _MyParcelState();
}

class _MyParcelState extends State<MyParcel> {

  TextEditingController searchController = TextEditingController();


  // @override
  // void initState() {
  //   Provider.of<ClientColisProvider>(context, listen: false).fetchAndSetColisNotif();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text('Mes Colis'),
          bottom: TabBar(
            onTap: (value) {
              switch(value) {
                case 0:
                  Provider.of<ClientColisProvider>(context, listen: false).fetchAndSetClientColis(null);
                  break;
                case 1:
                  Provider.of<ClientColisProvider>(context, listen: false).fetchAndSetClientColis(4);
                  break;
                case 2:
                  Provider.of<ClientColisProvider>(context, listen: false).fetchAndSetClientColis(5);
                  break;
              }
              Provider.of<ClientColisProvider>(context, listen: false).fetchAndSetColisNotif();
            },
            tabs: [
              Tab(
                child: Stack(
                  children: [
                    Column(
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
                    Consumer<ClientColisProvider>(
                        builder: (BuildContext context, ClientColisProvider colisProvider, Widget? widget) {
                        return Visibility(visible:
                        colisProvider.notifColisEncours != null
                            && colisProvider.notifColisEncours != 0,
                          child: new Positioned(
                              top: -3,
                              right: 0,
                              child: new Stack(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppThemeMode.textColorError
                                    ),
                                    child: Text("${colisProvider.notifColisEncours}", style: TextStyle(fontSize: 10,
                                        color: AppThemeMode.textColorWhite),),
                                  )
                                ],
                              )),
                        );
                      }
                    )
                  ],
                ),
              ),
              Tab(
                child: Stack(
                  children: [
                    Column(
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
                    Consumer<ClientColisProvider>(
                        builder: (BuildContext context, ClientColisProvider colisProvider, Widget? widget) {
                          return Visibility(visible:
                          colisProvider.notifColisRejete != null
                              && colisProvider.notifColisRejete != 0,
                            child: new Positioned(
                                top: -3,
                                right: 0,
                                child: new Stack(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppThemeMode.textColorError
                                      ),
                                      child: Text("${colisProvider.notifColisRejete}", style: TextStyle(fontSize: 10,
                                          color: AppThemeMode.textColorWhite),),
                                    )
                                  ],
                                )),
                          );
                        }
                    )
                  ],
                ),
              ),
              Tab(
                child: Stack(
                  children: [
                    Column(
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
                    Consumer<ClientColisProvider>(
                        builder: (BuildContext context, ClientColisProvider colisProvider, Widget? widget) {
                          return Visibility(visible:
                          colisProvider.notifColisTermine != null
                              && colisProvider.notifColisTermine != 0,
                            child: new Positioned(
                                top: -3,
                                right: 0,
                                child: new Stack(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppThemeMode.textColorError
                                      ),
                                      child: Text("${colisProvider.notifColisTermine}", style: TextStyle(fontSize: 10,
                                          color: AppThemeMode.textColorWhite),),
                                    )
                                  ],
                                )),
                          );
                        }
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
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
                      Provider.of<ClientColisProvider>(context,
                          listen: false).fetchAndSetColis(null, value);
                    },
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                      future: Provider.of<ClientColisProvider>(context, listen: false).fetchAndSetClientColis(null),
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
                              return Center(
                                child: Text('une erreur est survenue'),
                              );
                            } else {
                              return ClientCardParcel();
                            }
                          }
                        }
                      }),
                ),
              ],
            ),
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
                        controller: searchController,
                        onChanged: (value) {
                          Provider.of<ClientColisProvider>(context,
                              listen: false).fetchAndSetColis(4, value);
                        },
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                          future: Provider.of<ClientColisProvider>(context, listen: false).fetchAndSetClientColis(4),
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
                                  return ClientRejeteeCourseCard();
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
                        controller: searchController,
                        onChanged: (value) {
                          Provider.of<ClientColisProvider>(context,
                              listen: false).fetchAndSetColis(5, value);
                        },
                      ),
                    ),

                    Expanded(
                      child: FutureBuilder(
                          future: Provider.of<ClientColisProvider>(context, listen: false).fetchAndSetClientColis(5),
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
                                  return ClientTermineeCourseCard();
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












// Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             pinned: true,
//             floating: true,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
//                 child: CupertinoSearchTextField(
//                   padding: const EdgeInsets.all(8),
//                   borderRadius: BorderRadius.circular(20),
//                   controller: searchController,
//                   onChanged: (value) {},
//                   onSubmitted: (value) {},
//                   autocorrect: true,
//                   placeholder: 'Rechercher un Colis',
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 30, bottom: 5, left: 30),
//               child: Text(
//                 'Mes Colis',
//                 style: myTextStyleBase.headline4,
//               ),
    //         ),
    //       ),
    //       SliverList(
    //         delegate: SliverChildBuilderDelegate(
    //           (BuildContext context, int index) {
    //             return ClientCardParcel();
    //           },
    //           childCount: 20,
    //         ),
    //       ),
    //     ],
    //   ),
    // );