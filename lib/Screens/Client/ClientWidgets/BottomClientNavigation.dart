import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/ClientProviders/ClientColisProvider.dart';
import 'package:monlivreur/Providers/SignUp&LogIn/LoginProvider.dart';
import 'package:monlivreur/Providers/SommaireDetailsProvider.dart';
import 'package:monlivreur/Providers/UserProvider/UserProvider.dart';
import 'package:monlivreur/Screens/Client/ClientScreens/MyParcel.dart';
import 'package:monlivreur/Screens/Client/ClientScreens/SendParcel.dart';
import 'package:monlivreur/Screens/profile/model/UserProfile.dart';
import 'package:monlivreur/Screens/profile/profile_screen.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';

class BottomClientNavigation extends StatefulWidget {
  static String bottomClientNavigation = '/bottomClientNavigation';
  BottomClientNavigation({super.key});

  @override
  State<BottomClientNavigation> createState() => _BottomClientNavigationState();
}

class _BottomClientNavigationState extends State<BottomClientNavigation> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    MyParcel(),
    SendParcel(),
    ProfileScreen(userType: 2,),
  ];

  void _onItemTap(int index, BuildContext context) {
    setState(() => _selectedIndex = index);
    index != 1? Provider.of<SommaireDetailsProvider>(
        context, listen: false).resetProviderData(): null;
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        Provider.of<ClientColisProvider>(context, listen: false).fetchAndSetColisNotif();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).getUserProfile();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions[_selectedIndex],
        ),
        bottomNavigationBar: Consumer<ClientColisProvider>(
          builder: (BuildContext context, ClientColisProvider colisProvider, Widget? widget) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 10,
              backgroundColor: PrimaryColorY,
              unselectedItemColor: MonLTextGrey,
              selectedItemColor: Colors.black,
              items: [
                BottomNavigationBarItem(
                  icon: new Stack(children: <Widget>[
                    ImageIcon(
                      AssetImage('assets/parcels.png'),
                    ),
                    Visibility(visible:
                    colisProvider.notifColis != null
                        && colisProvider.notifColis != 0,
                      child: new Positioned(
                          top: -5,
                          right: 0,
                          child: new Stack(
                            children: <Widget>[
                             Container(
                               padding: EdgeInsets.all(4),
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: AppThemeMode.textColorError
                               ),
                               child: Text("${colisProvider.notifColis}", style: TextStyle(fontSize: 10,
                                     color: AppThemeMode.textColorWhite),),
                             )
                            ],
                          )),
                    )
                  ]),
                  label: 'Mes Colis',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/Sendparcel.png'),
                  ),
                  label: 'Envoyer un colis',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: (value) {
                _onItemTap(value, context);

                Provider.of<ClientColisProvider>(context, listen: false).fetchAndSetColisNotif();

                setState(() {

                });
              },
              selectedFontSize: 12,
              unselectedFontSize: 12,
            );
          }
        ),
      ),
    );
  }
}
