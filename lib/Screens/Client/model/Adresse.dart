class Adresse {

    final String? laltitude;
    final String? longitude;
    final String? placeadresse;

    Adresse({this.laltitude, this.longitude, this.placeadresse});

    factory Adresse.fromJson(Map<String, dynamic> json) {
        return Adresse(
            laltitude: json['laltitude'], 
            longitude: json['longitude'], 
            placeadresse: json['placeadresse'], 
        );
    }

}