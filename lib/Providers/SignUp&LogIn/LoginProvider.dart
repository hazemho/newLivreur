import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:monlivreur/Screens/authentication/model/CheckEmailResponse.dart';
import 'package:monlivreur/Screens/authentication/model/CheckPhoneResponse.dart';
import 'package:monlivreur/Screens/authentication/model/LoginResponse.dart';
import 'package:monlivreur/Screens/authentication/model/PhoneConfirmationResponse.dart';
import 'package:monlivreur/Screens/authentication/modelRegister/RegisterResponse.dart';
import 'package:monlivreur/Screens/profile/model/LogOutFromAllRespose.dart';
import 'package:monlivreur/Screens/profile/model/ProfileUserResponse.dart';
import 'package:monlivreur/Screens/profile/model/UserProfile.dart';
import 'package:monlivreur/config/params/register_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {


  String? _token;
  int? _userId;

  LoginProvider(this._userId, this._token);

  String? get token {
    return _token;
  }

  int? get userId {
    return _userId;
  }


  Future<LoginResponse> authenticate(String? email, String? password, String? fcmToken) async {
    try {
      var response = await Dio().post(
        'https://dev.wwt-technology.com/api/login',
        options: Options(headers: {'Accept': 'application/json'}),
        data: {
          'email': email,
          'password': password,
          'token_device': fcmToken,
        },
      );
      debugPrint("Response Message: ${response.statusCode} => ${response.data}");
      if(response.statusCode == 200 || response.statusCode == 201){
        final responseData = LoginResponse.fromJson(response.data);
        _token = responseData.token;
        _userId = responseData.userid;
        notifyListeners();
        return responseData;
      }
      return LoginResponse();
    } on DioError catch (e) {
      debugPrint("Error Message: ${e.type.name} ${e.response}");
      return LoginResponse.fromJson(e.response?.data);
    }
  }

  String _AuthSecurity = '';
  String get getAuthSecurity {
    return _AuthSecurity;
  }

  String _OtpCode = '';
  String get getOtpCode {
    return _OtpCode;
  }


  Future<CheckPhoneResponse> checkUserPhone(String? phoneNumber, {isForgotPassword = false}) async {
    try {
      var response = await Dio().post(isForgotPassword?
        'https://dev.wwt-technology.com/api/user/checktopasswordchange':
        'https://dev.wwt-technology.com/api/check',
        options: Options(headers: {'Accept': 'application/json'}),
        data: {
          'field': "phone",
          'value': phoneNumber,
        },
      );
      debugPrint("Message: ${response.data}");
      if(response.statusCode == 200) {
        return CheckPhoneResponse.fromJson(response.data);
      }
      return CheckPhoneResponse();
    } on DioError catch (e) {
      debugPrint("Response Message: ${e.response}");
      return CheckPhoneResponse.fromJson(e.response?.data);
    }
  }


  Future<CheckEmailResponse> checkEmail(String? email) async {
    try {
      var response = await Dio().post(
        'https://dev.wwt-technology.com/api/emailcheck',
        options: Options(headers: {'Accept': 'application/json'}),
        data: {'email': email},
      );
      debugPrint("Message: ${response.data}");
      if(response.statusCode == 200) {
        return CheckEmailResponse.fromJson(response.data);
      }
      return CheckEmailResponse();
    } on DioError catch (e) {
      debugPrint("Response Message: ${e.response}");
      return CheckEmailResponse();
    }
  }


  String _PhoneCode = '';
  String get getPhoneCode {
    return _PhoneCode;
  }

  Future<PhoneConfirmationResponse> phoneConfirmation(String? otpCode, String? authSecurity, {isForgotPassword = false}) async {
    try {
      var response = await Dio().post(isForgotPassword?
      'https://dev.wwt-technology.com/api/user/otpconfirmationupdatepassword':
        'https://dev.wwt-technology.com/api/otp-confirmation',
        options: Options(headers: {'Accept': 'application/json'}),
        data: {
          'auth': authSecurity,
          'otp': otpCode,
        },
      );
      debugPrint("Message: ${response.data}");
      if(response.statusCode == 200){
        return PhoneConfirmationResponse.fromJson(response.data);
      }
      return PhoneConfirmationResponse();
    } on DioError catch (e) {
      debugPrint("Response Message: ${e.response}");
      return PhoneConfirmationResponse.fromJson(e.response?.data);
    }
  }

  Future<PhoneConfirmationResponse> resetPassword(String? password, int? userCode) async {
    try {
      var response = await Dio().post(
        'https://dev.wwt-technology.com/api/user/regetpassword',
        options: Options(headers: {'Accept': 'application/json'}),
        data: {
          'password': password,
          'userid': userCode,
        },
      );
      debugPrint("Message: ${response.data}");
      if(response.statusCode == 200){
        return PhoneConfirmationResponse.fromJson(response.data);
      }
      return PhoneConfirmationResponse();
    } on DioError catch (e) {
      debugPrint("Response Message: ${e.response}");
      return PhoneConfirmationResponse.fromJson(e.response?.data);
    }
  }

  Future<RegisterResponse> register(RegisterParams params) async {
    try {
      var response = await Dio().post('https://dev.wwt-technology.com/api/register',
        options: Options(headers: {'Accept': 'application/json'}),
        data: FormData.fromMap({

          'id_phone': params.id_phone,
          'id_user_type': params.id_user_type,
          'id_type_vehicule': params.id_type_vehicule,

          'firstname': params.firstname,
          'lastname': params.lastname,
          'email': params.email,
          'password': params.password,
          'password_confirmation': params.password_confirmation,

          'longitude': params.longitude,
          'laltitude': params.laltitude,
          'placeadresse': params.placeadresse,

          'permis_path': params.permis_path != null
              ? await MultipartFile.fromFileSync(params.permis_path!.path): null,

          'cartegrise_path': params.cartegrise_path != null
              ? await MultipartFile.fromFileSync(params.cartegrise_path!.path): null,

          'pieceidentite_path': params.pieceidentite_path != null
              ? await MultipartFile.fromFileSync(params.pieceidentite_path!.path): null,

          'plaque_path': params.plaque_path != null
              ? await MultipartFile.fromFileSync(params.plaque_path!.path): null,

          'justification_path': params.justification_path != null
              ? await MultipartFile.fromFileSync(params.justification_path!.path): null,
        }),
      );
      debugPrint("Message: ${response.data}");
      if(response.statusCode == 200){
        return RegisterResponse.fromJson(response.data);
      }
      return RegisterResponse();
    } on DioError catch (e) {
      debugPrint("Response Message: ${e.response}");
      return RegisterResponse.fromJson(e.response?.data);
    }

  }

}
