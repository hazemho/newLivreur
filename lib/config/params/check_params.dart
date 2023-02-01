
class CheckParams {

    final String? phoneNumber;

    const CheckParams({this.phoneNumber,});

    Map<String, dynamic> toJson() => {
        'field': "phone",
        'value': phoneNumber,
    };

}