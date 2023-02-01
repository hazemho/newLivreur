class CheckPhoneError {

    String? data;
    String? debugMessage;
    String? userMessage;

    CheckPhoneError({this.data, this.debugMessage, this.userMessage});

    factory CheckPhoneError.fromJson(Map<String, dynamic> json) {
        return CheckPhoneError(
            data: json['data'],
            debugMessage: json['debugMessage'], 
            userMessage: json['userMessage'], 
        );
    }

}