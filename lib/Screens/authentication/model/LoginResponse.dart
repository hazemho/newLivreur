
class LoginResponse {

    int? userid;
    int? usertype;
    int? userstatus;
    String? token;
    dynamic error;

    LoginResponse({this.error, this.userid, this.userstatus, this.usertype, this.token});

    factory LoginResponse.fromJson(Map<String, dynamic> json) {
        return LoginResponse(
            error: json['error'],
            userid: json['userid'],
            usertype: json['usertype'],
            userstatus: json['userstatus'],
            token: json['token'],
        );
    }

}