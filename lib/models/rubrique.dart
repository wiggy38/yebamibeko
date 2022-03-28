import 'package:yebamibekoapp/utils/utils.dart';

class Rubrique {
  int id;
  String title;
  String description = 'Discussion';
  String bannerImg = AvailableImages.postBanner['assetPath'].toString();
  String image;

  Rubrique(this.id, this.title, this.image);
}

final List<Rubrique> rubriques = [
  Rubrique(
      1, 'Plaintes', AvailableImages.rubriqPlainte['assetPath'].toString()),
  Rubrique(2, 'Actualités',
      AvailableImages.rubriqActualites['assetPath'].toString()),
  Rubrique(3, 'Quizz', AvailableImages.rubriqQuizz['assetPath'].toString()),
  Rubrique(4, 'Les cliniques',
      AvailableImages.rubriqCentres['assetPath'].toString()),
  Rubrique(5, 'Chat', AvailableImages.rubriqChat['assetPath'].toString()),
  Rubrique(
      6, 'Mes services', AvailableImages.rubriqPlainte['assetPath'].toString()),
  Rubrique(7, 'Plaintes Vocaux',
      AvailableImages.rubriqPlainte['assetPath'].toString()),
]; /**/
