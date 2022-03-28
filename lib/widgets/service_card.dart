// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:yebamibekoapp/models/rubrique.dart';
import 'package:flip_card/flip_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yebamibekoapp/pages/login.dart';
import 'package:yebamibekoapp/pages/register_user.dart';
import 'package:yebamibekoapp/pages/services/services.dart';
//import 'package:soundpool/soundpool.dart';

class ServiceCard extends StatelessWidget {
  final Rubrique rubrique;
  const ServiceCard({Key? key, required this.rubrique}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _sharedPreferences;

    Future<Map<String, String?>?> chkUser() async {
      _sharedPreferences = await SharedPreferences.getInstance();

      String? uid = await _sharedPreferences.getString('uid');
      String? role = await _sharedPreferences.getString('role');
      //Future uid = FlutterSession().get('userid');
      //Future role = FlutterSession().get('role');
      Map<String, String?> user = <String, String?>{};
      user['uid'] = uid;
      user['role'] = role;

      if (uid == null) {
        return null;
      } else {
        debugPrint('UserIsLoggedIn (services_card) - SESSION - ' +
            uid.toString() +
            ' * ' +
            role.toString());
        return user;
      }
    }

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
          child: FutureBuilder(
              future: chkUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  debugPrint(
                      '-------- User IsLoggedIn' + snapshot.data.toString());
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ServicesPage()),
                    ),
                    child: Hero(
                        tag: rubrique.title,
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(0),
                          child: Container(
                              color: Colors.yellow,
                              height: 75.0,
                              padding: const EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width,
                              // ignore: unnecessary_new
                              child: new Opacity(
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
                  );
                } else {
                  debugPrint(
                      '-------- User IsNotLoggedIn' + snapshot.data.toString());
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    ),
                    child: Hero(
                        tag: rubrique.title,
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(0),
                          child: Container(
                              color: Colors.yellow,
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
                  );
                }
              })),
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
              child: FutureBuilder(
                  future: chkUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      debugPrint('-------- User IsLoggedIn');
                      debugPrint('========888888888==============' +
                          snapshot.data.toString());
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ServicesPage()),
                        ),
                        child: FlipCard(
                          key: cardKey,
                          flipOnTouch: false,
                          front: Container(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 20.0),
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
                                  child: const Text(''),
                                ),
                              )),
                          back: Container(
                            color: Colors.yellow,
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: const Center(
                              child: Text(
                                'NOS SERVICES',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 45.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      debugPrint('-------- User IsNotLoggedIn');
                      /*return 
                      debugPrint('========888888888==============' +
                          snapshot.data.toString());*/
                      return GestureDetector(
                        onTap: () => (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Login()), //RegisterBaseUserPage
                          );
                        }()),
                        child: FlipCard(
                          key: cardKey,
                          flipOnTouch: false,
                          front: Container(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 20.0),
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
                                  child: const Text(''),
                                ),
                              )),
                          back: Container(
                            color: Colors.yellow,
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: const Center(
                              child: Text(
                                'NOS SERVICES',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 45.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
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
