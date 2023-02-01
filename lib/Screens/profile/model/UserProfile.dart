import 'package:monlivreur/Screens/profile/model/PhotoaddressINFO.dart';
import 'package:monlivreur/Screens/profile/model/PhotovehiculeINFO.dart';

class UserProfile {

    int? active;
    String? email;
    String? firstname;
    String? lastname;
    String? phoneINFO;
    PhotoaddressINFO? photoaddressINFO;
    String? photocinINFO;
    String? photopermiINFO;
    String? photoprofileINFO;
    PhotovehiculeINFO? photovehiculeINFO;
    String? username;

    UserProfile({this.active, this.email, this.firstname, this.lastname, this.phoneINFO, this.photoaddressINFO, this.photocinINFO, this.photopermiINFO, this.photoprofileINFO, this.photovehiculeINFO, this.username});

    factory UserProfile.fromJson(Map<String, dynamic> json) {
        return UserProfile(
            active: json['active'], 
            email: json['email'], 
            firstname: json['firstname'], 
            lastname: json['lastname'], 
            phoneINFO: json['phoneINFO'], 
            photoaddressINFO: json['photoaddressINFO'] != null ? PhotoaddressINFO.fromJson(json['photoaddressINFO']) : null, 
            photocinINFO: json['photocinINFO'], 
            photopermiINFO: json['photopermiINFO'], 
            photoprofileINFO: json['photoprofileINFO'], 
            photovehiculeINFO: json['photovehiculeINFO'] != null ? PhotovehiculeINFO.fromJson(json['photovehiculeINFO']) : null, 
            username: json['username'], 
        );
    }

}