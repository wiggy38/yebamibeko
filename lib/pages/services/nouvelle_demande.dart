import 'dart:collection';
import 'dart:convert';
import 'dart:ui';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:yebamibekoapp/pages/services/services.dart';
import 'package:yebamibekoapp/presentation/res/colors.dart';
import 'package:yebamibekoapp/utils/phone_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global.dart';

class NouvelleDemandePage extends StatefulWidget {
  //int clinique_id;
  //AddAppelPage({Key key}) : super(key: key);
  @override
  _NouvelleDemandePageState createState() => _NouvelleDemandePageState();
}

class _NouvelleDemandePageState extends State<NouvelleDemandePage> {
  late SharedPreferences _sharedPreferences;
  bool isLoading = false;
  late String _type;
  late String _myActivityResult;
  late String current_user_id;

  TextEditingController _username = new TextEditingController();
  TextEditingController _categorie = new TextEditingController();
  //TextEditingController _assistant = new TextEditingController();
  TextEditingController _nom = new TextEditingController();
  TextEditingController _prenom = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _quartier = new TextEditingController();
  TextEditingController _ville = new TextEditingController();
  TextEditingController _motif = new TextEditingController();
  TextEditingController _libelle = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _etatcivil = new TextEditingController();
  TextEditingController _age = new TextEditingController();
  TextEditingController _sexe = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _passwordConfirm = new TextEditingController();
  TextEditingController _porte = new TextEditingController();
  TextEditingController _genre = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _type = '';
    _myActivityResult = '';
    chkUser();
    checkpermissions();
  }

  Future<Map<String, String>> chkUser() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var isLoggedIn = _sharedPreferences.getBool('isLoggedIn') ?? false;
    String uid = await _sharedPreferences.getString('uid') ?? '';
    String role = await _sharedPreferences.getString('role') ?? '';

    Map<String, String> user = <String, String>{};
    user['uid'] = uid;
    user['role'] = role;

    if (isLoggedIn) {
      debugPrint('UserIsLoggedIn - ' + uid);
      Global.Uid = uid;
      Global.Username = _sharedPreferences.getString('name') ?? "Developer";
    } else {
      debugPrint('UserIsLoggedOUT');
      Navigator.pushNamed(context, loginViewRoute);
    }
    return user;
  }

  checkpermissions() async {
    bool permissionMicrophone = await Permission.microphone.isGranted;
    bool permissionStorage = await Permission.storage.isGranted;

    //if (await Permission.microphone.request().isGranted) {}
    //if (await Permission.storage.request().isGranted) {}

    //if (!permissionMicrophone && !permissionStorage) {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.microphone,
      Permission.storage,
    ].request();
    print(statuses[Permission.microphone]);
    //}

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

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'One';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Faire une demande de service'),
        elevation: 5,
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
          child: FutureBuilder(
              future: chkUser(),
              builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
                debugPrint("***********" + snapshot.data.toString());
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
                            "Remplir une demande de service",
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
                                  titleText:
                                      'Quelle demande souhaitez-vous remplir ?',
                                  hintText: 'Choisissez une demande',
                                  value: _type,
                                  onSaved: (value) {
                                    setState(() {
                                      _type = value;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _type = value;
                                    });
                                  },
                                  dataSource: const [
                                    {
                                      'display':
                                          'Référencement et contre-référence...',
                                      'value':
                                          'Référencement et contre-référencement'
                                    },
                                    {
                                      'display':
                                          'Information & Sensibilisation.',
                                      'value': 'Information et Sensibilisation'
                                    },
                                    {
                                      'display':
                                          'Aides psycho sociales & Juridiques',
                                      'value':
                                          'Aides psycho sociales et Juridiques'
                                    }
                                  ],
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
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _libelle,
                                keyboardType: TextInputType.multiline,
                                maxLines: 10,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: /*"Name"*/ "Précisez ici le contenu de votre demande...",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue[900],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: Material(
                                color: Colors.transparent,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  splashColor: Colors.white,
                                  onTap: () async {
                                    isLoading = true;
                                    setState(() {});

                                    if (_libelle.text == null ||
                                        _libelle.text == "") {
                                      Fluttertoast.showToast(
                                          msg: "Tous les champs sont requis");
                                    } else {
                                      await http.post(
                                          Uri.parse(
                                              "http://app.yebamibeko.org/api/registerService"),
                                          body: {
                                            'user_id': snapshot.data!['uid'],
                                            'type': _type,
                                            'contenu': _libelle.text.toString(),
                                            'api': "hj4xUON83bXWPZK85Ihn"
                                          }).then((response) async {
                                        var parsedJson =
                                            jsonDecode(response.body);

                                        if (parsedJson['success'] == true) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Votre demande a bien été enregistrée!');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ServicesPage()),
                                          );

                                          /*Navigator.of(context)
                                              .pushNamed(servicesPageRoute);*/
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: 'Echec de la requêtte');
                                        }
                                        debugPrint(response.body);
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
                                            : const Text(
                                                "Enregistrer ma demande",
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
              })),
    );
  }
}
