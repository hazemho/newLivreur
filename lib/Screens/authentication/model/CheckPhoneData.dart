class CheckPhoneData {

    String? auth;
    String? otp;
    String? phone;
    dynamic user_exist;
    String? msg;

    CheckPhoneData({this.auth, this.otp, this.phone, this.user_exist, this.msg});

    factory CheckPhoneData.fromJson(Map<String, dynamic> json) {
        return CheckPhoneData(
            auth: json['auth'], 
            otp: json['otp'], 
            phone: json['phone'],
            user_exist: json['user_exist'],
            msg: json['msg'],
        );
    }

}