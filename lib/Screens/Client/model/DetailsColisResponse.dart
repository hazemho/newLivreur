import 'package:monlivreur/Screens/Client/model/ColisData.dart';

class DetailsColisResponse {

    String? debugMessage;
    ColisData? detailsColis;

    DetailsColisResponse({this.debugMessage, this.detailsColis});

    factory DetailsColisResponse.fromJson(Map<String, dynamic> json) {
        return DetailsColisResponse(
            debugMessage: json['debugMessage'],
            detailsColis: json['userMessage'] != null ? ColisData.fromJson(json['userMessage']) : null,
        );
    }

}