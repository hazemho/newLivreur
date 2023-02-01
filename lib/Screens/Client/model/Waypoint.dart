class Waypoint {

    dynamic distance;
    List<dynamic>? location;
    String? name;

    Waypoint({this.distance, this.location, this.name});

    factory Waypoint.fromJson(Map<String, dynamic> json) {
        return Waypoint(
            distance: json['distance'], 
            location: json['location'] != null ? new List<double>.from(json['location']) : null, 
            name: json['name'], 
        );
    }

}