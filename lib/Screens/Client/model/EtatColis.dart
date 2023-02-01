class EtatColis {

    final int? id_etat;
    final String? etat;

    EtatColis({this.id_etat, this.etat,});

    factory EtatColis.fromJson(Map<String, dynamic> json) {
        return EtatColis(
            id_etat: json['id_etat'],
            etat: json['etat'],
        );
    }

}