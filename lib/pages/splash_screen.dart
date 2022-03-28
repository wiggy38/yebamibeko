import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yebamibekoapp/pages/home_page.dart';
import 'package:yebamibekoapp/utils/flutkart.dart';
//import 'package:yebamibeko_app/utils/my_navigator.dart';
import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:yebamibekoapp/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyHomePage(
                        title: 'Yeba Mibeko',
                      )),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            //decoration: BoxDecoration(color: Colors.blueAccent),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.5),
              image: DecorationImage(
                image: AssetImage('assets/images/rubriq_actualites.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 120.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0.0),
                          image: DecorationImage(
                            image: AvailableImages.unescoLogo,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        Flutkart.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      Flutkart.store,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
