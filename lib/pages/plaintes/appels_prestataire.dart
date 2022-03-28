import 'package:fluttertoast/fluttertoast.dart';
import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:yebamibekoapp/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:yebamibekoapp/models/appel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yebamibekoapp/pages/global.dart';

/**
 * Author: Sudip Thapa  
 * profile: https://github.com/sudeepthapa
  */

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppelsListPrestaire extends StatefulWidget {
  final int userid;
  const AppelsListPrestaire({Key? key, required this.userid}) : super(key: key);
  static const String path = "lib/pages/appels_prestataire.dart";
  @override
  _AppelsListPrestaireState createState() => _AppelsListPrestaireState();
}

class _AppelsListPrestaireState extends State<AppelsListPrestaire> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chkUser();
    checkpermissions();
  }

  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);

  Future<List<Appel>> getProvincesList() async {
    //debugPrint('000000000000000000');
    var response = await http.get(Uri.parse(
        'http://app.yebamibeko.org/api/userappels/' +
            widget.userid.toString()));
    //debugPrint("11111111111" + response.body.toString());
    var dataDecoded = json.decode(response.body);
    //debugPrint("AppelPrestataire2222222" + dataDecoded['resultats'].toString());

    List<Appel> appelsList = [];

    if (response.statusCode == 200) {
      if (dataDecoded['resultats'] != null) {
        dataDecoded['resultats'].forEach((theme) {
          //debugPrint("3333333" + theme.toString());

          int id;
          String nomCategorie;
          String moderateur;
          String assistant;
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
          //debugPrint("444444");

          if (theme['id'] != null) {
            libelleTxt = theme['libellePlainte'];
            libelleShort = libelleTxt;
            if (libelleTxt.length > 25) {
              libelleShort = libelleTxt.substring(1, 25) + "...";
            }

            id = theme['id'];
            //debugPrint("5555555_" + id.toString());
            nomCategorie = theme['nomCategorie'];
            moderateur = theme['moderateur'];
            assistant = theme['assistant'];
            nomType = theme['nomType'];
            nomPlaignant = theme['nomPlaignant'];
            prenomPlaignant = theme['prennomPlaignant'];
            numeroPlaignant = theme['telephonePlaignant'];
            quartierPlaignant = theme['quartierPlaignant'];
            villePlaignant = theme['villePlaignant'];
            addressPlaignant = 'addressPlaignant';
            motifPlainte = theme['motifPlainte'];
            created_at = theme['DateCreationplainte'];
            etatPlainteAppel = 'etatPlainteAppel';
            dateNaissancePlaignant = theme['dateNaissancePlaignant'];
            sexe = theme['sexePlaignant'];
            etat_civil = theme['etatcivilPlaignant'];
            email = theme['emailPlaignant'];

            appelsList.add(Appel(
                id,
                nomCategorie,
                moderateur,
                assistant,
                nomType,
                nomPlaignant,
                prenomPlaignant,
                numeroPlaignant,
                quartierPlaignant,
                villePlaignant,
                addressPlaignant,
                motifPlainte,
                created_at,
                etatPlainteAppel,
                libelleShort,
                libelleTxt,
                dateNaissancePlaignant,
                sexe,
                etat_civil,
                email));
          }
          //String body = theme['article'].replaceAll(RegExp(r'\n'), " ");

/**/
        });
      }
      //debugPrint("66666666" + appels_list.toString());
      //appels_list.sort((Appel a, Appel b) => a.id.compareTo(b.id));

      return appelsList;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Echec du chargement des articles');
    }
  }

  logoutUser() async {
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
    Navigator.pushNamed(context, homePageRoute);
    debugPrint("Disconnected User");
  }

  @override
  Widget build(BuildContext context) {
    //removeValues();

    return Scaffold(
      appBar: AppBar(
          title: const Text("Mes appels enregistrées"),
          elevation: 5,
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => logoutUser(),
            ),
          ]),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 50.0),
          child: Stack(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 20.0),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: FutureBuilder(
                      future: getProvincesList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var values = (snapshot.data as List<Appel>).toList();
                          return ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                  top: 0.0, bottom: 60.0), //.all(0.0),
                              scrollDirection: Axis.vertical,
                              primary: true,
                              itemCount: values.length, //data.length,
                              itemBuilder: (BuildContext content, int index) {
                                return buildList(context, index, snapshot);
                              });
                        } else {
                          return Container();
                        }
                      })),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(registerViewRoute);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        splashColor: Colors.white,
        tooltip: 'Enregistrer un appel',
      ),
    );
  }

  Widget buildList(BuildContext context, int index, snapshot) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 110,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /*Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 3, color: secondary),
              image: DecorationImage(
                  image: NetworkImage(schoolLists[index]['logoText']),
                  fit: BoxFit.fill),
            ),
          ),*/
          Expanded(
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, appelDetailsRoute,
                  arguments: snapshot
                      .data[index]), //snapshot.data[index].id.toString()
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    snapshot.data[index].prenomPlaignant +
                        ' ' +
                        snapshot.data[index].prenomPlaignant,
                    style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.location_on,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(snapshot.data[index].libelleShort,
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.school,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                          (snapshot.data[index].nomCategorie.length > 38)
                              ? snapshot.data[index].nomCategorie
                                      .substring(0, 38) +
                                  '...'
                              : snapshot.data[index].nomCategorie,
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  late SharedPreferences _sharedPreferences;

  chkUser() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    var isLoggedIn = _sharedPreferences.getBool('isLoggedIn') ?? false;
    String? uid = await _sharedPreferences.getString('uid');
    String? role = await _sharedPreferences.getString('role');

    Map<String, String?> user = <String, String?>{};
    user['uid'] = uid;
    user['role'] = role;

    if (isLoggedIn) {
      debugPrint('UserIsLoggedIn (appels) - SESSION - ' + uid!);
      Global.Uid = uid;
      Global.Username = _sharedPreferences.getString('name') ?? "Developer";
    } else {
      debugPrint('UserIsLoggedOUT (appels)');
      Navigator.pushNamed(context, loginViewRoute);
    }
  }

  checkpermissions() async {
    bool permissionMicrophone = await Permission.microphone.isGranted;
    bool permissionStorage = await Permission.storage.isGranted;

    //if (await Permission.microphone.request().isGranted) {}
    //if (await Permission.storage.request().isGranted) {}

    if (!permissionMicrophone && !permissionStorage) {
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.microphone,
        Permission.storage,
      ].request();
      print(statuses[Permission.microphone]);
    }

    /*PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.microphone);
    permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission == PermissionStatus.granted) {
    } else {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler().requestPermissions(
              [PermissionGroup.microphone, PermissionGroup.storage]);
    }*/
  }

  static const timeout = const Duration(seconds: 3);
  static const ms = const Duration(milliseconds: 1);

  startTimeout([int? milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    // callback function
    Navigator.of(context).pushNamed('login');
  }

  void getMyPhone() {}
}
