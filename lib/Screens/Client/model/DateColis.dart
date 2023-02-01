class DateColis {

  final String? time;
  final String? date;

  DateColis({this.time, this.date,});

  factory DateColis.fromJson(Map<String, dynamic> json) {
    return DateColis(
      time: json['time'],
      date: json['updated_at'],
    );
  }

}