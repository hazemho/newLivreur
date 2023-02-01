import 'package:flutter/material.dart';

class LivreurModel with ChangeNotifier  {
  String idLivreur;
  String nomLivreur;
  String prenomLivreur;
  String emailLivreur;
  String passwordLivreur;
  String permisLivreur;
  String carteGriseLivreur;
  String pieceIdentiteLivreur;
  String plaqueImmatriculationsLivreur;
  String justificationDomicileLivreur;
  bool moto = false;
  bool voiture = false;
  bool camion = false;

  LivreurModel(
      this.idLivreur,
      this.nomLivreur,
      this.prenomLivreur,
      this.emailLivreur,
      this.passwordLivreur,
      this.permisLivreur,
      this.carteGriseLivreur,
      this.pieceIdentiteLivreur,
      this.plaqueImmatriculationsLivreur,
      this.justificationDomicileLivreur);
}
