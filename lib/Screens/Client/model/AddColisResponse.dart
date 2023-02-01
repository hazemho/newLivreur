import 'package:monlivreur/Screens/Client/model/UserMessage.dart';

class AddColisResponse {

    final String? debugMessage;
    final UserMessage? userMessage;

    AddColisResponse({this.debugMessage, this.userMessage});

    factory AddColisResponse.fromJson(Map<String, dynamic> json) {
        return AddColisResponse(
            debugMessage: json['debugMessage'], 
            userMessage: json['userMessage'] != null ? UserMessage.fromJson(json['userMessage']) : null, 
        );
    }

}