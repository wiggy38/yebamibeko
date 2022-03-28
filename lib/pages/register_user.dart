import 'dart:collection';
import 'dart:convert';
import 'dart:ui';

import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:yebamibekoapp/models/user.dart';
import 'package:yebamibekoapp/presentation/res/colors.dart';
import 'package:yebamibekoapp/utils/date_formatter.dart';
import 'package:yebamibekoapp/utils/phone_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart';

class RegisterBaseUserPage extends StatefulWidget {
  @override
  _RegisterBaseUserPageState createState() => _RegisterBaseUserPageState();
}

class _RegisterBaseUserPageState extends State<RegisterBaseUserPage> {
  late SharedPreferences _sharedPreferences;
  bool isLoading = false;
  late String _myActivity;
  late String _myActivityResult;
  late String current_user_id;

  final TextEditingController _username = TextEditingController();
  final TextEditingController _nom = TextEditingController();
  final TextEditingController _prenom = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
    current_user_id = '';
    chkUser(current_user_id);
    checkpermissions();
  }

  chkUser(currentUserId) async {
    _sharedPreferences = await SharedPreferences.getInstance();

    String? uid = await _sharedPreferences.getString('uid');
    currentUserId = uid;

    if (uid == null) {
      // Navigator.of(context).pushNamed('login');
    } else {
      Global.Uid = uid;
      Global.Username = _sharedPreferences.getString('name') ?? "Developer";
      Navigator.pushNamed(context, appelsRoute, arguments: uid);
      //Navigator.of(context).pushReplacementNamed('usersList');
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
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'One';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Inscription'),
        elevation: 5,
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
          child: Container(
              color: Colors.grey.withOpacity(0.1),
              padding: const EdgeInsets.only(
                  top: 40.0, left: 20.0, right: 20.0, bottom: 40.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Text(
                      "Remplir le formulaire pour m'inscrire",
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
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.yellow[300],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  "Informations de connexion",
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
                                controller: _username,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: /*"Name"*/ "Choisissez un pseudonyme",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                selectionHeightStyle: BoxHeightStyle.tight,
                                controller: _password,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Entrez un mot de passe",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                                obscureText: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _passwordConfirm,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Confirmez votre mot de passe",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                                obscureText: true,
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
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
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                child: const Text(
                                  "Informations personnelles",
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
                                controller: _nom,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: /*"Name"*/ "Votre nom",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _prenom,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: /*"Name"*/ "Votre prénom",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _phone,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: /*"Phone Number"*/ "Numéro de téléphone",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  PhoneFormatter(),
                                  //WhitelistingTextInputFormatter(RegExp("/00234[0-9]{10}/")),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _email,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: /*"Name"*/ "Votre adresse e-mail",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                                keyboardType: TextInputType.emailAddress,
                              )
                            ],
                          ),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            splashColor: Colors.white,
                            onTap: () async {
                              isLoading = true;
                              setState(() {});

                              if (_nom.text == null ||
                                  _nom.text == "" ||
                                  _password.text == "" ||
                                  _password.text == null) {
                                List list = _myActivity.split('_');
                                Fluttertoast.showToast(
                                    msg: "Veuillez remplir tous les champs");
                              } else {
                                //List list = _myActivity.split('_');
                                debugPrint(' clinique_id=' +
                                    ' last_name=' +
                                    _nom.text.toString() +
                                    ' first_name=' +
                                    _prenom.text.toString() +
                                    ' phone=' +
                                    _phone.text.toString() +
                                    ' email=' +
                                    _email.text.toString() +
                                    ' username=' +
                                    _username.text.toString() +
                                    ' password=' +
                                    _password.text.toString() +
                                    ' api=' +
                                    'hj4xUON83bXWPZK85Ihn');
                                await http.post(
                                    Uri.parse(
                                        "http://app.yebamibeko.org/api/registerBaseUser"),
                                    body: {
                                      'clinique_id':
                                          '1', //_clinique.text.toString(),
                                      'assistant': '1',
                                      'last_name': _nom.text.toString(),
                                      'first_name': _prenom.text.toString(),
                                      'phone': _phone.text.toString(),
                                      'email': _email.text.toString(),
                                      'username': _username.text.toString(),
                                      'password': _password.text.toString(),
                                      'api': "hj4xUON83bXWPZK85Ihn"
                                    }).then((response) async {
                                  var parsedJson = jsonDecode(response.body);

                                  if (parsedJson['success'] == true) {
                                    debugPrint('yyyyyyyyyyyyyyyyyyyyyyyy' +
                                        parsedJson['resultats'].toString());
                                    // Set global values
                                    Global.Uid = _username.text.toString();
                                    Global.Role =
                                        parsedJson['resultats']['slug'];
                                    Global.Username =
                                        parsedJson['resultats']['username'];
                                    // Set shared Prefs values
                                    _sharedPreferences =
                                        await SharedPreferences.getInstance();

                                    //Set User object
                                    User user = User(
                                        parsedJson['resultats']['id']
                                            .toString(),
                                        parsedJson['resultats']['username'],
                                        parsedJson['resultats']['slug']);
                                    //Redirect
                                    Navigator.pushNamed(
                                        context, loginViewRoute);
                                    //Navigator.of(context).pushNamed(appelsRoute, arguments: user);
                                  } else {
                                    print('RESPONSE ' + response.body);
                                    Fluttertoast.showToast(
                                        msg:
                                            "L'enregistrement a échoué! Veuillez réessayer");
                                  }
                                  print('RESPONSE ' + response.body);
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
                                              AlwaysStoppedAnimation<Color>(
                                                  Global.MainColor),
                                        )
                                      : const Text(
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
              ))),
    );
  }
}
