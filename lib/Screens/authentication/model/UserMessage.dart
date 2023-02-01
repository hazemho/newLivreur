class UserMessage {

    int? id_phone;
    String? msg;
    String? password;

    UserMessage({this.id_phone, this.msg, this.password});

    factory UserMessage.fromJson(Map<String, dynamic> json) {
        return UserMessage(
            id_phone: json['id']??json['iduser'],
            msg: json['msg'],
            password: json['password'],
        );
    }

}