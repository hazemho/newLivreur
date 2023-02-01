
class ConfirmPhoneParams {

    final String? otpCode;
    final String? authSecurity;

    const ConfirmPhoneParams({this.otpCode, this.authSecurity});

    Map<String, dynamic> toJson() => {
        'auth': authSecurity,
        'otp': otpCode,
    };

}