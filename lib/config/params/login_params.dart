
class LoginParams {

    final String? email;
    final String? password;
    final String? fcmToken;

    const LoginParams({this.email, this.password, this.fcmToken});

    Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'token_device': fcmToken,
    };

}