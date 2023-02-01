import 'package:monlivreur/Screens/authentication/model/UserMessage.dart';

class PhoneConfirmationResponse {

    String? debugMessage;
    UserMessage? userMessage;

    PhoneConfirmationResponse({this.debugMessage, this.userMessage});

    factory PhoneConfirmationResponse.fromJson(Map<String, dynamic> json) {
        return PhoneConfirmationResponse(
            debugMessage: json['debugMessage'],
            userMessage: json['userMessage'] != null ? UserMessage.fromJson(json['userMessage']) : null, 
        );
    }

}