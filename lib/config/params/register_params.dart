
import 'dart:io';

class RegisterParams {

    final int? id_phone;
    final int? id_user_type;
    final int? id_type_vehicule;

    final String? email;
    final String? firstname;
    final String? lastname;

    final String? longitude;
    final String? laltitude;
    final String? placeadresse;

    final String? password;
    final String? password_confirmation;

    final File? permis_path;
    final File? cartegrise_path;
    final File? pieceidentite_path;
    final File? plaque_path;
    final File? justification_path;


    RegisterParams({this.cartegrise_path, this.email, this.firstname, this.id_phone,
        this.id_type_vehicule, this.id_user_type, this.justification_path, this.laltitude,
        this.lastname, this.longitude, this.password, this.password_confirmation, this.permis_path,
        this.pieceidentite_path, this.placeadresse, this.plaque_path});

}