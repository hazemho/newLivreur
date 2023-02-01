import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/UserProvider/UserProvider.dart';
import 'package:monlivreur/Screens/Client/ClientWidgets/PickUpClientAdress.dart';
import 'package:monlivreur/Screens/Client/ClientWidgets/PickUpDestinationAdresse.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:phone_number_text_field/phone_number_text_field.dart';
import 'package:provider/provider.dart';

import '../../../Providers/LocationAdressProvider.dart';
import '../../../Providers/SommaireDetailsProvider.dart';


class SendParcelDeliveryRamassage extends StatefulWidget {

  final String parcelSize;
  final String parcelIcon;
  final bool selectedList;

  SendParcelDeliveryRamassage(this.parcelSize, this.parcelIcon, this.selectedList);

  @override
  State<SendParcelDeliveryRamassage> createState() => _SendParcelDeliveryRamassageState();
}

class _SendParcelDeliveryRamassageState extends State<SendParcelDeliveryRamassage> {

  String nom = '';
  String email = '';
  String phoneNumber = '';
  String adresseEnvoyeur = '';

  MapController controller = MapController();
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'TN',);

  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();

  void getPhoneNumber(String phoneNb) async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNb, 'US');
    setState(() {
      this._phoneNumber = number;
      phoneNumber = "${number.phoneNumber}";
    });
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // getPhoneNumber("+${Provider.of<UserProvider>(context, listen: false).userProfile?.phoneINFO}");
    //
    // nameTextEditingController.text = Provider.of<UserProvider>(context, listen: false)
    //     .userProfile?.username ?? "";
    //
    // emailTextEditingController.text = Provider.of<UserProvider>(context, listen: false)
    //     .userProfile?.email ?? "";
    //
    // Provider.of<SommaireDetailsProvider>(context, listen: false)
    //     .PickemailEnvoyeur(emailTextEditingController.text);
    //
    // Provider.of<SommaireDetailsProvider>(context, listen: false)
    //     .PicknomEnvoyeur(nameTextEditingController.text);
    //
    // Provider.of<SommaireDetailsProvider>(context, listen: false)
    //     .PickphoneEnvoyeur(phoneNumber);

    String locationAdressName = '';

    LatLng coordAddresse = LatLng(0, 0);

    setState(() {
      String newAddressName = Provider.of<LocationAdressProvider>(
              context, listen: false).LocationAdress;
      locationAdressName = newAddressName;

      LatLng newCoordAddresse = Provider.of<LocationAdressProvider>(
              context, listen: false).CoordSource;
      coordAddresse = newCoordAddresse;

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
                      'Informations sur l\'envoyeur',
                      style: myTextStyleBase.headline2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      child: TextFormField(

                        controller: nameTextEditingController,
                        onChanged: (value) {
                          setState(() {
                            nom = value;
                          });
                          Provider.of<SommaireDetailsProvider>(context, listen: false)
                              .PicknomEnvoyeur(nom);
                        },
                        decoration: InputDecoration(
                          hintStyle: myTextStyleBase.bodyText2,
                          fillColor: Colors.white,
                          filled: true,
                          label: Text(
                            'Nom',
                            style: myTextStyleBase.bodyText2,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Container(
                        height: 40,
                        child: TextFormField(
                          controller: emailTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                            Provider.of<SommaireDetailsProvider>(context,
                                    listen: false)
                                .PickemailEnvoyeur(email);
                          },
                          decoration: InputDecoration(
                            hintStyle: myTextStyleBase.bodyText2,
                            fillColor: Colors.white,
                            filled: true,
                            label: Text(
                              'Email',
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
                              listen: false).PickphoneEnvoyeur(phoneNumber);
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
                              PickUpClientAdress())).then((value) => setState(() {}));
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
                              label: locationAdressName == ''
                                  ? Text(
                                      'Choisir l\'adresse de ramassage ',
                                      style: myTextStyleBase.bodyText2,
                                    )
                                  : Text(
                                      locationAdressName,
                                      style: myTextStyleBase.bodyText2,
                                    ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: coordAddresse != LatLng(0, 0),
                      child: Container(
                        height: 200,
                        margin: EdgeInsets.only(top: 10),
                        child: FlutterMap(
                          mapController: controller,
                          options: MapOptions(
                              center: coordAddresse,
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
                                  point: coordAddresse,
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
