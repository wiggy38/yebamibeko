import 'package:flutter/material.dart';
import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:yebamibekoapp/models/rubrique.dart';
import 'package:flip_card/flip_card.dart';
import 'package:yebamibekoapp/pages/blog/blog.dart';
//import 'package:page_transition/page_transition.dart';
//import 'package:yebamibekoapp/pages/blog/blog.dart';

class BlogCard extends StatelessWidget {
  final Rubrique rubrique;

  const BlogCard({Key? key, required this.rubrique}) : super(key: key);
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
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 35.0,
      ),
    );

    final descriptionText = Container(
      height: 80.0,
      child: Text(
        rubrique.description,
        style: const TextStyle(
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
          /*onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BlogPage()),
          ),*/
          child: Hero(
              tag: rubrique.title,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(0),
                child: Container(
                    color: Colors.blue,
                    height: 73.0,
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
                  MaterialPageRoute(
                      builder: (context) => BlogPage(
                            title: 'Le Blog',
                          )),
                ),
                //onTap: () => Navigator.pushNamed(context, postsPageRoute,
                //arguments: rubrique.id),
                /*onTap: () => Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.scale,
                        alignment: Alignment.bottomCenter,
                        duration: Duration(milliseconds: 1000),
                        child: BlogPage())),*/
                child: FlipCard(
                  key: cardKey,
                  flipOnTouch: false,
                  front: Container(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image:
                              AssetImage('assets/images/rubriq_actualites.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: GestureDetector(
                        onTap: () => cardKey.currentState!.toggleCard(),
                        child: const Text(''),
                      )),
                  back: Container(
                    color: Colors.lightBlue[800],
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: const Center(
                      child: Text(
                        'ACTUALITES',
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
