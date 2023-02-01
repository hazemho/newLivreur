import 'package:monlivreur/Screens/Client/model/CommentColis.dart';
import 'package:monlivreur/Screens/Client/model/DateColis.dart';
import 'package:monlivreur/Screens/Client/model/EtatColis.dart';
import 'package:monlivreur/Screens/Client/model/Geopam.dart';
import 'package:monlivreur/Screens/Client/model/InfoPerson.dart';
import 'package:monlivreur/Screens/Client/model/InfoPersonUser.dart';

class ColisData {

    final int? id;
    final EtatColis? etat;
    final String? taille;
    final String? description;
    final InfoPerson? infopersonEnv;
    final InfoPerson? infopersonRec;
    final InfoPersonUser? infopersonUser;
    final InfoPersonUser? infopersonLivreur;
    final DateColis? dateColis;
    final String? ref_coli;
    final List<String>? natures;
    final List<CommentColis>? lastCommentaire;
    final Geopam? geopam;

    /// last commentaire: [{commentaire: colis livre}]

    ColisData({this.id, this.etat, this.infopersonEnv, this.infopersonRec, this.infopersonLivreur, this.geopam,
        this.infopersonUser, this.ref_coli, this.description, this.taille, this.dateColis, this.natures, this.lastCommentaire});

    factory ColisData.fromJson(Map<String, dynamic> json) {
        return ColisData(
            id: json['id'],
            description: json['description'],
            taille: json['taille'],
            ref_coli: json['ref_coli'],
            lastCommentaire: json['last commentaire'] != null ? (json['last commentaire'] as
            List).map((i) => CommentColis.fromJson(i)).toList() : null,

            geopam: json['geopam'] != null ? Geopam.fromJson(json['geopam']) : null,
            dateColis: json['updatedat'] != null ? DateColis.fromJson(json['updatedat']) : null,
            etat: json['etat'] != null ? EtatColis.fromJson(json['etat']) : null,
            natures: json['natures'] != null ? (json['natures'] as List).map((i) => i.toString()).toList() : null,
            infopersonEnv: json['infopersonEnv'] != null ? InfoPerson.fromJson(json['infopersonEnv']) : null,
            infopersonRec: json['infopersonRec'] != null ? InfoPerson.fromJson(json['infopersonRec']) : null,
            infopersonUser: json['infopersonUser'] != null ? InfoPersonUser.fromJson(json['infopersonUser']) : null,
            infopersonLivreur: json['infopersonLivreur'] != null ? InfoPersonUser.fromJson(json['infopersonLivreur']) : null,
        );
    }

}