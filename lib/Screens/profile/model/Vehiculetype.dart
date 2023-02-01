class Vehiculetype {

    String? vehiculetype;

    Vehiculetype({this.vehiculetype});

    factory Vehiculetype.fromJson(Map<String, dynamic> json) {
        return Vehiculetype(
            vehiculetype: json['vehiculetype'], 
        );
    }

}