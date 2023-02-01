import 'package:flutter/material.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';

// ignore: must_be_immutable
class SendParcelCard extends StatelessWidget {
  SendParcelCard(this.parcelSize, this.parcelDetails, this.parcelStorage,
      this.parcelIcon, this.selectedList);
  String parcelSize;
  String parcelDetails;
  String parcelStorage;
  String parcelIcon;
  bool selectedList;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Image.asset(parcelIcon),
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
                  parcelSize,
                  style: myTextStyleBase.headline3,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  parcelDetails,
                  style: myTextStyleBase.headline2,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  parcelStorage,
                  style: myTextStyleBase.bodyText2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
