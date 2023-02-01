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


class UserProvider with ChangeNotifier {


  String? _token;
  int? _userId;

  String? get token {
    return _token;
  }

  int? get userId {
    return _userId;
  }

  UserProvider(this._userId, this._token);


  Future<PhoneConfirmationResponse> updatePassword(String? oldPassword, String? newPassword, int? userCode) async {
    try {
      var response = await Dio().post(
        'https://dev.wwt-technology.com/api/user/updatepassword',
        options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            }
        ),
        data: {
          'passwordnew': newPassword,
          'passwordold': oldPassword,
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

  Future<CheckPhoneResponse> updatePhone(String? phoneNumber, int? userCode, String? password) async {
    try {
      var response = await Dio().post(
      'https://dev.wwt-technology.com/api/user/phoneupdate',
        options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            }
        ),
        data: {
          'userid': userCode,
          'password': password,
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

  Future<PhoneConfirmationResponse> checkUpdatePhone(int? userCode, String? authSecurity, String? otpCode) async {
    try {
      var response = await Dio().post(
        'https://dev.wwt-technology.com/api/user/otpconfirmationupdatephone',
        options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            }
        ),
        data: {
          'userid': userCode,
          'auth': authSecurity,
          'otp': otpCode,
        },
      );
      debugPrint("Message: ${response.data}");
      if(response.statusCode == 200) {
        return PhoneConfirmationResponse.fromJson(response.data);
      }
      return PhoneConfirmationResponse();
    } on DioError catch (e) {
      debugPrint("Response Message: ${e.response}");
      return PhoneConfirmationResponse();
    }
  }


  Future<bool> updateUserPhoto(String? userPhoto) async {
    try {
      var response = await Dio().post(
        'https://dev.wwt-technology.com/api/user/updatephotoprofile',
        options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            }
        ),
        data: FormData.fromMap({
          'userid': userId,
          'photoprofile_path': userPhoto != null
              ? await MultipartFile.fromFileSync(userPhoto): null,
        }),
      );
      debugPrint("Message: ${response.data}");
      if(response.statusCode == 200){
        return true;
      }
      return false;
    } on DioError catch (e) {
      debugPrint("Response Message: ${e.response}");
      return false;
    }
  }


  Future<void> logOut(String? fcmToken) async {
    try {
      var response = await Dio().post('https://dev.wwt-technology.com/api/logout',
        options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            }
        ),
        data: {
          'token_device': fcmToken,
        },
      );
      debugPrint("Message: ${response.data}");
      if(response.statusCode == 200){
      }

    } catch (error) {
      print(error);
      throw error;
    }
  }

  UserProfile? _userProfile;

  UserProfile? get userProfile {
    return _userProfile;
  }

  Future<void> getUserProfile() async {
    try {
      var response = await Dio().post(
        'https://dev.wwt-technology.com/api/user/profile',
        options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            }
        ),
        data: {
          'userid': userId,
        },
      );
      debugPrint("Message: ${response.data}");
      if(response.statusCode == 200) {
        final responseData = ProfileUserResponse.fromJson(response.data);
        _userProfile = responseData.userProfile;
        notifyListeners();
      }
    } on DioError catch (e) {
      debugPrint("Error Message: ${e.response}");
    }
  }


  Future<RegisterResponse> updateUserInfo(String? userEmail,
      String? userFirstName, String? userAddresse, int? userType,
      String? cartIdentite, String? permis, String? justification) async {
    try {
      var response = await Dio().post(
        'https://dev.wwt-technology.com/api/user/updateprofile',
        options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            }
        ),
        data: FormData.fromMap({
          'userid': userId,
          'usertype': userType,
          'username': userFirstName,
          'email': userEmail,
          'placeadresse': userAddresse,

          'pieceidentite_path': cartIdentite != null? await MultipartFile.fromFileSync(cartIdentite): null,
          'permis_path': permis != null? await MultipartFile.fromFileSync(permis): null,
          'justification_path': justification != null? await MultipartFile.fromFileSync(justification): null,
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

  Future<RegisterResponse> updateVehiculeDoc(String? cartegrise, String? plaque, int? viheculeType) async {
    try {
      var response = await Dio().post(
        'https://dev.wwt-technology.com/api/user/updateuservehicule',
        options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            }
        ),
        data: FormData.fromMap({
          'userid': userId,
          'id_type_vehicule': viheculeType,

          'cartegrise_path': cartegrise != null? await MultipartFile.fromFileSync(cartegrise): null,
          'plaque_path': plaque != null? await MultipartFile.fromFileSync(plaque): null,

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


  Future<LogOutFromAllRespose> logOutFromAll(String? fcmToken) async {
    try {
      var response = await Dio().post(
        'https://dev.wwt-technology.com/api/user/useralldeconnect',
        options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            }
        ),
        data: {
          'userid': userId,
          'token_device': fcmToken,
        },
      );
      debugPrint("Response Message: ${response.data}");
      if(response.statusCode == 200){
        final responseData = LogOutFromAllRespose.fromJson(response.data);
        _token = responseData.userMessage?.token;
        notifyListeners();
        return LogOutFromAllRespose.fromJson(response.data);
      }
      return LogOutFromAllRespose();
    } on DioError catch (e) {
      debugPrint("Error Message: ${e.response}");
      return LogOutFromAllRespose();
    }
  }



}
