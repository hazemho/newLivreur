class PhotoaddressINFO {

    String? photoadressephoto;
    String? placeadresse;

    PhotoaddressINFO({this.photoadressephoto, this.placeadresse});

    factory PhotoaddressINFO.fromJson(Map<String, dynamic> json) {
        return PhotoaddressINFO(
            photoadressephoto: json['photoadressephoto'], 
            placeadresse: json['placeadresse'], 
        );
    }

}