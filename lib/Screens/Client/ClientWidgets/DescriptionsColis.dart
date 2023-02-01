import 'package:flutter/material.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/SommaireDetailsProvider.dart';
import 'package:provider/provider.dart';

class DescriptionsColis extends StatefulWidget {
  const DescriptionsColis({super.key});

  @override
  State<DescriptionsColis> createState() => _DescriptionsColisState();
}

class _DescriptionsColisState extends State<DescriptionsColis> {
  @override
  Widget build(BuildContext context) {
    String DescriptionsColis = '';

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          minLines: 3,
          maxLines: 10,
          onChanged: (value) {
            setState(() {
              DescriptionsColis = value;
            });
            Provider.of<SommaireDetailsProvider>(context, listen: false)
                .PickDescriptionColis(DescriptionsColis);
          },
          decoration: InputDecoration(
            hintStyle: myTextStyleBase.bodyText1,
            fillColor: Colors.white,
            filled: true,
            label: Text(
              'Veuillez décrire le contenu de votre colis',
              style: myTextStyleBase.bodyText1,
            ),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
