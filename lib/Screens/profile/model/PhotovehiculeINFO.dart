
import 'package:monlivreur/Screens/profile/model/Vehiculetype.dart';

class PhotovehiculeINFO {

    String? photocgINFO;
    String? photomatINFO;
    Vehiculetype? vehiculetype;

    PhotovehiculeINFO({this.photocgINFO, this.photomatINFO, this.vehiculetype});

    factory PhotovehiculeINFO.fromJson(Map<String, dynamic> json) {
        return PhotovehiculeINFO(
            photocgINFO: json['photocgINFO'], 
            photomatINFO: json['photomatINFO'], 
            vehiculetype: json['vehiculetype'] != null ? Vehiculetype.fromJson(json['vehiculetype']) : null, 
        );
    }

}