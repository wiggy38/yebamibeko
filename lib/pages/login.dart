import 'dart:convert';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:yebamibekoapp/models/user.dart';
import 'package:yebamibekoapp/pages/plaintes/appels.dart';
import 'package:yebamibekoapp/pages/plaintes/appels_prestataire.dart';
import 'package:yebamibekoapp/pages/register_user.dart';
import 'package:yebamibekoapp/utils/phone_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yebamibekoapp/pages/global.dart';
//import 'package:flutter_session/flutter_session.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  late SharedPreferences _sharedPreferences;

  TextEditingController textEditingController = new TextEditingController();
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chkUser();
    checkpermissions();
  }

  void chkUser() async {
    //String uid = await _sharedPreferences.getString('uid');
    /*Future uid = FlutterSession().get('userid');
    Future role = FlutterSession().get('role');
    Map<String, String> user = new Map<String, String>();
    user['uid'] = uid.toString();
    user['role'] = role.toString();*/

    _sharedPreferences = await SharedPreferences.getInstance();
    var isLoggedIn = _sharedPreferences.getBool('isLoggedIn') ?? false;
    String? uid = await _sharedPreferences.getString('uid');

    if (isLoggedIn) {
      Global.Uid = uid as String;
      Global.Username = _sharedPreferences.getString('name') ?? "Developer";
      Navigator.pushNamed(context, appelsRoute, arguments: uid);
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, homePageRoute);
        /*Fluttertoast.showToast(
          msg:
              'Some text!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
        );*/
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              "Connexion",
              style: TextStyle(color: Colors.yellow),
            ),
            actions: <Widget>[
              // action button
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () => Navigator.pop(context),
              ),
              // action button
              /*IconButton(
              icon: Icon(Icons.close),
              onPressed: () => logoutUser(),
            ),*/
            ]),
        body: Container(
          decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage('assets/rubriq_actualites.jpg'),fit: BoxFit.cover),
              color: Global.MainColor),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "J'ai un pseudnyme et un mot de passe. Je me connecte",
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _username,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Nom d'utilisateur",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                        keyboardType: TextInputType.text,
                        /*inputFormatters: [
                        PhoneFormatter(),
                        //WhitelistingTextInputFormatter(RegExp("/00234[0-9]{10}/")),
                      ],*/
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _password,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: /*"Password"*/ "Mot de passe",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                splashColor: Colors.red,
                                onTap: () async {
                                  isLoading = true;
                                  setState(() {});

                                  if (_username.text == "" ||
                                      _password.text == "") {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Vous devez entrer un nom d'utilisateur et un mot de passe");
                                  } else {
                                    await http.post(
                                        Uri.parse(
                                            "http://app.yebamibeko.org/api/login"),
                                        body: {
                                          'username': _username.text.toString(),
                                          'password': _password.text.toString(),
                                          'api': "hj4xUON83bXWPZK85Ihn"
                                        }).then((response) async {
                                      //Fluttertoast.showToast(msg: response.body);

                                      var parsedJson =
                                          jsonDecode(response.body);

                                      if (parsedJson['success'] == true) {
                                        debugPrint(
                                            parsedJson['result'].toString());

                                        // Set global values
                                        Global.Uid = _username.text.toString();
                                        Global.Username =
                                            "baseuser1"; //parsedJson['result']['username'];
                                        Global.Role =
                                            parsedJson['result']['slug'];

                                        debugPrint(
                                            parsedJson['result']['slug']);

                                        // Set shared Prefs values
                                        _sharedPreferences =
                                            await SharedPreferences
                                                .getInstance();
                                        _sharedPreferences.setBool(
                                            "isLoggedIn", true);
                                        _sharedPreferences.setString(
                                            'uid',
                                            parsedJson['result']['idUser']
                                                .toString());
                                        _sharedPreferences.setString('username',
                                            "baseuser1"); //parsedJson['result']['username']);
                                        _sharedPreferences.setString('role',
                                            parsedJson['result']['slug']);

                                        //Set User object
                                        User user = User(
                                            parsedJson['result']['idUser']
                                                .toString(),
                                            "baseuser1",
                                            //parsedJson['result']['username'],
                                            parsedJson['result']['slug']);
                                        /*Fluttertoast.showToast(
                                          msg: '*******' +
                                              parsedJson['result']['id']
                                                  .toString());*/
                                        if (parsedJson['result']['slug'] ==
                                            'ROLE_PVV') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AppelsList(
                                                      userid:
                                                          int.parse(user.id),
                                                    )),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AppelsListPrestaire(
                                                        userid: int.parse(
                                                            user.id))), //
                                          );
                                          debugPrint('ffffffffffffff');
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Nom d'utilisateur ou Mot de passe invalide.");
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
                                                  AlwaysStoppedAnimation<Color>(
                                                      Global.MainColor),
                                            )
                                          : const Text(
                                              /*"Login"*/ "Connexion",
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
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterBaseUserPage()), //RegisterBaseUserPage
                      );
                      //Navigator.pushNamed(context, registerBeneficiaireRoute);
                    },
                    child: const Text(
                      "Je veux m'enregistrer ici.",
                      style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*


bool reg = false ;

await Firestore.instance.collection('users').document(textEditingController.text).get().then(
(ds){
if( ds.data==null){
reg =false;
}else{
reg=true;
}
}
)
;

if(reg)
{
print("Already Registered");

}else {
Firestore.instance.collection('users')
    .document(textEditingController.text)
    .setData({});
print("New Registration");
}
Navigator.of(context).pushNamed('chat');*/
