import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:monlivreur/Screens/Client/model-notif/NotificationNbResponse.dart';
import 'package:monlivreur/Screens/Client/model/AddColisResponse.dart';
import 'package:monlivreur/Screens/Client/model/Adresse.dart';
import 'package:monlivreur/Screens/Client/model/ColisData.dart';
import 'package:monlivreur/Screens/Client/model/ColisResponse.dart';
import 'package:monlivreur/Screens/Client/model/DetailsColisResponse.dart';
import 'package:monlivreur/Screens/Client/model/InfoPerson.dart';

class ClientColisProvider with ChangeNotifier {


  final String authToken;
  final String userId;

  ClientColisProvider(this.authToken, this.userId,);

  List<ColisData>? _clientColis;
  List<ColisData> get clientColis {
    return [...?_clientColis];
  }

  List<ColisData>? _clientColisRejete;

  List<ColisData> get clientColisRejete {
    return [...?_clientColisRejete];
  }

  List<ColisData>? _clientColisTermine;

  List<ColisData> get clientColisTermine {
    return [...?_clientColisTermine];
  }

  ColisData? _clientDetailsColis;

  ColisData? get clientDetailsColis {
    return _clientDetailsColis;
  }

  Future<void> fetchAndSetClientColis(int? colisEtat) async {
    try {
      var response = await Dio().post(
        'https://dev.wwt-technology.com/api/colis/getrecapallcolis',
          options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $authToken',
              }
          ),
        data: {
          'iduser': userId,
          'selectedEtat': colisEtat,
        }
      );
      debugPrint("Response Message: ${response.data}");
      if (response.statusCode == 200) {
        final responseData = ColisResponse.fromJson(response.data);
        if(colisEtat == 4){
          _clientColisRejete = (responseData.listColis ?? []);
          _clientColisRejete?.sort((first, second) => "${second.dateColis?.date}"
              .compareTo("${first.dateColis?.date}"));
        } else if(colisEtat == 5){
          _clientColisTermine = (responseData.listColis ?? []);
          _clientColisRejete?.sort((first, second) => "${second.dateColis?.date}"
              .compareTo("${first.dateColis?.date}"));
        } else {
          _clientColis = (responseData.listColis ?? []);
          _clientColis?.sort((first, second) => "${second.dateColis?.date}"
              .compareTo("${first.dateColis?.date}"));
        }
        notifyListeners();
      }
    } on DioError catch (e) {
      debugPrint("Error Message: ${e.response}");
    }
  }


  Future<void> fetchAndSetClientColisById(int? idColi) async {
    try {
      var response = await Dio().post(
        'https://dev.wwt-technology.com/api/colis/getcoli',
          options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $authToken',
              }
          ),
        data: {'idColi': idColi}
      );
      debugPrint("Response Message: ${response.data}");
      if (response.statusCode == 200) {
        final responseData = DetailsColisResponse.fromJson(response.data);
        _clientDetailsColis = responseData.detailsColis!;
        notifyListeners();
      }
    } on DioError catch (e) {
      debugPrint("Error Message: ${e.response}");
    }
  }

  Future<void> setClientColis(ColisData? colisData, int? taille, List<int?> nature) async {
    try {
      var response = await Dio().post(
          'https://dev.wwt-technology.com/api/colis/postcolis',
          options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $authToken',
              }
          ),
          data: FormData.fromMap({
                'iduser': userId,
                'description': colisData?.description,
                'taille': taille,
                'nature[0][id]': nature[0],
                'nature[1][id]': nature[1],
                'nature[2][id]': nature[2],
                'nature[3][id]': nature[3],
                'time': colisData?.dateColis?.time,
                'date': colisData?.dateColis?.date,
                'infoenvoyeur[0][placeadresse]': colisData?.infopersonEnv?.adresse?.placeadresse,
                'infoenvoyeur[0][laltitude]': colisData?.infopersonEnv?.adresse?.laltitude,
                'infoenvoyeur[0][longitude]': colisData?.infopersonEnv?.adresse?.longitude,
                'infoenvoyeur[0][nom]': colisData?.infopersonEnv?.nom,
                'infoenvoyeur[0][email]': colisData?.infopersonEnv?.email,
                'infoenvoyeur[0][phone]': colisData?.infopersonEnv?.phone_number,
                'inforecepteur[0][placeadresse]': colisData?.infopersonRec?.adresse?.placeadresse,
                'inforecepteur[0][laltitude]': colisData?.infopersonRec?.adresse?.laltitude,
                'inforecepteur[0][longitude]': colisData?.infopersonRec?.adresse?.longitude,
                'inforecepteur[0][nom]': colisData?.infopersonRec?.nom,
                'inforecepteur[0][email]': colisData?.infopersonRec?.email,
                'inforecepteur[0][phone]': colisData?.infopersonRec?.phone_number,
          })
      );
      debugPrint("Response Message: ${response.data}");
      if (response.statusCode == 200) {
        final responseData = AddColisResponse.fromJson(response.data);
        notifyListeners();
      }
    } on DioError catch (e) {
      debugPrint("Error Message: ${e.response}");
    }
  }

  Future<void> fetchAndSetColis(int? colisEtat, String? keyWord) async {
    try {
      var response = await Dio().post(
          'https://dev.wwt-technology.com/api/search/searchcolis',
          options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $authToken',
              }
          ),
          data: {
            'iduser': userId,
            'selectedEtat': colisEtat,
            'search': keyWord,
          }
      );
      debugPrint("Response Message: ${response.data}");
      if (response.statusCode == 200) {
        final responseData = ColisResponse.fromJson(response.data);
        if(colisEtat == 4){
          _clientColisRejete = (responseData.listColis ?? []);
        } else if(colisEtat == 5){
          _clientColisTermine = (responseData.listColis ?? []);
        } else {
          _clientColis = (responseData.listColis ?? []);
        }
        notifyListeners();
      }
    } on DioError catch (e) {
      debugPrint("Error Message: ${e.response}");
    }
  }


  int? _notifColis;
  int? _notifColisRejete;
  int? _notifColisTermine;
  int? _notifColisEncours;

  int? get notifColisEncours {
    return _notifColisEncours;
  }

  int? get notifColis {
    return _notifColis;
  }

  int? get notifColisRejete {
    return _notifColisRejete;
  }

  int? get notifColisTermine {
    return _notifColisTermine;
  }

  Future<void> fetchAndSetColisNotif() async {
    try {
      var response = await Dio().post(
          'https://dev.wwt-technology.com/api/user/getnotifclient',
          options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $authToken',
              }
          ),
          data: {
            'userid': userId,
          }
      );
      debugPrint("Response Message: ${response.data}");
      if (response.statusCode == 200) {

          _notifColisRejete = NotificationNbResponse.fromJson(response.data).userMessage?.notifnbrrejected;

          _notifColisTermine = NotificationNbResponse.fromJson(response.data).userMessage?.notifnbrtermine;

          _notifColisEncours = NotificationNbResponse.fromJson(response.data).userMessage?.notifnbrencour;

          _notifColis = NotificationNbResponse.fromJson(response.data).userMessage?.notifnbrtotal;

        notifyListeners();
      }
    } on DioError catch (e) {
      debugPrint("Error Message: ${e.response}");
    }
  }

}
