import 'package:monlivreur/Screens/Client/model/Route.dart';
import 'package:monlivreur/Screens/Client/model/Waypoint.dart';

class Geopam {

    String? code;
    List<Route>? routes;
    String? uuid;
    List<Waypoint>? waypoints;

    Geopam({this.code, this.routes, this.uuid, this.waypoints});

    factory Geopam.fromJson(Map<String, dynamic> json) {
        return Geopam(
            code: json['code'], 
            routes: json['routes'] != null ? (json['routes'] as List).map((i) =>
                Route.fromJson(i)).toList() : null,
            uuid: json['uuid'], 
            waypoints: json['waypoints'] != null ? (json['waypoints'] as List).map((i) =>
                Waypoint.fromJson(i)).toList() : null,
        );
    }


}