class Appel {
  int id;
  String nomCategorie;
  String assistant;
  String moderateur;
  String nomType;
  String nomPlaignant;
  String prenomPlaignant;
  String numeroPlaignant;
  String quartierPlaignant;
  String villePlaignant;
  String addressPlaignant;
  String motifPlainte;
  String created_at;
  String etatPlainteAppel;
  String libelleShort;
  String libelleTxt;
  String dateNaissancePlaignant;
  String sexe;
  String etat_civil;
  String email;

  Appel(
      this.id,
      this.nomCategorie,
      this.moderateur,
      this.assistant,
      this.nomType,
      this.nomPlaignant,
      this.prenomPlaignant,
      this.numeroPlaignant,
      this.quartierPlaignant,
      this.villePlaignant,
      this.addressPlaignant,
      this.motifPlainte,
      this.created_at,
      this.etatPlainteAppel,
      this.libelleShort,
      this.libelleTxt,
      this.dateNaissancePlaignant,
      this.sexe,
      this.etat_civil,
      this.email);
}

/*final List<QuizzTheme> categories = [
  QuizzTheme(9,"General Knowledge", icon: FontAwesomeIcons.globeAsia),
  QuizzTheme(10,"Books", icon: FontAwesomeIcons.bookOpen),
  QuizzTheme(11,"Film", icon: FontAwesomeIcons.video),
  QuizzTheme(12,"Music", icon: FontAwesomeIcons.music),
  QuizzTheme(13,"Musicals & Theatres", icon: FontAwesomeIcons.theaterMasks),
];*/
