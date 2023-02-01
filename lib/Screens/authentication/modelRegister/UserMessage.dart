
import 'package:monlivreur/Screens/authentication/modelRegister/User.dart';

class UserMessage {

    String? msg;
    String? token;
    User? user;

    UserMessage({this.msg, this.token, this.user});

    factory UserMessage.fromJson(Map<String, dynamic> json) {
        return UserMessage(
            msg: json['msg'], 
            token: json['token'], 
            user: json['user'] != null ? User.fromJson(json['user']) : null, 
        );
    }

}