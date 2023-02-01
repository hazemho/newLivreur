import 'package:monlivreur/Screens/Client/model/Adresse.dart';

class InfoPersonUser {

    final String? photoINFO;
    final String? userINFO;
    final String? phoneINFO;

    InfoPersonUser({this.photoINFO, this.userINFO, this.phoneINFO});

    factory InfoPersonUser.fromJson(Map<String, dynamic> json) {
        return InfoPersonUser(
            photoINFO: json['photoINFO'],
            userINFO: json['userINFO'],
            phoneINFO: json['phoneINFO'],
        );
    }

}