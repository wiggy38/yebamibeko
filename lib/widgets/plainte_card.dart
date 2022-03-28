import 'package:flutter/material.dart';
import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:yebamibekoapp/models/rubrique.dart';
import 'package:flip_card/flip_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yebamibekoapp/pages/login.dart';
import 'package:yebamibekoapp/pages/plaintes/appels.dart';
import 'package:yebamibekoapp/pages/plaintes/appels_prestataire.dart';
import 'package:yebamibekoapp/pages/plaintes/select_appel.dart';
//import 'package:soundpool/soundpool.dart';

class PlainteCard extends StatelessWidget {
  final Rubrique rubrique;
  const PlainteCard({Key? key, required this.rubrique}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _sharedPreferences;

    Future<Map<String, String>> chkUser() async {
      _sharedPreferences = await SharedPreferences.getInstance();

      String uid = await _sharedPreferences.getString('uid') ?? '';
      String role = await _sharedPreferences.getString('role') ?? '';
      //Future uid = FlutterSession().get('userid');
      //Future role = FlutterSession().get('role');
      Map<String, String> user = <String, String>{};
      user['uid'] = uid;
      user['role'] = role;

      /*if (uid == null) {
        return null;
      } else {*/
      debugPrint('UserIsLoggedIn (services_card) - SESSION - ' +
          uid.toString() +
          ' * ' +
          role.toString());
      return user;
      //}
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
                  Map<String, String> mapdata =
                      snapshot.data as Map<String, String>;
                  debugPrint('-------- User IsLoggedIn (plainte_card1) ');
                  // Snapshot has data, User is logged in
                  /*debugPrint(
                      'UUUUUUUUUUUUUUUU' + snapshot.data['role'].toString());*/
                  return InkWell(
                    onTap: () => (() {
                      // ignore: unrelated_type_equality_checks
                      if (mapdata['role'] == 'ROLE_PVV') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppelsList(
                                    userid: int.parse(mapdata['uid'] as String),
                                  )),
                        );
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AppelsList()),
                        );*/
                      } else if (mapdata['role'] == 'ROLE_PRESTATAIRE') {
                        debugPrint('-------- User IsLoggedIn (plainte_card)');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppelsListPrestaire(
                                    userid: int.parse(mapdata['uid'] as String),
                                  )),
                        );
                        //Navigator.pushNamed(context, appelsPrestaireRoute);
                      } else {
                        debugPrint(
                            '-------- User IsNotLoggedIn (plainte_card)');
                        Fluttertoast.showToast(
                          msg: 'Utilisateur non autorisé. 3',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                        );
                      }

                      /*List list = res.split('_');

                      if (list[0] == 'null') {
                        debugPrint('-------- User IsNotLoggedIn');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      } else {
                        debugPrint('-------- User IsLoggedIn');
                        if (list[1] == 'ROLE_PVV') {
                          Navigator.of(context).pushNamed(appelsPrestaireRoute,
                              arguments: list[0].toString());
                        } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AppelsListPrestaire(arguments: list[0].toString())),
                        );
                          
                          Navigator.of(context).pushNamed(appelsPrestaireRoute,
                              arguments: list[0].toString());
                        }
                      }*/
                    }()),
                    /*onTap: () => Navigator.pushNamed(context, appelsRoute,
                        arguments: rubrique.id),*/
                    //onTap: () => Navigator.of(context).pushNamed('login'),
                    child: Hero(
                        tag: rubrique.title,
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(0),
                          child: Container(
                              color: Colors.red,
                              height: 75.0,
                              padding: EdgeInsets.all(10.0),
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
                } else {
                  debugPrint('-------- User IsNotLoggedIn (plainte_card1)' +
                      snapshot.data.toString());
                  // Snapshot data is null, User is not connected
                  return InkWell(
                    onTap: () => (() {
                      //Navigator.pushNamed(context, loginViewRoute);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                selectTypeAppel()), //RegisterBaseUserPage
                      );
                    }()),
                    /*onTap: () => Navigator.pushNamed(context, appelsRoute,
                        arguments: rubrique.id),*/
                    //onTap: () => Navigator.of(context).pushNamed('login'),
                    child: Hero(
                        tag: rubrique.title,
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(0),
                          child: Container(
                              color: Colors.red,
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
                      debugPrint(
                          'HASDATA-------- User IsLoggedIn (plainte_card2) ');
                      // Snapshot has data, User is logged in
                      debugPrint('2========888888888==============' +
                          snapshot.data.toString());
                      Map<String, String> mapdata =
                          snapshot.data as Map<String, String>;
                      return GestureDetector(
                        onTap: () => (() {
                          debugPrint(
                              'HASDATA CLICK-------- Plaintecard User IsNotLoggedIn (plainte_card2) ');
                          /*Fluttertoast.showToast(
                            msg: 'Utilisateur non autorisé.',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                          );*/

                          // ignore: unrelated_type_equality_checks
                          if (mapdata['role'] == 'ROLE_PVV') {
                            debugPrint(
                                '-------- User IsLoggedIn (plainte_card) - ROLE_PVV');
                            //Navigator.pushNamed(context, appelsRoute);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AppelsList(
                                        userid:
                                            int.parse(mapdata['uid'] as String),
                                      )), //RegisterBaseUserPage
                            );
                          } else if (mapdata['role'] == 'ROLE_PRESTATAIRE') {
                            debugPrint('-------- User IsLoggedIn');
                            //Navigator.pushNamed(context, appelsPrestaireRoute);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      selectTypeAppel()), //RegisterBaseUserPage
                            );
                          } else {
                            debugPrint(
                                '-------- User IsNotLoggedIn (plainte_card) - ROLE_PRESTATAIRE');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      selectTypeAppel()), //RegisterBaseUserPage
                            );
                          }
                        }()),

                        //onTap: () => Navigator.pushNamed(context, quizzHomePageRoute,
                        //    arguments: rubrique.id),
                        child: FlipCard(
                          key: cardKey,
                          flipOnTouch: false,
                          front: Container(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 20.0),
                              height: 200.0,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/rubriq_chat.jpg'),
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
                            color: Colors.red,
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: const Center(
                              child: Text(
                                'PLAINTES',
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
                      debugPrint(
                          'HASNODATA-------- Plaintecard User IsNotLoggedIn (plainte_card2) ');
                      // Snapshot data is null, User is not connected
                      return GestureDetector(
                        onTap: () => (() {
                          debugPrint(
                              'HASNODATA CLICK-------- Plaintecard User IsNotLoggedIn (plainte_card2) ');
                          // ignore: unrelated_type_equality_checks
                          //Navigator.pushNamed(context, loginViewRoute);
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
                            color: Colors.red,
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: const Center(
                              child: Text(
                                'PLAINTES',
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
