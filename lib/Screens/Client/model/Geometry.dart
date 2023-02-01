import 'package:latlong2/latlong.dart';

class Geometry {

    List<LatLng>? coordinates;
    String? type;

    Geometry({this.coordinates, this.type});

    factory Geometry.fromJson(Map<String, dynamic> json) {
        return Geometry(
            coordinates: json['coordinates'] != null ? (json['coordinates'] as
            List).map((i) => LatLng(i[1], i[0])).toList() : null,
            type: json['type'], 
        );
    }

}