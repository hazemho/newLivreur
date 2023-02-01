import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:monlivreur/Screens/Client/model/AddColisResponse.dart';
import 'package:monlivreur/Screens/Client/model/Adresse.dart';
import 'package:monlivreur/Screens/Client/model/ColisData.dart';
import 'package:monlivreur/Screens/Client/model/ColisResponse.dart';
import 'package:monlivreur/Screens/Client/model/DetailsColisResponse.dart';
import 'package:monlivreur/Screens/Client/model/InfoPerson.dart';


class LivreurColisProvider with ChangeNotifier {

  final String authToken;
  final String userId;

  LivreurColisProvider(this.authToken, this.userId,);

  List<ColisData>? _livreurColis;

  List<ColisData> get livreurColis {
    return [...?_livreurColis];
  }

  List<ColisData>? _livreurColisRejete;

  List<ColisData> get livreurColisRejete {
    return [...?_livreurColisRejete];
  }

  List<ColisData>? _livreurColisTermine;

  List<ColisData> get livreurColisTermine {
    return [...?_livreurColisTermine];
  }

  List<ColisData> _livreurAlertColis = [];

  List<ColisData> get livreurAlertColis {
    return _livreurAlertColis;
  }


  ColisData? _livreurDetailsColis;

  ColisData? get livreurDetailsColis {
    return _livreurDetailsColis;
  }


  Future<void> fetchAndSetAlertColis() async {
    try {
      var response = await Dio().post(
        'https://dev.wwt-technology.com/api/colis/getrecapallcolis',
        options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $authToken',
            }
        ),
      );
      debugPrint("Response Message: ${response.data}");
      if (response.statusCode == 200) {
        final responseData = ColisResponse.fromJson(response.data);
        _livreurAlertColis = (responseData.listColis ?? []);
        _livreurAlertColis.sort((first, second) => "${second.dateColis?.date}"
            .compareTo("${first.dateColis?.date}"));
        notifyListeners();
      }
    } on DioError catch (e) {
      debugPrint("Error Message: ${e.response}");
    }
  }


  Future<void> fetchAndSetLivreurColis(int? selectedEtat) async {
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
          'idlivreur': userId,
          'selectedEtat': selectedEtat,
        }
      );
      debugPrint("Response Message: ${response.data}");
      if (response.statusCode == 200) {
        final responseData = ColisResponse.fromJson(response.data);
        if(selectedEtat == 4){
          _livreurColisRejete = (responseData.listColis ?? []);
          _livreurColisRejete?.sort((first, second) => "${second.dateColis?.date}"
              .compareTo("${first.dateColis?.date}"));
        } else if(selectedEtat == 5){
          _livreurColisTermine = (responseData.listColis ?? []);
          _livreurColisTermine?.sort((first, second) => "${second.dateColis?.date}"
              .compareTo("${first.dateColis?.date}"));
        } else {
          _livreurColis = (responseData.listColis ?? []);
          _livreurColis?.sort((first, second) => "${second.dateColis?.date}"
              .compareTo("${first.dateColis?.date}"));
        }
      }
      notifyListeners();
    } on DioError catch (e) {
      debugPrint("Error Message: ${e.response}");
    }
  }

  Future<void> fetchAndSetLivreurColisById(int? idColi) async {
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
        _livreurDetailsColis = responseData.detailsColis!;
        notifyListeners();
      }
    } on DioError catch (e) {
      debugPrint("Error Message: ${e.response}");
    }
  }


  Future<void> setEtatColis(int? idColi, int? idEtat, {String? comment}) async {
    try {
      var response = await Dio().post(
          'https://dev.wwt-technology.com/api/livreur/updateetatlivreur',
          options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $authToken',
              }
          ),
          data: {
            'idcoli': idColi,
            'idetat': idEtat,
            'comment': comment,
            'iduser': userId,
          }
      );
      debugPrint("Response Message: ${response.data}");
    } on DioError catch (e) {
      debugPrint("Error Message: ${e.response}");
    }
  }


  Future<void> setColisDecline(int? idColi) async {
    try {
      var response = await Dio().post(
          'https://dev.wwt-technology.com/api/user/decline',
          options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $authToken',
              }
          ),
          data: {
            'idcoli': idColi,
            'iduser': userId,
          }
      );
      debugPrint("Response Message: ${response.data}");
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
            'idlivreur': userId,
            'selectedEtat': colisEtat,
            'search': keyWord,
          }
      );
      debugPrint("Response Message: ${response.data}");
      if (response.statusCode == 200) {
        final responseData = ColisResponse.fromJson(response.data);
        if(colisEtat == 4){
          _livreurColisRejete = (responseData.listColis ?? []);
        } else if(colisEtat == 5){
          _livreurColisTermine = (responseData.listColis ?? []);
        } else {
          _livreurColis = (responseData.listColis ?? []);
        }
        notifyListeners();
      }
    } on DioError catch (e) {
      debugPrint("Error Message: ${e.response}");
    }
  }


}
