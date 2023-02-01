import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ClientColisModel with ChangeNotifier {
  String idClient;
  List natureColis;
  List tailleColis;
  List adresseRamassage;
  List adresseLivraison;
  List programmeLivraison;
  String description;

  ClientColisModel(
    this.idClient,
    this.natureColis,
    this.tailleColis,
    this.adresseRamassage,
    this.adresseLivraison,
    this.programmeLivraison,
    this.description,
  );
}
