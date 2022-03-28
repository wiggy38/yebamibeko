import 'package:flutter/material.dart';
import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:yebamibekoapp/models/rubrique.dart';
import 'package:flip_card/flip_card.dart';
import 'package:page_transition/page_transition.dart';
import 'package:yebamibekoapp/pages/repertoire/provinces.dart';

class DirectoryCard extends StatelessWidget {
  final Rubrique rubrique;

  const DirectoryCard({Key? key, required this.rubrique}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final postDate = Text(
      rubrique.title,
      style: TextStyle(
        color: Colors.grey.withOpacity(0.6),
        fontWeight: FontWeight.bold,
      ),
    );

    final rubriqueTitle = Text(
      rubrique.title,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 35.0,
      ),
    );

    final descriptionText = Container(
      height: 80.0,
      child: Text(
        rubrique.description,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
        ),
      ),
    );

    final cardContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        postDate,
        rubriqueTitle,
        const SizedBox(
          height: 5.0,
        ),
        descriptionText
      ],
    );

    final rubriqueImage = Positioned(
      left: 0,
      bottom: 0,
      child: Opacity(
        opacity: 0.8,
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, provincesPageRoute,
              arguments: rubrique.id),
          child: Hero(
              tag: rubrique.title,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(0),
                child: Container(
                    color: Colors.green,
                    height: 75.0,
                    padding: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width,
                    child: Opacity(
                      opacity: 1.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          rubriqueTitle,
                          const SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    )),
              )),
        ),
      ),
    );

    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

    return Container(
      height: 200.0, // Hauteur de la carte
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Material(
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProvincesPage()),
                ),
                child: FlipCard(
                  key: cardKey,
                  flipOnTouch: false,
                  front: Container(
                      padding: EdgeInsets.only(top: 20.0, left: 20.0),
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(rubrique.image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: GestureDetector(
                        onTap: () => cardKey.currentState!.toggleCard(),
                        child: Container(
                          child: Text(''),
                        ),
                      )),
                  back: Container(
                    color: Colors.lightGreen[800],
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: const Center(
                      child: Text(
                        'LES CLINIQUES',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 45.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              elevation: 5.0,
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
          rubriqueImage
        ],
      ),
    );
  }
}
