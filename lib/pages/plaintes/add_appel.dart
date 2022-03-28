import 'dart:collection';
import 'dart:convert';
import 'dart:ui';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:yebamibekoapp/pages/plaintes/confirmation_appel.dart';
import 'package:yebamibekoapp/presentation/res/colors.dart';
import 'package:yebamibekoapp/utils/phone_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global.dart';

class AddAppelPage extends StatefulWidget {
  //final int clinique_id;
  const AddAppelPage({Key? key}) : super(key: key);
  @override
  _AddAppelPageState createState() => _AddAppelPageState();
}

class _AddAppelPageState extends State<AddAppelPage> {
  late SharedPreferences _sharedPreferences;
  late bool isLoading = false;
  late String _myActivity;
  late String _myActivityResult;
  late String currentUserId;

  //TextEditingController _assistant = TextEditingController();
  final TextEditingController _motif = TextEditingController();
  final TextEditingController _libelle = TextEditingController();
  final TextEditingController _porte = TextEditingController();
  final TextEditingController _lieucommission = TextEditingController();
  final TextEditingController _datedefait = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
    currentUserId = '';
    chkUser(currentUserId);
    checkpermissions();
  }

  chkUser(currentUserId) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var isLoggedIn = _sharedPreferences.getBool('isLoggedIn') ?? false;
    String? uid = await _sharedPreferences.getString('uid');

    if (isLoggedIn) {
      debugPrint('UserIsLoggedIn - ' + uid!);
      currentUserId = uid;
      Global.Uid = uid;
      Global.Username = _sharedPreferences.getString('name') ?? "Developer";
    } else {
      debugPrint('UserIsLoggedOUT');
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

  Future<List<Map<String, dynamic>>?> getCentreList() async {
    //debugPrint('000000000000000000');
    try {
      var response = await http
          .get(Uri.parse('http://app.yebamibeko.org/api/retrieve/centres/all'));
      debugPrint("2222222 (add_appel)" + response.body.toString());
      var dataDecoded = json.decode(response.body);
      //Map<String, dynamic> entry = Map<String, dynamic>();
      List<Map<String, dynamic>> datasource = <Map<String, dynamic>>[];
      if (response.statusCode == 200) {
        dataDecoded.forEach((theme) {
          //entry['display'] = theme['name'];
          //entry['value'] = theme['id'];
          //String val = theme['id'].toString() + '_' + theme['id'].toString();
          datasource.add({
            'display': (theme['nom'].toString().length > 28)
                ? theme['nom'].substring(0, 28) + '...'
                : theme['nom'],
            'value': theme['id'].toString()
          });
        });
        /*
      }}*/
        debugPrint("-----------------------------" + datasource.toString());
        return datasource; //List<dynamic>.from(dataDecoded);
      } else {
        Fluttertoast.showToast(
          msg: 'Reponse serveur incorrect. Réessayez plus tard',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    //Future<List> posts = PostDatabaseProvider.db.getAllPosts();
    //return posts;
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'One';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Me plaindre'),
        elevation: 5,
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
          child: FutureBuilder(
              future: getCentreList(),
              builder: (context, snapshot) {
                debugPrint("++++++++++ " + snapshot.data.toString());
                if (snapshot.hasData) {
                  List<dynamic> mapdata = snapshot.data as List<dynamic>;
                  return Container(
                      color: Colors.grey.withOpacity(0.1),
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 20.0, right: 20.0, bottom: 40.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: const Text(
                              "Remplir le formulaire pour enregistrer ma plainte",
                              style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.yellow[300],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: DropDownFormField(
                                    titleText: 'Clinique juridique',
                                    hintText: 'Choisissez une clinique',
                                    value: _myActivity,
                                    onSaved: (value) {
                                      setState(() {
                                        _myActivity = value;
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _myActivity = value;
                                      });
                                    },
                                    dataSource: mapdata, //snapshot.data,
                                    textField: 'display',
                                    valueField: 'value',
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: const Text(
                                    "En quoi pouvons-nous vous aider ?",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                ),
                                /*SizedBox(
                                  height: 20,
                                ),
                                DropDownFormField(
                                  titleText: 'Catégorie',
                                  hintText: 'Choisissez une catégorie',
                                  value: _myActivity,
                                  onSaved: (value) {
                                    setState(() {
                                      _myActivity = value;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _myActivity = value;
                                    });
                                  },
                                  dataSource: snapshot.data,
                                  textField: 'display',
                                  valueField: 'value',
                                ),*/
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: _porte,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Porte d'entrée",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)))),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: _lieucommission,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Lieu commission",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)))),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: _datedefait,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Date des faits",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)))),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: _motif,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: /*"Name"*/ "Quel est le motif de votre plainte ?",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)))),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: _libelle,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: /*"Name"*/ "Racontez-nous...",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)))),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue[900],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  child: InkWell(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    splashColor: Colors.white,
                                    onTap: () async {
                                      isLoading = true;
                                      setState(() {});

                                      if (_libelle.text == null ||
                                          _libelle.text == "" ||
                                          _motif.text == "" ||
                                          _motif.text == null) {
                                        Fluttertoast.showToast(
                                            msg: "Tous les champs sont requis");
                                      } else {
                                        debugPrint('iiiiiiiiiiiiiiiiiiiiii' +
                                            currentUserId);
                                        List list = _myActivity.split('_');
                                        await http.post(
                                            Uri.parse(
                                                "http://app.yebamibeko.org/api/registerAppel"),
                                            body: {
                                              'user_id': currentUserId,
                                              'clinique': list[0],
                                              'lieucommission': _lieucommission
                                                  .text
                                                  .toString(),
                                              'datedefait':
                                                  _datedefait.text.toString(),
                                              'categorie': '7',
                                              'motif': _motif.text.toString(),
                                              'libelle':
                                                  _libelle.text.toString(),
                                              'porte': _porte.text.toString(),
                                              'api': "hj4xUON83bXWPZK85Ihn"
                                            }).then((response) async {
                                          var parsedJson =
                                              jsonDecode(response.body);

                                          if (parsedJson['success'] == true) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Votre plainte a bien été enregistrée. Nous vous contaterons.');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AppelConfirmationPage()),
                                            );
                                            /*Navigator.of(context).pushNamed(
                                                appelConfirmationRoute);*/
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: 'Echec de la requêtte');
                                          }
                                          print(response.body);
                                        });
                                      }
                                      isLoading = false;
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Center(
                                          child: isLoading
                                              ? CircularProgressIndicator(
                                                  backgroundColor: Colors.white,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Global.MainColor),
                                                )
                                              : Text(
                                                  "Enregistrer",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                )),
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ],
                      ));
                } else {
                  return Container(
                    padding: const EdgeInsets.all(40.0),
                    child: const Center(
                      child: Text('Patientez...',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  );
                }
              })),
    );
  }
}
