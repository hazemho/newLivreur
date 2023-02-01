
import 'package:monlivreur/Screens/authentication/modelRegister/UserMessage.dart';

class RegisterResponse {

    String? debugMessage;
    UserMessage? userMessage;

    RegisterResponse({this.debugMessage, this.userMessage});

    factory RegisterResponse.fromJson(Map<String, dynamic> json) {
        return RegisterResponse(
            debugMessage: json['debugMessage'], 
            userMessage: json['userMessage'] != null ?
            UserMessage.fromJson(json['userMessage']) : null,
        );
    }

}