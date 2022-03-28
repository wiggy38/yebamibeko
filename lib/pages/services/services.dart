import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:yebamibekoapp/pages/login.dart';
import 'package:yebamibekoapp/pages/services/nouvelle_demande.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../global.dart';

class ServicesPage extends StatelessWidget {
  static const String path = "lib/pages/plaintes/appel_details.dart";
  //final int uid;
  static const image =
      'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media';

  ServicesPage({Key? key}) : super(key: key);

  var _sharedPreferences;

  Future<Map<String, String?>?> chkUser(context) async {
    _sharedPreferences = await SharedPreferences.getInstance();

    var isLoggedIn = _sharedPreferences.getBool('isLoggedIn') ?? false;
    String? uid = await _sharedPreferences.getString('uid');
    String? role = await _sharedPreferences.getString('role');

    Map<String, String?> user = <String, String?>{};
    user['uid'] = uid;
    user['role'] = role;

    if (isLoggedIn) {
      debugPrint(
          'UserIsLoggedIn (services) - SESSION - ' + uid! + ' * ' + role!);
      return user;
    } else {
      debugPrint('UserIsLoggedOUT (services)');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title:
              const Text('Sélectionner un service'), // + this.appel.created_at
          elevation: 5,
          actions: const <Widget>[
            // action button
            /*const IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => logoutUser(),
            ),*/
          ]),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            /*SizedBox(
              height: 250,
              width: double.infinity,
              child: PNetworkImage(
                image,
                fit: BoxFit.cover,
              ),
            ),*/
            Container(
                margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: FutureBuilder(
                    future: chkUser(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            const SizedBox(height: 20.0),
                            ButtonTheme(
                              minWidth: deviceWidth,
                              child: ElevatedButton(
                                autofocus: false,
                                onPressed: () => (() {
                                  if (snapshot.data == 'null') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                    );
                                    /*Navigator.pushNamed(
                                        context, loginViewRoute);*/
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NouvelleDemandePage()),
                                    );
                                    /*Navigator.pushNamed(
                                        context, nouvelleDemandeServiceRoute,
                                        arguments: snapshot.data);*/
                                  }
                                }()),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    //new Icon(Icons.map, color: Colors.white),
                                    Text(
                                      'Référencement & Contre-référe...',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            ButtonTheme(
                              minWidth: deviceWidth,
                              child: ElevatedButton(
                                autofocus: false,
                                onPressed: () => (() {
                                  if (snapshot.data == 'null') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                    );
                                    /*Navigator.pushNamed(
                                        context, loginViewRoute);*/
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NouvelleDemandePage()),
                                    );
                                    /*Navigator.pushNamed(
                                        context, nouvelleDemandeServiceRoute,
                                        arguments: snapshot.data);*/
                                  }
                                }()),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    //new Icon(Icons.map, color: Colors.white),
                                    Text(
                                      'Informations & Sensibilisation',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            ButtonTheme(
                              minWidth: deviceWidth,
                              child: ElevatedButton(
                                onPressed: () => (() {
                                  if (snapshot.data == 'null') {
                                    debugPrint('M-------- User IsNotLoggedIn');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                    );
                                  } else {
                                    debugPrint('M-------- User IsLoggedIn');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NouvelleDemandePage()),
                                    );
                                    /*Navigator.pushNamed(
                                        context, nouvelleDemandeServiceRoute,
                                        arguments: snapshot.data);*/
                                  }
                                }()),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    //new Icon(Icons.map, color: Colors.white),
                                    Text(
                                      'Aides psycho sociales & jurid...',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Text('Le texte');
                      }
                    })),
          ],
        ),
      ),
    );
  }
}
