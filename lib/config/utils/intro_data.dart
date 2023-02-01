
class IntroData {

  final String title;
  final String description;
  final String imagePath;

  IntroData(this.title, this.description, this.imagePath);

  static List<IntroData> get introDataList {
    return [
      IntroData(
        "Fractions d'actions",
        "Au lieu d'avoir à acheter une action entière, investissez le montant que vous voulez.",
        "assets/img1.png"
      ),
      IntroData(
          "Apprenez au fur et à mesure",
          "Téléchargez l'application Stockpile et maîtrisez le marché avec notre mini-leçon.",
          "assets/img2.png"
      ),
      IntroData(
          "Enfants et ados",
          "Les enfants et les adolescents peuvent suivre leurs stocks 24 heures sur 24 et 7 jours sur 7 et effectuer des transactions que vous approuvez.",
          "assets/img3.png"
      ),
    ];
  }

}