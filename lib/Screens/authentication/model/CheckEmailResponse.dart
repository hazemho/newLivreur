class CheckEmailResponse {

    List<String>? debugMessage;
    List<String>? userMessage;

    CheckEmailResponse({this.debugMessage, this.userMessage});

    factory CheckEmailResponse.fromJson(Map<String, dynamic> json) {
        return CheckEmailResponse(
            userMessage: json['userMessage'] != null ? new List<String>.from(json['userMessage']) : null,
        );
    }

}