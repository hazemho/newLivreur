class UserMessage {

    final int? colisData;
    dynamic error;
    final String? msg;

    UserMessage({this.colisData, this.error, this.msg});

    factory UserMessage.fromJson(Map<String, dynamic> json) {
        return UserMessage(
            colisData: json['colisData'], 
            error: json['error'],
            msg: json['msg'], 
        );
    }

}