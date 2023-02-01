import 'package:monlivreur/Screens/Client/model/ColisData.dart';

class ColisResponse {

    final String? debugMessage;
    final List<ColisData>? listColis;

    ColisResponse({this.debugMessage, this.listColis});

    factory ColisResponse.fromJson(Map<String, dynamic> json) {
        return ColisResponse(
            debugMessage: json['debugMessage'],
            listColis: json['userMessage'] != null ? (json['userMessage']
            as List).map((i) => ColisData.fromJson(i)).toList() : null,
        );
    }

}