import 'package:monlivreur/Screens/Client/model/Geometry.dart';
import 'package:monlivreur/Screens/Client/model/Leg.dart';

class Route {

    bool country_crossed;
    dynamic distance;
    dynamic duration;
    Geometry? geometry;
    List<Leg>? legs;
    dynamic weight;
    String? weight_name;

    Route({this.country_crossed = false, this.distance, this.duration, this.geometry,
        this.legs, this.weight, this.weight_name});

    factory Route.fromJson(Map<String, dynamic> json) {
        return Route(
            country_crossed: json['country_crossed'], 
            distance: json['distance'], 
            duration: json['duration'], 
            geometry: json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null,
            legs: json['legs'] != null ? (json['legs'] as List).map((i) => Leg.fromJson(i)).toList() : null, 
            weight: json['weight'], 
            weight_name: json['weight_name'], 
        );
    }

}