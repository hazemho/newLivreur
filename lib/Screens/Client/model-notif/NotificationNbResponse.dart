
import 'package:monlivreur/Screens/Client/model-notif/NotificationData.dart';

class NotificationNbResponse {

  NotificationData? userMessage;

  NotificationNbResponse({this.userMessage,});

  factory NotificationNbResponse.fromJson(dynamic json) {
    return NotificationNbResponse(
        userMessage: json['userMessage'] != null ?
        NotificationData.fromJson(json['userMessage']) : null,
    );

  }

}