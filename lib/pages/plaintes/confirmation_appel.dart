/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'dart:developer';

import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:yebamibekoapp/models/user.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:yebamibekoapp/pages/plaintes/appels.dart';
import 'package:yebamibekoapp/pages/plaintes/appels_prestataire.dart';
import '../global.dart';

class AppelConfirmationPage extends StatelessWidget {
  static const String path = "lib/pages/plaintes/appel_details.dart";
  //final int uid;
  static const image =
      'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media';

  //const ServicesPage({Key key}) : super(key: key);
  var _sharedPreferences;

  AppelConfirmationPage({Key? key}) : super(key: key);

  Future<User?> chkUser(context) async {
    _sharedPreferences = await SharedPreferences.getInstance();

    var isLoggedIn = _sharedPreferences.getBool('isLoggedIn') ?? false;
    String uid = await _sharedPreferences.getString('uid');
    String role = await _sharedPreferences.getString('role');
    String username = await _sharedPreferences.getString('name');

    User user = User(uid, username, role);
    /*Map<String, String> user = new Map<String, String>(uid, username, role);
    user['uid'] = uid;
    user['role'] = role;
    user['username'] = username;*/

    if (isLoggedIn) {
      Global.Uid = uid;
      Global.Username = _sharedPreferences.getString('name') ?? "Developer";
      return user;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
              "Confirmation d'enregistrement"), // + this.appel.created_at
          elevation: 5,
          actions: const <Widget>[
            // action button
            /*IconButton(
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
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
              child: const Text(
                "Votre plainte a bien été enregisrée. Nous vous contacterons dès que possible.",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(16.0, 150.0, 16.0, 16.0),
                child: FutureBuilder(
                    future: chkUser(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        User mapdata = snapshot.data as User;
                        return Column(
                          children: <Widget>[
                            const SizedBox(height: 20.0),
                            ButtonTheme(
                              minWidth: deviceWidth,
                              child: ElevatedButton(
                                /*elevation: 8,
                                padding:
                                    EdgeInsets.only(top: 20.0, bottom: 20.0),
                                color: Colors.purple,*/
                                onPressed: () => (() {
                                  if (mapdata.role == 'ROLE_PVV') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AppelsList(
                                              userid: int.parse(mapdata.id))),
                                    );
                                    /*Navigator.pushNamed(context, appelsRoute,
                                        arguments: snapshot.data);*/
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AppelsListPrestaire(
                                                userid: int.parse(mapdata.id),
                                              )),
                                    );
                                    /*Navigator.pushNamed(
                                        context, appelsPrestaireRoute,
                                        arguments: snapshot.data);*/
                                  }
                                }()),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    //new Icon(Icons.map, color: Colors.white),
                                    Text(
                                      'Afficher la liste des appels',
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
                          ],
                        );
                      } else {
                        debugPrint('UserIsLoggedOUT 555555');
                        return Container();
                      }
                    })),
          ],
        ),
      ),
    );
  }

  logoutUser() {}
}
