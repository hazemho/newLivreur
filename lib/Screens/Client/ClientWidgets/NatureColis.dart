import 'package:flutter/material.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:provider/provider.dart';

import '../../../Providers/SommaireDetailsProvider.dart';

class NatureColis extends StatefulWidget {
  const NatureColis({super.key});

  @override
  State<NatureColis> createState() => _NatureColisState();
}

class _NatureColisState extends State<NatureColis> {
  bool? Alimentaire = false;
  bool? Electronique = false;
  bool? MarchandisesInflammables = false;
  bool? Autres = false;

  String AlimentaireText = '';
  String ElectroniqueText = '';
  String MarchandisesInflammablesText = '';
  String AutresText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          CheckboxListTile(
            activeColor: PrimaryColorY,
            title: Text("Alimentaire"),
            value: Alimentaire,
            onChanged: (newValue) {
              setState(() {
                Alimentaire = newValue;
                if (Alimentaire!) {
                  AlimentaireText = 'Alimentaire';
                } else {
                  AlimentaireText = '';
                }
              });
              Provider.of<SommaireDetailsProvider>(context, listen: false)
                  .PickAlimentaireColis(AlimentaireText);
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            activeColor: PrimaryColorY,
            title: Text("Electronique"),
            value: Electronique,
            onChanged: (newValue) {
              setState(() {
                Electronique = newValue;
                if (Electronique!) {
                  ElectroniqueText = 'Electronique';
                } else {
                  ElectroniqueText = '';
                }
              });
              Provider.of<SommaireDetailsProvider>(context, listen: false)
                  .PickElectronicColis(ElectroniqueText);
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            activeColor: PrimaryColorY,
            title: Text("Marchandises inflammables"),
            value: MarchandisesInflammables,
            onChanged: (newValue) {
              setState(() {
                MarchandisesInflammables = newValue;
                if (MarchandisesInflammables!) {
                  MarchandisesInflammablesText = 'Marchandises inflammables';
                } else {
                  MarchandisesInflammablesText = '';
                }
              });
              Provider.of<SommaireDetailsProvider>(context, listen: false)
                  .PickFlameColis(MarchandisesInflammablesText);
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            activeColor: PrimaryColorY,
            title: Text("Autres"),
            value: Autres,
            onChanged: (newValue) {
              setState(() {
                Autres = newValue;

                if (Autres!) {
                  AutresText = 'Autres';
                } else {
                  AutresText = '';
                }
              });
              Provider.of<SommaireDetailsProvider>(context, listen: false)
                  .PickAutreColis(AutresText);
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
        ],
      ),
    );
  }
}
