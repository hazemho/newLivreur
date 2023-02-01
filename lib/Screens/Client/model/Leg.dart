class Leg {


    dynamic distance;
    dynamic duration;
    String? summary;
    dynamic weight;

    Leg({this.distance, this.duration, this.summary, this.weight});

    factory Leg.fromJson(Map<String, dynamic> json) {
        return Leg(
            distance: json['distance'],
            duration: json['duration'], 
            summary: json['summary'],
            weight: json['weight'],
        );
    }

}