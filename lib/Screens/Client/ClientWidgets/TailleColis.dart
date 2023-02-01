import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/SommaireDetailsProvider.dart';
import 'SendParcelCard.dart';

class TailleColis extends StatefulWidget {
  const TailleColis({super.key});

  @override
  State<TailleColis> createState() => _TailleColisState();
}

class _TailleColisState extends State<TailleColis> {

  bool selectedList1 = false;
  bool selectedList2 = false;
  bool selectedList3 = false;
  bool selectedList4 = false;
  bool selectedList5 = false;
  bool selectedList6 = false;
  bool selectedList7 = false;
  String tailleText = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              selectedList1 = true;
              selectedList2 = false;
              selectedList3 = false;
              selectedList4 = false;
              selectedList5 = false;
              tailleText = 'Petit: Max. 25 kg, 8 x 38 x 64 cm';
            });
            Provider.of<SommaireDetailsProvider>(context, listen: false)
                .PickTailleColis(tailleText);
            Provider.of<SommaireDetailsProvider>(context, listen: false)
                .PickTailleColisValue(1);
          },
          child: Container(
            height: 120,
            child: Card(
              shape: selectedList1
                  ? RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green))
                  : null,
              elevation: selectedList1 ? 5 : null,
              child: SendParcelCard(
                  'Petit',
                  'Max. 25 kg, 8 x 38 x 64 cm',
                  'Se tient dans une enveloppe',
                  'assets/Small.png',
                  selectedList1),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selectedList1 = false;
              selectedList2 = true;
              selectedList3 = false;
              selectedList4 = false;
              selectedList5 = false;
              tailleText = 'Moyen: Max. 25 kg, 19 x 38 x 64 cm';
            });
            Provider.of<SommaireDetailsProvider>(context, listen: false)
                .PickTailleColis(tailleText);
            Provider.of<SommaireDetailsProvider>(context, listen: false)
                .PickTailleColisValue(2);
          },
          child: Container(
            height: 120,
            child: Card(
              shape: selectedList2
                  ? RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green))
                  : null,
              elevation: selectedList2 ? 5 : null,
              child: SendParcelCard('Moyen', 'Max. 25 kg, 19 x 38 x 64 cm',
                  'Se tient dans une boîte ', 'assets/Medium.png', false),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selectedList1 = false;
              selectedList2 = false;
              selectedList3 = true;
              selectedList4 = false;
              selectedList5 = false;
              tailleText = 'Grand: Max. 25 kg, 41 x 38 x 64 cm';
            });
            Provider.of<SommaireDetailsProvider>(context, listen: false)
                .PickTailleColis(tailleText);
            Provider.of<SommaireDetailsProvider>(context, listen: false)
                .PickTailleColisValue(3);
          },
          child: Container(
            height: 120,
            child: Card(
              shape: selectedList3
                  ? RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green))
                  : null,
              elevation: selectedList3 ? 5 : null,
              child: SendParcelCard(
                  'Grand',
                  'Max. 25 kg, 41 x 38 x 64 cm',
                  'Se tient dans une boîte en carton',
                  'assets/Large.png',
                  false),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selectedList1 = false;
              selectedList2 = false;
              selectedList3 = false;
              selectedList4 = true;
              selectedList5 = false;
              tailleText = 'Personnalisé: Max. 30kg or 300cm';
            });
            Provider.of<SommaireDetailsProvider>(context, listen: false)
                .PickTailleColis(tailleText);
            Provider.of<SommaireDetailsProvider>(context, listen: false)
                .PickTailleColisValue(4);
          },
          child: Container(
            height: 120,
            child: Card(
              shape: selectedList4
                  ? RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green))
                  : null,
              elevation: selectedList4 ? 5 : null,
              child: SendParcelCard('Personnalisé', 'Max: 30kg or 300cm',
                  'S\'adapte sur un patin', 'assets/Custom.png', false),
            ),
          ),
        ),
      ],
    );
  }
}
