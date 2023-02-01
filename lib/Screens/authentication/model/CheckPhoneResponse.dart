import 'package:monlivreur/Screens/authentication/model/CheckPhoneData.dart';

class CheckPhoneResponse {

    CheckPhoneData? checkPhoneData;
    dynamic debugMessage;
    dynamic userMessage;

    CheckPhoneResponse({this.checkPhoneData, this.debugMessage, this.userMessage});

    factory CheckPhoneResponse.fromJson(Map<String, dynamic> json) {
        return CheckPhoneResponse(
            checkPhoneData: json['data'] != null ? CheckPhoneData.fromJson(json['data']) : null,
            debugMessage: json['debugMessage'], 
            userMessage: json['userMessage'], 
        );
    }

}