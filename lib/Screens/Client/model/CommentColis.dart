class CommentColis {


    final String? commentaire;

    CommentColis({this.commentaire,});

    factory CommentColis.fromJson(Map<String, dynamic> json) {
        return CommentColis(
            commentaire: json['commentaire'],
        );
    }

}