import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/Screens/profile/widget/item_document.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:monlivreur/config/utils/driver_document_data.dart';

class ShowDocumentScreen extends StatefulWidget {
  final String? filePermis;
  final String? fileIdentite;
  final String? fileCarteGrise;
  final String? filePlaque;
  final String? fileJustification;

  const ShowDocumentScreen({
    Key? key,
    this.filePermis,
    this.fileIdentite,
    this.fileCarteGrise,
    this.filePlaque,
    this.fileJustification,
  }) : super(key: key);

  @override
  ShowDocumentScreenState createState() => ShowDocumentScreenState();
}

class ShowDocumentScreenState extends State<ShowDocumentScreen> {
  List<DriverDocumentData> listDriverDocumentData = List.empty(growable: true);

  // DriverDocumentData(documentTitle: 'Permis de conduite', documentImagePath: ''),
  // DriverDocumentData(documentTitle: 'Carte grise', documentImagePath: ''),
  // DriverDocumentData(documentTitle: 'Carte d\'identité', documentImagePath: ''),
  // DriverDocumentData(documentTitle: 'Plaque', documentImagePath: ''),
  // DriverDocumentData(documentTitle: 'Justificatif de domicile', documentImagePath: ''),

  @override
  void initState() {
    if (widget.filePermis != null && widget.filePermis != "") {
      listDriverDocumentData.add(DriverDocumentData(
          documentTitle: 'Permis de conduite',
          documentImagePath: widget.filePermis));
    }
    if (widget.fileCarteGrise != null && widget.fileCarteGrise != "") {
      listDriverDocumentData.add(DriverDocumentData(
          documentTitle: 'Carte grise',
          documentImagePath: widget.fileCarteGrise));
    }
    if (widget.fileIdentite != null && widget.fileIdentite != "") {
      listDriverDocumentData.add(DriverDocumentData(
          documentTitle: 'Carte d\'identité',
          documentImagePath: widget.fileIdentite));
    }
    if (widget.filePlaque != null && widget.filePlaque != "") {
      listDriverDocumentData.add(DriverDocumentData(
          documentTitle: 'Plaque', documentImagePath: widget.filePlaque));
    }
    if (widget.fileJustification != null && widget.fileJustification != "") {
      listDriverDocumentData.add(DriverDocumentData(
          documentTitle: 'Justificatif de domicile',
          documentImagePath: widget.fileJustification));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
          textScaleFactor: 0.975,
          devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppThemeMode.containerBackground,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(
              color: AppThemeMode.textColorBlack,
            ),
            backgroundColor: AppThemeMode.primaryColor,
          ),
          body: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                    top: 30,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: const AutoSizeText(
                          "Document",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppThemeMode.textColorBlack,
                              fontSize: 24),
                        ),
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: listDriverDocumentData.length,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.56,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            mainAxisExtent:
                                MediaQuery.of(context).size.height * 0.2,
                          ),
                          itemBuilder: (BuildContext context, int index) =>
                              ItemDocument(
                                driverDocumentData:
                                    listDriverDocumentData.elementAt(index),
                              ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
