import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:monlivreur/config/utils/driver_document_data.dart';

class ItemDocument extends StatefulWidget {


  final DriverDocumentData? driverDocumentData;
  const ItemDocument({Key? key, this.driverDocumentData,}) : super(key: key);

  @override
  State<ItemDocument> createState() => _ItemDocumentState();
}

class _ItemDocumentState extends State<ItemDocument> {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeMode.containerFieldColor,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: NetworkImage(
                widget.driverDocumentData?.documentImagePath ?? ""
        ), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            decoration: BoxDecoration(color: AppThemeMode.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: AutoSizeText("${widget.driverDocumentData?.documentTitle}",
              style: TextStyle(fontWeight: FontWeight.bold, color:  AppThemeMode.textColorWhite,
                  fontSize: 14), textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }
}
