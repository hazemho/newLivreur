

class DriverDocumentData {

  final String documentTitle;
  final String? documentImagePath;
  final String? documentDescription;

  DriverDocumentData({required this.documentTitle, this.documentImagePath, this.documentDescription});

  static List<DriverDocumentData> get listDriverDocumentData{
    return [
      DriverDocumentData(documentTitle: 'Permis de conduite',),
      DriverDocumentData(documentTitle: 'Carte grise',),
      DriverDocumentData(documentTitle: 'Carte d\'identité',),
      DriverDocumentData(documentTitle: 'Plaque',),
      DriverDocumentData(documentTitle: 'Justificatif de domicile',),
    ];
  }

}