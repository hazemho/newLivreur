import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/SommaireDetailsProvider.dart';
import 'package:monlivreur/Providers/UserProvider/UserProvider.dart';
import 'package:monlivreur/Screens/Client/ClientWidgets/PickUpClientAdress.dart';
import 'package:monlivreur/Screens/Client/ClientWidgets/PickUpDestinationAdresse.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:phone_number_text_field/phone_number_text_field.dart';
import 'package:provider/provider.dart';

import '../../../Providers/LocationAdressProvider.dart';

class SendParcelDeliveryDestination extends StatefulWidget {

  final String parcelSize;
  final String parcelIcon;
  final bool selectedList;

  SendParcelDeliveryDestination(this.parcelSize, this.parcelIcon, this.selectedList);


  @override
  State<SendParcelDeliveryDestination> createState() => _SendParcelDeliveryDestinationState();
}

class _SendParcelDeliveryDestinationState extends State<SendParcelDeliveryDestination> {

  MapController controller = MapController();


  String nom = '';
  String email = '';
  String phoneNumber = '';
  String adresseLivreur = '';

  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'TN',);


  @override
  Widget build(BuildContext context) {

    String PickUpLocationAdress = '';
    LatLng coordDestination =  LatLng(0, 0);

    setState(() {
      String newPickUploc = Provider.of<LocationAdressProvider>(
              context, listen: false).LocationDestinationAdress;
      PickUpLocationAdress = newPickUploc;

      LatLng newCoordDestination = Provider.of<LocationAdressProvider>(
              context, listen: false).CoordDestination;
      coordDestination = newCoordDestination;
    });

    return Column(
      children: [
        Container(
          height: widget.selectedList ? 110 : 90,
          child: Card(
            shape: widget.selectedList
                ? RoundedRectangleBorder(side: BorderSide(color: Colors.green))
                : null,
            elevation: widget.selectedList ? 5 : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Image.asset(widget.parcelIcon),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.parcelSize,
                        style: myTextStyleBase.headline3,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!widget.selectedList)
          Container()
        else
          Container(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Information sur le destinataire',
                      style: myTextStyleBase.headline2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() => nom = value);
                          Provider.of<SommaireDetailsProvider>(context, listen: false).PicknomLivreur(nom);
                        },
                        decoration: InputDecoration(
                          hintStyle: myTextStyleBase.bodyText2,
                          fillColor: Colors.white, filled: true,
                          label: Text('Nom', style: myTextStyleBase.bodyText2,),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Container(
                        height: 40,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                            Provider.of<SommaireDetailsProvider>(context,
                                    listen: false)
                                .PickEmailLivreur(email);
                          },
                          decoration: InputDecoration(
                            hintStyle: myTextStyleBase.bodyText2,
                            fillColor: Colors.white,
                            filled: true,
                            label: Text('Email',
                              style: myTextStyleBase.bodyText2,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      height: 50,
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          setState(() => phoneNumber = "${number.phoneNumber}");
                          Provider.of<SommaireDetailsProvider>(context,
                              listen: false).PickphoneLivreur(phoneNumber);
                        },
                        selectorConfig: const SelectorConfig(
                          setSelectorButtonAsPrefixIcon: true, leadingPadding: 10,
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        initialValue: _phoneNumber,
                        ignoreBlank: true, autoValidateMode: AutovalidateMode.always,
                        selectorTextStyle: const TextStyle(color: Colors.black,),
                        textStyle: const TextStyle(color: AppThemeMode.textColorBlack, wordSpacing: 5),
                        inputDecoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          fillColor: Colors.white, filled: true,
                          hintText: '00 000 000',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              PickUpDestinationAdresse())).then((value) {
                            setState(() {});
                          });
                        },
                        child: Container(
                          height: 40,
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              hintStyle: myTextStyleBase.bodyText2,
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: const EdgeInsets.all(8.0),
                              suffixIcon:
                                  Image.asset('assets/locationTarget.png'),
                              label: PickUpLocationAdress == ''
                                  ? Text(
                                      'Choisir l\'adresse de livraison',
                                      style: myTextStyleBase.bodyText2,
                                    )
                                  : Text(
                                      PickUpLocationAdress,
                                      style: myTextStyleBase.bodyText2,
                                    ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Visibility(
                      visible: coordDestination != LatLng(0, 0),
                      child: Container(
                        height: 200,
                        margin: EdgeInsets.only(top: 10),
                        child: FlutterMap(
                          mapController: controller,
                          options: MapOptions(
                            center: coordDestination,
                              zoom: 16
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: 'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  height: 100,
                                  width: 100,
                                  point: coordDestination,
                                  builder: (context) {
                                    return Container(
                                      child: Image.asset('assets/p1.png'),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
