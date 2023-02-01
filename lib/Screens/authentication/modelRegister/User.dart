class User {

    final String? email;
    final String? firstname;
    final int? id;
    final int? id_address;
    final int? id_permis;
    final int? id_phone;
    final int? id_pieceidentite;
    final int? id_user_type;
    final String? lastname;
    final String? username;

    User({this.email, this.firstname, this.id,
        this.id_address, this.id_permis, this.id_phone, this.id_pieceidentite,
        this.id_user_type, this.lastname, this.username});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            email: json['email'],
            firstname: json['firstname'], 
            id: json['id'], 
            id_address: json['id_address'], 
            id_permis: json['id_permis'], 
            id_phone: json['id_phone'], 
            id_pieceidentite: json['id_pieceidentite'],
            id_user_type: json['id_user_type'], 
            lastname: json['lastname'], 
            username: json['username'],
        );
    }

}