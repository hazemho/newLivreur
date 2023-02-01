import 'package:flutter/material.dart';
import 'package:monlivreur/Providers/LivreurProviders/LivreurColisProvider.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../LivreurWidgets/AlertJobCard.dart';
import '../../../ConstantsWidgets/Constants.dart';

class AlertJob extends StatelessWidget {
  const AlertJob({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text('Alerte d\'emploi')
      ),
      body: FutureBuilder(
          future: Provider.of<LivreurColisProvider>(context, listen: false).fetchAndSetAlertColis(),
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
                  return Consumer<LivreurColisProvider>(
                      builder: (context, Colis, _) => RefreshIndicator(
                        color: AppThemeMode.primaryColor,
                        onRefresh: () async {
                          Provider.of<LivreurColisProvider>(context, listen: false).fetchAndSetAlertColis();
                        },
                        child: ListView.builder(
                          itemCount: Colis.livreurAlertColis.length,
                          itemBuilder: ((context, index) {
                            return Colis.livreurAlertColis == []
                                ? Center(child: Text('il n\'y a accune announce pour le moment ',
                                    style: myTextStyleBase.bodyText2,),)
                                : AlertJobCard(index: index,
                              colisData: Colis.livreurAlertColis.elementAt(index),);
                          }),
                        ),
                      ));
                }
              }
            }
          }),
    );
  }
}
