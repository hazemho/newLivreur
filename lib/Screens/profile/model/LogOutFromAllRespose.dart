import 'package:monlivreur/Screens/profile/model/UserMessageLog.dart';

class LogOutFromAllRespose {

    String? debugMessage;
    UserMessageLog? userMessage;

    LogOutFromAllRespose({this.debugMessage, this.userMessage});

    factory LogOutFromAllRespose.fromJson(Map<String, dynamic> json) {
        return LogOutFromAllRespose(
            debugMessage: json['debugMessage'],
            userMessage: json['userMessage'] != null ? UserMessageLog.fromJson(json['userMessage']) : null,
        );
    }

}