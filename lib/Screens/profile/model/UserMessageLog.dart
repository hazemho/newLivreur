class UserMessageLog {

    String? token;

    UserMessageLog({this.token});

    factory UserMessageLog.fromJson(Map<String, dynamic> json) {
        return UserMessageLog(
            token: json['token'], 
        );
    }

}