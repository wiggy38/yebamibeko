/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:yebamibekoapp/models/appel.dart';
import 'package:flutter/material.dart';
import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yebamibekoapp/pages/plaintes/add_appel.dart';

class selectTypeAppel extends StatelessWidget {
  //static final String path = "lib/pages/plaintes/appel_details.dart";
  //final int uid;
  static const image =
      'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media';

  //const ServicesPage({Key key}) : super(key: key);
  var _sharedPreferences;

  Future<Map<String, String>> chkUser() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    var isLoggedIn = _sharedPreferences.getBool('isLoggedIn') ?? false;
    String uid = await _sharedPreferences.getString('uid');
    String role = await _sharedPreferences.getString('role');

    Map<String, String> user = <String, String>{};
    user['uid'] = uid;
    user['role'] = role;

    //if (isLoggedIn) {
    debugPrint('UserIsLoggedIn (services) - SESSION - ' + uid + ' * ' + role);
    return user;
    //} //else {
    //  debugPrint('UserIsLoggedOUT (services)');
    /*  return null;
    }*/
  }

  /*logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("uid");
    prefs.remove("username");
    prefs.remove("isLoggedIn");
    Fluttertoast.showToast(
      msg: 'Vous êtes maintenant déconnecté.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    ); 
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      selectTypeAppel()), //RegisterBaseUserPage
            );
    debugPrint("Disconnected User");
  }*/

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: const Text('Choisissez...'), // + this.appel.created_at
          elevation: 5,
          actions: const <Widget>[
            // action button
            /*const IconButton(
              icon: Icon(Icons.exit_to_app),
                                onPressed: () => (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => logoutUser()),
                                    );
                                }()),
              
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
                    future: chkUser(),
                    builder: (context, snapshot) {
                      /*if (snapshot.hasData) {*/
                      return Column(
                        children: <Widget>[
                          const SizedBox(height: 20.0),
                          ButtonTheme(
                            minWidth: deviceWidth,
                            child: ElevatedButton(
                              //style: const ButtonStyle(elevation: 8.0),
                              onPressed: () => (() {
                                if (snapshot.data == 'null') {
                                  Navigator.pushNamed(context, loginViewRoute);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddAppelPage()),
                                    //arguments: snapshot.data)), //RegisterBaseUserPage
                                  );
                                }
                              }()),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  //new Icon(Icons.map, color: Colors.white),
                                  Text(
                                    'Enregistrer une plainte par écrit',
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
                              //elevation: 8,
                              //padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                              //color: Colors.green,
                              onPressed: () => (() {
                                /*if (snapshot.data == 'null') {
                                    Navigator.pushNamed(
                                        context, loginViewRoute);
                                  } else {
                                    Navigator.pushNamed(
                                        context, recordPlainteRoute,
                                        arguments: snapshot.data);
                                  }*/
                                Navigator.pushNamed(context, recordPlainteRoute,
                                    arguments: snapshot.data);
                              }()),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  //new Icon(Icons.map, color: Colors.white),
                                  Text(
                                    'Enregistrer une plainte vocale',
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
                      /*} else {
                        return Container();
                      }*/
                    })),
          ],
        ),
      ),
    );
  }
}
