import 'package:monlivreur/Screens/Client/model/Adresse.dart';

class InfoPerson {

    final Adresse? adresse;
    final String? email;
    final String? nom;
    final String? phone_number;

    InfoPerson({this.adresse, this.email, this.nom, this.phone_number});

    factory InfoPerson.fromJson(Map<String, dynamic> json) {
        return InfoPerson(
            adresse: json['adresse'] != null ? Adresse.fromJson(json['adresse']) : null, 
            email: json['email'], nom: json['nom'],
            phone_number: json['phone_number'], 
        );
    }

}