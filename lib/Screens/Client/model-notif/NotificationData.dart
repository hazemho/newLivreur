class NotificationData {

  dynamic notifnbrtotal;
  dynamic notifnbrencour;
  dynamic notifnbrrejected;
  dynamic notifnbrtermine;

  NotificationData({this.notifnbrtotal, this.notifnbrencour, this.notifnbrrejected, this.notifnbrtermine});

  factory NotificationData.fromJson(dynamic json) {
    return NotificationData(
      notifnbrtotal: json['notifnbrtotal'],
      notifnbrencour: json['notifnbrencour'],
      notifnbrrejected: json['notifnbrrejected'],
      notifnbrtermine: json['notifnbrtermine'],
    );
  }

  // "notifnbrtotal": 0,
  // "notifnbrencour": 0,
  // "notifnbrrejected": 0,
  // "notifnbrtermine": 0

}