class UserData {

    int? active;
    String? created_at;
    dynamic deleted_at;
    String? email;
    String? firstname;
    int? id;
    int? id_address;
    int? id_permis;
    int? id_phone;
    dynamic id_photoprofile;
    dynamic id_pieceidentite;
    int? id_user_type;
    String? lastname;
    dynamic status;
    String? updated_at;
    String? username;

    UserData({this.active, this.created_at, this.deleted_at, this.email,
        this.firstname, this.id, this.id_address, this.id_permis, this.id_phone,
        this.id_photoprofile, this.id_pieceidentite, this.id_user_type, this.lastname,
        this.status, this.updated_at, this.username});

    factory UserData.fromJson(Map<String, dynamic> json) {
        return UserData(
            active: json['active'], 
            created_at: json['created_at'], 
            deleted_at: json['deleted_at'],
            email: json['email'], 
            firstname: json['firstname'], 
            id: json['id'], 
            id_address: json['id_address'], 
            id_permis: json['id_permis'], 
            id_phone: json['id_phone'], 
            id_photoprofile: json['id_photoprofile'],
            id_pieceidentite: json['id_pieceidentite'],
            id_user_type: json['id_user_type'], 
            lastname: json['lastname'], 
            status: json['status'],
            updated_at: json['updated_at'], 
            username: json['username'], 
        );
    }

}