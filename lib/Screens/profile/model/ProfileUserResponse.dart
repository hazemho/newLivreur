import 'package:monlivreur/Screens/profile/model/UserProfile.dart';

class ProfileUserResponse {

    String? debugMessage;
    UserProfile? userProfile;

    ProfileUserResponse({this.debugMessage, this.userProfile});

    factory ProfileUserResponse.fromJson(Map<String, dynamic> json) {
        return ProfileUserResponse(
            debugMessage: json['debugMessage'],
            userProfile: json['userMessage'] != null ? UserProfile.fromJson(json['userMessage']) : null,
        );
    }

}