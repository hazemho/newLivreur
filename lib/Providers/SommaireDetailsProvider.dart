import 'package:flutter/material.dart';

class SommaireDetailsProvider with ChangeNotifier {
  String _AlimentaireColis = '';
  String get getAlimentaireColis {
    return _AlimentaireColis;
  }

  String _ElectronicColis = '';
  String get getElectronicColis {
    return _ElectronicColis;
  }

  String _AutreColis = '';
  String get getAutreColis {
    return _AutreColis;
  }

  String _DescriptionColis = '';
  String get getDescriptionColis {
    return _DescriptionColis;
  }

  PickDescriptionColis(newlocation) {
    _DescriptionColis = newlocation;
    notifyListeners();

    return _DescriptionColis;
  }

  String _TimeColis = '';
  String get getTimeColis {
    return _TimeColis;
  }

  PickTimeColis(newlocation) {
    _TimeColis = newlocation;
    notifyListeners();

    return _TimeColis;
  }

  String _DateColis = '';
  String get getDateColis {
    return _DateColis;
  }

  PickDateColis(newlocation) {
    _DateColis = newlocation;
    notifyListeners();

    return _DateColis;
  }

  String _phoneEnvoyeur = '';
  String get getphoneEnvoyeur {
    return _phoneEnvoyeur;
  }

  PickphoneEnvoyeur(newlocation) {
    _phoneEnvoyeur = newlocation;
    notifyListeners();

    return _phoneEnvoyeur;
  }

  String _emailEnvoyeur = '';
  String get getemailEnvoyeur {
    return _emailEnvoyeur;
  }

  PickemailEnvoyeur(newlocation) {
    _emailEnvoyeur = newlocation;
    notifyListeners();

    return _emailEnvoyeur;
  }

  String _nomEnvoyeur = '';
  String get getnomEnvoyeur {
    return _nomEnvoyeur;
  }

  PicknomEnvoyeur(newlocation) {
    _nomEnvoyeur = newlocation;
    notifyListeners();

    return _nomEnvoyeur;
  }

  String _phoneLivreur = '';
  String get getphoneLivreur {
    return _phoneLivreur;
  }

  PickphoneLivreur(newlocation) {
    _phoneLivreur = newlocation;
    notifyListeners();

    return _phoneLivreur;
  }

  String _adresseLivreur = '';
  String get getadresseLivreur {
    return _adresseLivreur;
  }

  PickadresseLivreur(newlocation) {
    _adresseLivreur = newlocation;
    notifyListeners();

    return _adresseLivreur;
  }

  String _EmailLivreur = '';
  String get getEmailLivreur {
    return _EmailLivreur;
  }

  PickEmailLivreur(newlocation) {
    _EmailLivreur = newlocation;
    notifyListeners();

    return _EmailLivreur;
  }

  String _nomLivreur = '';
  String get getnomLivreur {
    return _nomLivreur;
  }

  PicknomLivreur(newlocation) {
    _nomLivreur = newlocation;
    notifyListeners();

    return _nomLivreur;
  }

  String _TailleColis = '';
  String get getTailleColis {
    return _TailleColis;
  }

  PickTailleColis(newlocation) {
    _TailleColis = newlocation;
    notifyListeners();
    return _TailleColis;
  }

  int? _TailleColisValue;
  int? get getTailleColisValue {
    return _TailleColisValue;
  }

  PickTailleColisValue(newlocation) {
    _TailleColisValue = newlocation;
    notifyListeners();
    return _TailleColisValue;
  }

  PickAutreColis(newlocation) {
    _AutreColis = newlocation;
    notifyListeners();

    return _AutreColis;
  }

  String _FlameColis = '';
  String get getFlameColis {
    return _FlameColis;
  }

  PickFlameColis(newlocation) {
    _FlameColis = newlocation;
    notifyListeners();

    return _FlameColis;
  }

  PickElectronicColis(newlocation) {
    _ElectronicColis = newlocation;
    notifyListeners();

    return _ElectronicColis;
  }

  PickAlimentaireColis(newlocation) {
    _AlimentaireColis = newlocation;
    notifyListeners();

    return _AlimentaireColis;
  }

  resetProviderData(){
    _AlimentaireColis = "";
    _ElectronicColis = "";
    _AutreColis = "";
    _DescriptionColis = "";
    _TimeColis = "";
    _DateColis = "";
    _phoneEnvoyeur = "";
    _emailEnvoyeur = "";
    _nomEnvoyeur = "";
    _phoneLivreur = "";
    _adresseLivreur = "";
    _EmailLivreur = "";
    _nomLivreur = "";
    _TailleColis = "";
    _FlameColis = "";
    notifyListeners();
  }

}
